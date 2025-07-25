<#
.SYNOPSIS
    Runs SpiWare Lua obfuscator.

.PARAMETER InputFile
    Path to the input LuaU file to obfuscate. Default: main.luau

.PARAMETER OutputFile
    Path to save the obfuscated output file. Default: main.obfuscated.luau

.PARAMETER LuaExe
    Path to the Lua executable. Default: lua\lua5.1.exe

.PARAMETER CliLua
    Path to the obfuscator cli.lua file. Default: obfuscator\cli.lua

.PARAMETER TimeoutSec
    Maximum time in seconds to wait for the obfuscator process. Default: 60 seconds.

.EXAMPLE
    ./obfuscate.ps1 -InputFile "script.luau" -OutputFile "script.obf.luau"

#>

[CmdletBinding()]
param (
    [string]$InputFile = "",
    [string]$OutputFile = "",
    [string]$LuaExe = "",
    [string]$CliLua = "",
    [int]$TimeoutSec = 60
)

function Write-VerboseLog {
    param($Message)
    if ($PSCmdlet.MyInvocation.BoundParameters.ContainsKey('Verbose')) {
        Write-Verbose $Message
    }
}

function Get-RepoRoot {
    $ScriptPath = Switch ($Host.Name) {
        "Visual Studio Code Host" { Split-Path $psEditor.GetEditorContext().CurrentFile.Path; break }
        "Windows PowerShell ISE Host" { Split-Path -Path $psISE.CurrentFile.FullPath; break }
        "ConsoleHost" { $PSScriptRoot; break }
        Default { (Get-Location).Path; break }
    }
    return $ScriptPath
}

function Test-FilePath {
    param($Path, $Description)
    if (-not (Test-Path -LiteralPath $Path)) {
        Throw "$Description '$Path' does not exist."
    }
}

function Start-Obfuscator {
    param(
        [string]$LuaExePath,
        [string]$CliLuaPath,
        [string]$InputPath,
        [string]$OutputPath,
        [int]$TimeoutSec
    )

    $ObfuscatorArgs = @(
        $CliLuaPath,
        "--preset", "Strong",
        "--LuaU",
        "--nocolors",
        "--out", $OutputPath,
        $InputPath
    )

    Write-VerboseLog "Running obfuscator: $LuaExePath $($ObfuscatorArgs -join ' ')"

    $proc = Start-Process -FilePath $LuaExePath -ArgumentList $ObfuscatorArgs -NoNewWindow -PassThru -Wait -ErrorAction Stop

    if ($proc.ExitCode -ne 0) {
        Throw "Obfuscator exited with code $($proc.ExitCode)."
    }
}

function Get-FileSHA256 {
    param([string]$FilePath)

    if (-not (Test-Path -LiteralPath $FilePath)) {
        Throw "File for hashing '$FilePath' not found."
    }

    $sha256 = [System.Security.Cryptography.SHA256]::Create()
    try {
        $stream = [System.IO.File]::OpenRead($FilePath)
        $hashBytes = $sha256.ComputeHash($stream)
        $stream.Dispose()
        return ([BitConverter]::ToString($hashBytes)).Replace("-", "").ToLower()
    }
    finally {
        $sha256.Dispose()
    }
}

function Add-Banner {
    param(
        [string]$FilePath,
        [string]$BannerText
    )

    if (-not (Test-Path -LiteralPath $FilePath)) {
        Throw "File to prepend banner '$FilePath' not found."
    }

    Write-VerboseLog "Prepending banner to file: $FilePath"

    $originalContent = Get-Content -Path $FilePath -Raw -Encoding UTF8
    $newContent = $BannerText + "`n`n" + $originalContent
    Set-Content -Path $FilePath -Value $newContent -Encoding UTF8

    Write-Host "Banner prepended successfully."
}

function Main {
    $repoRoot = Get-RepoRoot

    if ([string]::IsNullOrWhiteSpace($InputFile)) { $InputFile = Join-Path $repoRoot "main.luau" }
    if ([string]::IsNullOrWhiteSpace($OutputFile)) { $OutputFile = Join-Path $repoRoot "main.obfuscated.luau" }
    if ([string]::IsNullOrWhiteSpace($LuaExe)) { $LuaExe = Join-Path $repoRoot "lua\lua5.1.exe" }
    if ([string]::IsNullOrWhiteSpace($CliLua)) { $CliLua = Join-Path $repoRoot "obfuscator\cli.lua" }

    Write-Host "Current working directory: $repoRoot"
    Write-Host "Input file: $InputFile"
    Write-Host "Output file: $OutputFile"
    Write-Host "Lua executable: $LuaExe"
    Write-Host "CLI Lua script: $CliLua"

    try {
        Test-FilePath -Path $LuaExe -Description "Lua executable"
        Test-FilePath -Path $CliLua -Description "Obfuscator CLI script"
        Test-FilePath -Path $InputFile -Description "Input file"
    }
    catch {
        Write-Error $_
        exit 1
    }

    $maxRetries = 3
    $retryDelaySec = 2
    $attempt = 0
    $success = $false

    while (-not $success -and $attempt -lt $maxRetries) {
        try {
            $attempt++
            if ($attempt -gt 1) {
                Write-Warning "Previous obfuscation attempt failed. Retrying attempt $attempt of $maxRetries after $retryDelaySec seconds..."
                Start-Sleep -Seconds $retryDelaySec
            }

            Start-Obfuscator -LuaExePath $LuaExe -CliLuaPath $CliLua -InputPath $InputFile -OutputPath $OutputFile -TimeoutSec $TimeoutSec
            $success = $true
        }
        catch {
            if ($attempt -ge $maxRetries) {
                Write-Error "Obfuscator failed after $maxRetries attempts. Last error: $_"
                exit 1
            }
        }
    }

    Write-Host "Obfuscation completed successfully."

    try {
        $sha256Hash = Get-FileSHA256 -FilePath $OutputFile
    }
    catch {
        Write-Error "Error calculating SHA256: $_"
        exit 1
    }

    $dateUTC = (Get-Date).ToUniversalTime().ToString("o")

    $banner = @"
--[[
  ___      ___      __
 / __|_ __(_) \    / /_ _ _ _ ___
 \__ \ '_ \ |\ \/\/ / _` | '_/ -_)
 |___/ .__/_| \_/\_/\__,_|_| \___|
     |_|

This file was obfuscated using SpiWare's obfuscation pipeline.
https://github.com/Spynetics/SpiWare

$dateUTC UTC
$sha256Hash

------------------------------------------------------------
This file is obfuscated. Editing or reverse-engineering is
discouraged and may break functionality.
--]]
"@

    try {
        Add-Banner -FilePath $OutputFile -BannerText $banner
    }
    catch {
        Write-Error "Error prepending banner: $_"
        exit 1
    }
}

Main

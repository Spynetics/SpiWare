local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/ftnick/Spiware/refs/heads/main/libs/windui.luau"))()

local HttpService = game:GetService("HttpService")
local MarketplaceService = game:GetService("MarketplaceService")

local LoaderVer = "0.0.2"
local versionApiUrl = "https://api.github.com/repos/Spynetics/SpiWare/contents/versions"

local function parseVersion(ver)
    local major, minor, patch = ver:match("v?(%d+)%.(%d+)%.(%d+)")
    return tonumber(major or 0), tonumber(minor or 0), tonumber(patch or 0)
end

local function isVersionHigher(v1, v2)
    local maj1, min1, pat1 = parseVersion(v1)
    local maj2, min2, pat2 = parseVersion(v2)
    if maj1 ~= maj2 then return maj1 > maj2 end
    if min1 ~= min2 then return min1 > min2 end
    return pat1 > pat2
end

task.spawn(function()
    local ok, response = pcall(function()
        return game:HttpGet(versionApiUrl)
    end)

    if not ok then
        warn("Failed to fetch versions folder list:", response)
        return
    end

    local decodeOk, files = pcall(function()
        return HttpService:JSONDecode(response)
    end)

    if not decodeOk then
        warn("Failed to decode versions JSON:", files)
        return
    end

    local highestVer = LoaderVer

    for _, file in ipairs(files) do
        if file.type == "dir" then
            local folderVer = file.name
            if isVersionHigher(folderVer, highestVer) then
                highestVer = folderVer
            end
        end
    end

    if isVersionHigher(highestVer, LoaderVer) then
        WindUI:Notify({
            Title = "Update Available",
            Icon = "cloud-download",
            Content = "A newer SpiWare loader version (" .. highestVer .. ") is available on GitHub.",
            Duration = 15
        })
    end
end)

WindUI:SetNotificationLower(true)
WindUI:AddTheme({
    Name = "theme",
    Accent = "#111111",
    Dialog = "#111111",
    Outline = "#facc15",
    Text = "#fefce8",
    Placeholder = "#fcd34d",
    Background = "#0b0b0d",
    Button = "#ff9248",
    Icon = "#fdba74",
})

local MainWindow = WindUI:CreateWindow({
    Title = "SpiWare",
    Icon = "scan-eye",
    Author = "@ftnick",
    Folder = "SpiWareConfigV1",
    Size = UDim2.fromOffset(580, 460),
    Transparent = false,
    Theme = "theme",
    Resizable = true,
    SideBarWidth = 200,
    Background = "rbxassetid://92861942655141",
    BackgroundImageTransparency = 0.85,
    HideSearchBar = true,
    ScrollBarEnabled = false,
    User = {
        Enabled = true,
        Anonymous = true,
    },
})

MainWindow:DisableTopbarButtons({ "Fullscreen" })
MainWindow:SetToggleKey(Enum.KeyCode.H)
MainWindow:EditOpenButton({
    Title = "Open SpiWare",
    CornerRadius = UDim.new(0, 16),
    StrokeThickness = 2,
    OnlyMobile = false,
    Enabled = true,
    Draggable = true,
})

local HomeTab = MainWindow:Tab({ Title = "Home", Icon = "house" })
local ScriptsTab = MainWindow:Tab({ Title = "Scripts", Icon = "scroll-text" })
local SettingsTab = MainWindow:Tab({ Title = "Settings", Icon = "settings" })
local PremiumTab = MainWindow:Tab({ Title = "Premium", Icon = "hand-coins", Locked = true })
MainWindow:SelectTab(1)

SettingsTab:Keybind({
    Title = "Toggle Key",
    Desc = "Keybind to open/close UI",
    Value = "H",
    Callback = function(key)
        MainWindow:SetToggleKey(Enum.KeyCode[key])
    end,
})

HomeTab:Section({ Title = "Introduction", TextXAlignment = "Left" })
HomeTab:Paragraph({
    Title = "Information",
    Desc = table.concat({
        "Welcome to SpiWare, a free Roblox exploit supporting an increasing number of games.",
        "Developed and maintained by @ftnick on GitHub.",
        "Visit: https://github.com/Spynetics/SpiWare for details and updates."
    }, "\n"),
})

HomeTab:Paragraph({
    Title = "Credits",
    Desc = table.concat({
        "Special thanks to:",
        "   @ftnick - Lead Developer and Maintainer",
        "   @leesincerely - Developer",
        "   WindUI - UI Library"
    }, "\n"),
})

HomeTab:Section({ Title = "How to Use", TextXAlignment = "Left" })
HomeTab:Paragraph({
    Title = "Guide",
    Desc = "Navigate to the Scripts tab to load scripts for your current game. If no specific scripts are found, universal scripts will load automatically."
})

local apiUrl = "https://api.github.com/repos/Spynetics/SpiWare/contents/scripts"
local rawUrlBase = "https://raw.githubusercontent.com/Spynetics/SpiWare/main/scripts/"

local success, response = pcall(function()
    return game:HttpGet(apiUrl)
end)

if not success then
    warn("Failed to fetch GitHub API contents:", response)
    return
end

local decodeSuccess, files = pcall(function()
    return HttpService:JSONDecode(response)
end)

if not decodeSuccess then
    warn("Failed to decode GitHub API response:", files)
    return
end

local placeId = game.PlaceId
local compatibleScripts, incompatibleScripts = {}, {}
local universalScript = nil
local metadataMap = {}

for _, file in ipairs(files) do
    if file.name:match("%.metadata%.json$") then
        local baseName = file.name:gsub("%.metadata%.json$", "")
        local ok, metadataRaw = pcall(function()
            return game:HttpGet(rawUrlBase .. baseName .. ".metadata.json")
        end)
        if ok then
            local decoded, metadata = pcall(function()
                return HttpService:JSONDecode(metadataRaw)
            end)
            if decoded then
                metadataMap[baseName] = metadata
            end
        end
    end
end

for _, file in ipairs(files) do
    if file.name:match("%.luau$") then
        local baseName = file.name:gsub("%.luau$", "")
        local metadata = metadataMap[baseName]

        if baseName == "universal" then
            universalScript = file
        elseif metadata and metadata.gameID == placeId then
            table.insert(compatibleScripts, { name = baseName, url = rawUrlBase .. file.name, meta = metadata })
        else
            table.insert(incompatibleScripts, { name = baseName, url = rawUrlBase .. file.name, meta = metadata })
        end
    end
end

local function getGameNameFromID(gameID)
    local success, info = pcall(function()
        return MarketplaceService:GetProductInfo(gameID)
    end)
    if success and info and info.Name then
        return info.Name
    else
        return "Unknown Game"
    end
end

local function addScriptButton(tab, script)
    local author = script.meta and script.meta.author
    local title = "'" .. script.name .. "'"
    if author then
        title = title .. " by " .. author
        if author == "@ftnick" then
            title = title .. " " .. utf8.char(0xE000)
        end
    end

    tab:Button({
        Title = title,
        Desc = (script.meta and script.meta.description or "No description") ..
       "\n( " .. getGameNameFromID(script.meta and script.meta.gameID or 0) .. " )",
        Locked = false,
        Callback = function()
            local success, result = pcall(function()
                return game:HttpGet(script.url)
            end)

            if not success then
                WindUI:Notify{
                    Title = "Load Failed",
                    Icon = "circle-x",
                    Content = "Failed to fetch the script from GitHub.\nError: " .. tostring(result),
                    Duration = 10
                }
                return
            end

            local func, loadErr = loadstring(result)
            if func then
                local execSuccess, execErr = pcall(func)
                if execSuccess then
                    WindUI:Notify{
                        Title = "Script Loaded",
                        Icon = "circle-check",
                        Content = "'" .. script.name .. "' loaded and executed successfully.",
                        Duration = 5
                    }
                else
                    WindUI:Notify{
                        Title = "Execution Failed",
                        Icon = "triangle-alert",
                        Content = "The script loaded but failed to execute.\nError: " .. tostring(execErr),
                        Duration = 10
                    }
                end
            else
                WindUI:Notify{
                    Title = "Loadstring Failed",
                    Icon = "octagon-x",
                    Content = "Failed to compile the script.\nError: " .. tostring(loadErr),
                    Duration = 10
                }
            end
        end,
    })
end


if #compatibleScripts > 0 then
    ScriptsTab:Section({ Title = "Supported Scripts" })
    for _, script in ipairs(compatibleScripts) do
        addScriptButton(ScriptsTab, script)
    end
elseif universalScript then
    ScriptsTab:Section({ Title = "Universal Fallback Script", TextXAlignment = "Left" })
    ScriptsTab:Button({
        Title = "Universal Script",
        Desc = "A simple fallback script usable across games.",
        Locked = false,
        Callback = function()
            local code = game:HttpGet(rawUrlBase .. universalScript.name)
            local f, err = loadstring(code)
            if f then pcall(f) else warn("Script load failed:", err) end
        end,
    })
else
    ScriptsTab:Paragraph({
        Title = "No Scripts Available",
        Desc = "No compatible or fallback scripts found for this game.",
    })
end

if #incompatibleScripts > 0 then
    ScriptsTab:Section({ Title = "Other Scripts (Not Supported)", TextXAlignment = "Left" })
    for _, script in ipairs(incompatibleScripts) do
        addScriptButton(ScriptsTab, script)
    end
end

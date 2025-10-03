_G.HeadSize = _G.HeadSize or 6

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local running = true
local connections = {}

local function safeSetProps(hrp, isEnemy, teamColor)
    local ok, err = pcall(function()
        if isEnemy then
            hrp.Size = Vector3.new(_G.HeadSize, _G.HeadSize, _G.HeadSize)
            hrp.Transparency = 0.8
            hrp.BrickColor = teamColor
            hrp.Material = Enum.Material.Neon
            hrp.CanCollide = false
        else
            hrp.Size = Vector3.new(2, 2, 1)
            hrp.Transparency = 1
            hrp.BrickColor = BrickColor.new("Medium stone grey")
            hrp.Material = Enum.Material.Plastic
            hrp.CanCollide = true
        end
    end)
    if not ok then
        warn("[HitboxPatch] Failed to update HRP:", err)
    end
end

local function UpdateHitboxes()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = player.Character:FindFirstChild("Head") or player.Character.HumanoidRootPart
            if hrp then
                local isEnemy = (player.Team ~= LocalPlayer.Team)
                safeSetProps(hrp, isEnemy, player.TeamColor)
            end
        end
    end
end

local function resetHitboxes()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = player.Character:FindFirstChild("Head") or player.Character.HumanoidRootPart
            if hrp then
                pcall(function()
                    hrp.Size = Vector3.new(2, 2, 1)
                    hrp.Transparency = 0
                    hrp.BrickColor = BrickColor.new("Medium stone grey")
                    hrp.Material = Enum.Material.Plastic
                    hrp.CanCollide = true
                end)
            end
        end
    end
end

_G.StopHitboxScript = function()
    running = false
    for _, c in ipairs(connections) do
        c:Disconnect()
    end
    connections = {}
    resetHitboxes()
    print("[HitboxPatch] Script stopped and hitboxes reset.")
end

task.spawn(function()
    while running do
        local ok, err = pcall(UpdateHitboxes)
        if not ok then
            warn("[HitboxPatch] Error in update loop:", err)
        end
        task.wait(30)
    end
end)

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

local function updatePlayerHitboxes(player)
    if not player.Character then return end
    local hrp = player.Character:FindFirstChild("Head") or player.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        local isEnemy = (player.Team ~= LocalPlayer.Team)
        safeSetProps(hrp, isEnemy, player.TeamColor)
    end
end

local function UpdateAllHitboxes()
    if not running then return end
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            updatePlayerHitboxes(player)
        end
    end
end

local function resetHitboxes()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local hrp = player.Character:FindFirstChild("Head") or player.Character:FindFirstChild("HumanoidRootPart")
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

    -- Disconnect all event connections
    for _, c in ipairs(connections) do
        if c and c.Disconnect then
            pcall(function() c:Disconnect() end)
        end
    end
    connections = {}

    -- Reset hitboxes
    resetHitboxes()
    print("[HitboxPatch] Script stopped and hitboxes reset.")
end

local function onCharacterAdded(char, player)
    if not running then return end
    updatePlayerHitboxes(player)
end

local function onPlayerAdded(player)
    if player == LocalPlayer then return end
    local charConn = player.CharacterAdded:Connect(function(char)
        onCharacterAdded(char, player)
    end)
    table.insert(connections, charConn)
    if player.Character then
        onCharacterAdded(player.Character, player)
    end
end

-- Connect existing players
for _, player in ipairs(Players:GetPlayers()) do
    onPlayerAdded(player)
end

-- Connect new players
table.insert(connections, Players.PlayerAdded:Connect(onPlayerAdded))

-- Hitbox update loop
task.spawn(function()
    while running do
        local ok, err = pcall(UpdateAllHitboxes)
        if not ok then
            warn("[HitboxPatch] Error in update loop:", err)
        end
        task.wait(5)
    end
end)

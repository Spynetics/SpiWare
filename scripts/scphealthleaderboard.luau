local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local running = { value = true }

local function shutdown()
    running.value = false
    if screenGui and screenGui.Parent then
        screenGui:Destroy()
    end
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SCPHealthBoard"
screenGui.ResetOnSpawn = false
screenGui.Parent = game:GetService("CoreGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 400)
frame.Position = UDim2.new(1, -320, 0.5, -200)
frame.BackgroundTransparency = 0.7
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BorderSizePixel = 0
frame.Parent = screenGui

local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0, 5)
listLayout.FillDirection = Enum.FillDirection.Vertical
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Parent = frame

local header = Instance.new("TextLabel")
header.Size = UDim2.new(1, 0, 0, 40)
header.BackgroundTransparency = 0.7
header.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
header.TextColor3 = Color3.fromRGB(255, 255, 255)
header.Font = Enum.Font.SourceSansBold
header.TextSize = 22
header.Text = "SCP Health Leaderboard"
header.Parent = frame

local function createRow(player)
    local rowFrame = Instance.new("Frame")
    rowFrame.Size = UDim2.new(1, 0, 0, 30)
    rowFrame.BackgroundTransparency = 1
    rowFrame.Name = player.Name
    rowFrame.Parent = frame

    local barBack = Instance.new("Frame")
    barBack.Size = UDim2.new(1, 0, 1, 0)
    barBack.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    barBack.BackgroundTransparency = 0.5
    barBack.BorderSizePixel = 0
    barBack.Parent = rowFrame

    local barFill = Instance.new("Frame")
    barFill.Size = UDim2.new(0, 0, 1, 0)
    barFill.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    barFill.BorderSizePixel = 0
    barFill.Parent = barBack

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -10, 1, 0)
    label.Position = UDim2.new(0, 5, 0, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.SourceSans
    label.TextSize = 18
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = rowFrame

    return {
        RowFrame = rowFrame,
        Label = label,
        BarFill = barFill,
    }
end

local playerRows = playerRows or {}
local boundPlayers = {}
local clamp = math.clamp or function(x,a,b) return math.max(a, math.min(b, x)) end

local function safeNum(v, default)
    if type(v) == "number" then return v end
    local n = tonumber(v)
    if n then return n end
    return default
end

local function updateRowForPlayer(player)
    if not running.value then return end
    if not player or not player.Parent then return end

    if not (player.Team and player.Team.Name == "SCP") then
        if playerRows[player.Name] then
            playerRows[player.Name].RowFrame:Destroy()
            playerRows[player.Name] = nil
        end
        return
    end

    if not playerRows[player.Name] then
        playerRows[player.Name] = createRow(player)
    end
    local row = playerRows[player.Name]

    local health = 0
    local maxHealth = 100

    local char = player.Character
    if char then
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if humanoid then
            local attrH = humanoid:GetAttribute("Health")
            if attrH ~= nil then
                health = safeNum(attrH, health)
            else
                health = safeNum(humanoid.Health, health)
            end

            local attrMax = humanoid:GetAttribute("MaxHealth")
            if attrMax ~= nil then
                maxHealth = safeNum(attrMax, maxHealth)
            elseif humanoid.MaxHealth then
                maxHealth = safeNum(humanoid.MaxHealth, maxHealth)
            end
        end
    end

    local rank = player:GetAttribute("Rank") or "Unranked"

    health = safeNum(health, 0)
    maxHealth = safeNum(maxHealth, 100)
    if maxHealth <= 0 then maxHealth = 1 end

    local percent = clamp(health / maxHealth, 0, 1)
    row.BarFill.Size = UDim2.new(percent, 0, 1, 0)

    row.Label.Text = tostring(rank) .. " - " .. player.Name .. " | " .. tostring(math.floor(health + 0.5)) .. " / " .. tostring(math.floor(maxHealth + 0.5))
end

local function updateBoard()
    if not running.value then return end
    for _, player in ipairs(Players:GetPlayers()) do
        updateRowForPlayer(player)
    end
end

local function bindPlayerEvents(player)
    if boundPlayers[player] then return end
    boundPlayers[player] = true

    player:GetPropertyChangedSignal("Team"):Connect(function()
        if running.value then updateRowForPlayer(player) end
    end)

    player.CharacterAdded:Connect(function(character)
        if not running.value then return end
        local humanoid = character:WaitForChild("Humanoid", 5)
        if humanoid then
            humanoid:GetPropertyChangedSignal("Health"):Connect(function()
                if running.value then updateRowForPlayer(player) end
            end)
            humanoid:GetPropertyChangedSignal("MaxHealth"):Connect(function()
                if running.value then updateRowForPlayer(player) end
            end)
        end
        updateRowForPlayer(player)
    end)

    if player.Character then
        local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid:GetPropertyChangedSignal("Health"):Connect(function()
                if running.value then updateRowForPlayer(player) end
            end)
            humanoid:GetPropertyChangedSignal("MaxHealth"):Connect(function()
                if running.value then updateRowForPlayer(player) end
            end)
        end
    end
end

for _, player in ipairs(Players:GetPlayers()) do
    bindPlayerEvents(player)
end

Players.PlayerAdded:Connect(function(player)
    bindPlayerEvents(player)
    updateBoard()
end)

Players.PlayerRemoving:Connect(function(player)
    if playerRows[player.Name] then
        playerRows[player.Name].RowFrame:Destroy()
        playerRows[player.Name] = nil
    end
    boundPlayers[player] = nil
end)

spawn(function()
    while running.value do
        updateBoard()
        task.wait(0.5)
    end
end)

return {
    shutdown = shutdown,
    running = running,
}

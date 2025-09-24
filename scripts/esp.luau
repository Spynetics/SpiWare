-- OPEN SOURCE ESP BY Xuai124 

-- SERVICES
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

-- VARIABLES
local boxes = {}
local highlights = {}
local beamTracers = {}
local skeletons = {}
local healthBars = {}
local nameLabels = {}

local boxESPEnabled = false
local chamsEnabled = false
local tracerEnabled = false
local skeletonEnabled = false
local healthBarEnabled = false
local nameESPEnabled = false
local teamFilterEnabled = false

local boxConnection
local chamsUpdateConnection
local tracerConnection
local skeletonConnection
local healthBarConnection
local nameESPConnection

-- HELPER FUNCTIONS
local function getPlayerColor(plr)
    local teamColor = (plr.Team and plr.Team.TeamColor.Color) or Color3.fromRGB(0, 255, 0)
    if teamColor == Color3.new(1, 1, 1) then
        teamColor = Color3.fromRGB(0, 255, 0)
    end
    return teamColor
end

-- TEAM FILTER CHECK
local function shouldShowPlayer(plr)
    if not teamFilterEnabled then
        return true
    end
    
    if player.Team and plr.Team then
        return player.Team ~= plr.Team
    else
        return true
    end
end

-- BOX ESP FUNCTIONS
local function createBox()
    local box = Drawing.new("Square")
    box.Visible = false
    box.Color = Color3.fromRGB(0, 255, 0)
    box.Thickness = 2
    box.Transparency = 1
    box.Filled = false
    return box
end

-- CHAMS FUNCTIONS
local function addHighlight(plr)
    if highlights[plr] then return end
    if not plr.Character or not plr.Character.Parent then return end
    if not shouldShowPlayer(plr) then return end
    
    local highlight = Instance.new("Highlight")
    highlight.Name = "ESPHighlight"
    highlight.Adornee = plr.Character
    highlight.FillColor = getPlayerColor(plr)
    highlight.OutlineColor = Color3.new(0, 0, 0)
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0
    highlight.Parent = player:FindFirstChildOfClass("PlayerGui") or CoreGui
    highlights[plr] = highlight
end

local function removeHighlight(plr)
    if highlights[plr] then
        highlights[plr]:Destroy()
        highlights[plr] = nil
    end
end

-- TRACER FUNCTIONS
local function createBeam(plr)
    if beamTracers[plr] then
        local oldData = beamTracers[plr]
        if oldData.Beam then
            oldData.Beam.Enabled = false
            oldData.Beam:Destroy()
        end
        if oldData.Attachment0 then oldData.Attachment0:Destroy() end
        if oldData.Attachment1 then oldData.Attachment1:Destroy() end
        beamTracers[plr] = nil
    end

    local character = plr.Character
    if not character then return nil end
    local hrp = character:FindFirstChild("HumanoidRootPart")
    local localHRP = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if not hrp or not localHRP then return nil end
    if not shouldShowPlayer(plr) then return nil end

    local beamData = {}

    local att0 = Instance.new("Attachment")
    att0.Name = "ESPAttachment0"
    att0.Parent = localHRP

    local att1 = Instance.new("Attachment")
    att1.Name = "ESPAttachment1"
    att1.Parent = hrp

    local beam = Instance.new("Beam")
    beam.Name = "ESPBeam"
    beam.Attachment0 = att0
    beam.Attachment1 = att1
    beam.FaceCamera = true
    beam.Width0 = 0.05
    beam.Width1 = 0.05
    beam.Color = ColorSequence.new(getPlayerColor(plr))
    beam.Transparency = NumberSequence.new(0)
    beam.Enabled = false
    beam.Parent = workspace

    beamData.Attachment0 = att0
    beamData.Attachment1 = att1
    beamData.Beam = beam

    beamTracers[plr] = beamData
    return beamData
end

-- SKELETON FUNCTIONS
local function createSkeletonLine()
    local line = Drawing.new("Line")
    line.Visible = false
    line.Color = Color3.fromRGB(255, 255, 255)
    line.Thickness = 2
    line.Transparency = 1
    return line
end

local function createSkeleton(plr)
    if skeletons[plr] then
        for _, line in pairs(skeletons[plr]) do
            line:Remove()
        end
    end
    
    skeletons[plr] = {}
    
    local connections = {
        "Head-UpperTorso", "UpperTorso-LowerTorso", 
        "UpperTorso-LeftUpperArm", "LeftUpperArm-LeftLowerArm", "LeftLowerArm-LeftHand",
        "UpperTorso-RightUpperArm", "RightUpperArm-RightLowerArm", "RightLowerArm-RightHand",
        "LowerTorso-LeftUpperLeg", "LeftUpperLeg-LeftLowerLeg", "LeftLowerLeg-LeftFoot",
        "LowerTorso-RightUpperLeg", "RightUpperLeg-RightLowerLeg", "RightLowerLeg-RightFoot"
    }
    
    for _, connection in pairs(connections) do
        skeletons[plr][connection] = createSkeletonLine()
    end
end

local function updateSkeleton(plr)
    local character = plr.Character
    if not character or not skeletons[plr] then return end
    if not shouldShowPlayer(plr) then
        for _, line in pairs(skeletons[plr]) do
            line.Visible = false
        end
        return
    end
    
    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid or humanoid.RigType ~= Enum.HumanoidRigType.R15 then 
        for _, line in pairs(skeletons[plr]) do
            line.Visible = false
        end
        return 
    end
    
    local parts = {
        Head = character:FindFirstChild("Head"),
        UpperTorso = character:FindFirstChild("UpperTorso"),
        LowerTorso = character:FindFirstChild("LowerTorso"),
        LeftUpperArm = character:FindFirstChild("LeftUpperArm"),
        LeftLowerArm = character:FindFirstChild("LeftLowerArm"),
        LeftHand = character:FindFirstChild("LeftHand"),
        RightUpperArm = character:FindFirstChild("RightUpperArm"),
        RightLowerArm = character:FindFirstChild("RightLowerArm"),
        RightHand = character:FindFirstChild("RightHand"),
        LeftUpperLeg = character:FindFirstChild("LeftUpperLeg"),
        LeftLowerLeg = character:FindFirstChild("LeftLowerLeg"),
        LeftFoot = character:FindFirstChild("LeftFoot"),
        RightUpperLeg = character:FindFirstChild("RightUpperLeg"),
        RightLowerLeg = character:FindFirstChild("RightLowerLeg"),
        RightFoot = character:FindFirstChild("RightFoot")
    }
    
    local connections = {
        {"Head-UpperTorso", parts.Head, parts.UpperTorso},
        {"UpperTorso-LowerTorso", parts.UpperTorso, parts.LowerTorso},
        {"UpperTorso-LeftUpperArm", parts.UpperTorso, parts.LeftUpperArm},
        {"LeftUpperArm-LeftLowerArm", parts.LeftUpperArm, parts.LeftLowerArm},
        {"LeftLowerArm-LeftHand", parts.LeftLowerArm, parts.LeftHand},
        {"UpperTorso-RightUpperArm", parts.UpperTorso, parts.RightUpperArm},
        {"RightUpperArm-RightLowerArm", parts.RightUpperArm, parts.RightLowerArm},
        {"RightLowerArm-RightHand", parts.RightLowerArm, parts.RightHand},
        {"LowerTorso-LeftUpperLeg", parts.LowerTorso, parts.LeftUpperLeg},
        {"LeftUpperLeg-LeftLowerLeg", parts.LeftUpperLeg, parts.LeftLowerLeg},
        {"LeftLowerLeg-LeftFoot", parts.LeftLowerLeg, parts.LeftFoot},
        {"LowerTorso-RightUpperLeg", parts.LowerTorso, parts.RightUpperLeg},
        {"RightUpperLeg-RightLowerLeg", parts.RightUpperLeg, parts.RightLowerLeg},
        {"RightLowerLeg-RightFoot", parts.RightLowerLeg, parts.RightFoot}
    }
    
    for _, connection in pairs(connections) do
        local name, part1, part2 = connection[1], connection[2], connection[3]
        local line = skeletons[plr][name]
        
        if part1 and part2 and line then
            local pos1, onScreen1 = camera:WorldToViewportPoint(part1.Position)
            local pos2, onScreen2 = camera:WorldToViewportPoint(part2.Position)
            
            if onScreen1 and onScreen2 then
                line.From = Vector2.new(pos1.X, pos1.Y)
                line.To = Vector2.new(pos2.X, pos2.Y)
                line.Color = getPlayerColor(plr)
                line.Visible = true
            else
                line.Visible = false
            end
        else
            line.Visible = false
        end
    end
end

local function removeSkeleton(plr)
    if skeletons[plr] then
        for _, line in pairs(skeletons[plr]) do
            line:Remove()
        end
        skeletons[plr] = nil
    end
end

-- HEALTH BAR FUNCTIONS
local function createHealthBar()
    local healthBar = {}
    
    healthBar.background = Drawing.new("Square")
    healthBar.background.Visible = false
    healthBar.background.Color = Color3.fromRGB(0, 0, 0)
    healthBar.background.Thickness = 1
    healthBar.background.Transparency = 1
    healthBar.background.Filled = true
    
    healthBar.health = Drawing.new("Square")
    healthBar.health.Visible = false
    healthBar.health.Color = Color3.fromRGB(0, 255, 0)
    healthBar.health.Thickness = 1
    healthBar.health.Transparency = 1
    healthBar.health.Filled = true
    
    return healthBar
end

local function updateHealthBar(plr)
    local character = plr.Character
    if not character or not healthBars[plr] then return end
    if not shouldShowPlayer(plr) then
        healthBars[plr].background.Visible = false
        healthBars[plr].health.Visible = false
        return
    end
    
    local humanoid = character:FindFirstChild("Humanoid")
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not humanoid or not hrp then 
        healthBars[plr].background.Visible = false
        healthBars[plr].health.Visible = false
        return 
    end
    
    local rootPos, onScreen = camera:WorldToViewportPoint(hrp.Position)
    if not onScreen then
        healthBars[plr].background.Visible = false
        healthBars[plr].health.Visible = false
        return
    end
    
    local distance = math.clamp(rootPos.Z, 0.1, 1000)
    local barHeight = (600 / distance) * 1.3
    local barWidth = 6
    local backgroundWidth = 8
    
    local barX = rootPos.X - (barHeight * 1.0 / 2) - backgroundWidth - 10
    local barY = rootPos.Y - barHeight / 2
    
    healthBars[plr].background.Size = Vector2.new(backgroundWidth, barHeight + 2)
    healthBars[plr].background.Position = Vector2.new(barX - 1, barY - 1)
    healthBars[plr].background.Visible = true
    
    local healthPercent = math.clamp(humanoid.Health / humanoid.MaxHealth, 0, 1)
    
    if healthPercent <= 0 then
        healthBars[plr].health.Visible = false
    else
        local healthBarHeight = barHeight * healthPercent
        
        healthBars[plr].health.Size = Vector2.new(barWidth, healthBarHeight)
        healthBars[plr].health.Position = Vector2.new(barX, barY + (barHeight - healthBarHeight))
        healthBars[plr].health.Visible = true
        
        if healthPercent > 0.6 then
            healthBars[plr].health.Color = Color3.fromRGB(0, 255, 0)
        elseif healthPercent > 0.3 then
            healthBars[plr].health.Color = Color3.fromRGB(255, 255, 0)
        else
            healthBars[plr].health.Color = Color3.fromRGB(255, 0, 0)
        end
    end
end

local function removeHealthBar(plr)
    if healthBars[plr] then
        healthBars[plr].background:Remove()
        healthBars[plr].health:Remove()
        healthBars[plr] = nil
    end
end

-- NAME ESP FUNCTIONS
local function createNameLabel()
    local nameLabel = Drawing.new("Text")
    nameLabel.Visible = false
    nameLabel.Color = Color3.fromRGB(255, 255, 255)
    nameLabel.Size = 16
    nameLabel.Center = true
    nameLabel.Outline = true
    nameLabel.OutlineColor = Color3.fromRGB(0, 0, 0)
    nameLabel.Font = Drawing.Fonts.UI
    nameLabel.Transparency = 1
    return nameLabel
end

local function updateNameLabel(plr)
    local character = plr.Character
    if not character or not nameLabels[plr] then return end
    if not shouldShowPlayer(plr) then
        nameLabels[plr].Visible = false
        return
    end
    
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then 
        nameLabels[plr].Visible = false
        return 
    end
    
    local rootPos, onScreen = camera:WorldToViewportPoint(hrp.Position)
    if not onScreen then
        nameLabels[plr].Visible = false
        return
    end
    
    local distance = math.clamp(rootPos.Z, 0.1, 1000)
    local nameHeight = (600 / distance) * 1.3
    
    local nameX = rootPos.X
    local nameY = rootPos.Y - nameHeight / 2 - 20
    
    nameLabels[plr].Position = Vector2.new(nameX, nameY)
    nameLabels[plr].Text = plr.Name
    nameLabels[plr].Color = getPlayerColor(plr)
    nameLabels[plr].Visible = true
end

local function removeNameLabel(plr)
    if nameLabels[plr] then
        nameLabels[plr]:Remove()
        nameLabels[plr] = nil
    end
end

-- ESP UPDATE FUNCTIONS
local function updateBoxes()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and plr ~= player then
            if not shouldShowPlayer(plr) then
                if boxes[plr] then
                    boxes[plr].Visible = false
                end
                continue
            end
            
            local hrp = plr.Character.HumanoidRootPart
            local box = boxes[plr]
            if not box then
                box = createBox()
                boxes[plr] = box
            end

            box.Color = getPlayerColor(plr)

            local rootPos, onScreen = camera:WorldToViewportPoint(hrp.Position)
            local distance = math.clamp(rootPos.Z, 0.1, 1000)

            if onScreen then
                local sizeY = (1500 / distance) * 1.3
                local sizeX = sizeY * 1.0

                box.Size = Vector2.new(sizeX, sizeY)
                box.Position = Vector2.new(rootPos.X - sizeX / 2, rootPos.Y - sizeY / 2)
                box.Visible = true

                local velocity = hrp.Velocity
                local speed = velocity.Magnitude
                if speed > 1 then
                    box.Thickness = 2 + math.clamp(speed / 50, 0, 3)
                else
                    box.Thickness = 2
                end
            else
                box.Visible = false
            end
        else
            if boxes[plr] then
                boxes[plr].Visible = false
            end
        end
    end
end

local function updateAllHighlights()
    for plr, highlight in pairs(highlights) do
        if not shouldShowPlayer(plr) then
            removeHighlight(plr)
            continue
        end
        
        if plr.Character and plr.Character.Parent then
            highlight.Adornee = plr.Character
            highlight.FillColor = getPlayerColor(plr)
        else
            removeHighlight(plr)
        end
    end
end

local function updateTracers()
    local localHRP = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if not localHRP then
        for _, data in pairs(beamTracers) do
            if data.Beam then data.Beam.Enabled = false end
        end
        return
    end

    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            if not shouldShowPlayer(plr) then
                if beamTracers[plr] and beamTracers[plr].Beam then
                    beamTracers[plr].Beam.Enabled = false
                end
                continue
            end
            
            local targetHRP = plr.Character.HumanoidRootPart

            local beamData = beamTracers[plr]
            if not beamData then
                beamData = createBeam(plr)
            end
            if not beamData then continue end

            beamData.Attachment0.WorldPosition = localHRP.Position
            beamData.Attachment1.WorldPosition = targetHRP.Position

            beamData.Beam.Color = ColorSequence.new(getPlayerColor(plr))
            beamData.Beam.Enabled = true
        else
            if beamTracers[plr] and beamTracers[plr].Beam then
                beamTracers[plr].Beam.Enabled = false
            end
        end
    end
end

local function updateSkeletons()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player and plr.Character then
            if not skeletons[plr] then
                createSkeleton(plr)
            end
            updateSkeleton(plr)
        end
    end
end

local function updateHealthBars()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player and plr.Character then
            if not healthBars[plr] then
                healthBars[plr] = createHealthBar()
            end
            updateHealthBar(plr)
        else
            if healthBars[plr] then
                healthBars[plr].background.Visible = false
                healthBars[plr].health.Visible = false
            end
        end
    end
end

local function updateNameESP()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player and plr.Character then
            if not nameLabels[plr] then
                nameLabels[plr] = createNameLabel()
            end
            updateNameLabel(plr)
        else
            if nameLabels[plr] then
                nameLabels[plr].Visible = false
            end
        end
    end
end

-- GUI SETUP
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ESP_UI_4layy"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Size = UDim2.new(0, 250, 0, 340)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.ClipsDescendants = true
MainFrame.Active = true
MainFrame.Draggable = true

local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
TopBar.BorderSizePixel = 0
TopBar.Size = UDim2.new(1, 0, 0, 28)

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Parent = TopBar
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, -40, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.Font = Enum.Font.SourceSansBold
Title.Text = "Xuai124 ESP UI"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.RichText = false

local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Name = "MinimizeBtn"
MinimizeBtn.Parent = TopBar
MinimizeBtn.Size = UDim2.new(0, 30, 1, 0)
MinimizeBtn.Position = UDim2.new(1, -30, 0, 0)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
MinimizeBtn.BorderSizePixel = 0
MinimizeBtn.Font = Enum.Font.SourceSansBold
MinimizeBtn.Text = "-"
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBtn.TextSize = 22

local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Name = "ScrollFrame"
ScrollFrame.Parent = MainFrame
ScrollFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ScrollFrame.BorderSizePixel = 0
ScrollFrame.Position = UDim2.new(0, 10, 0, 35)
ScrollFrame.Size = UDim2.new(1, -20, 1, -45)
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 280)
ScrollFrame.ScrollBarThickness = 4
ScrollFrame.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar

-- BUTTON CREATION
local function createButton(text)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    btn.BorderSizePixel = 0
    btn.Font = Enum.Font.SourceSansBold
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 16
    btn.Text = text
    btn.AutoButtonColor = true
    btn.Parent = ScrollFrame
    return btn
end

local BoxToggle = createButton("Toggle Box ESP")
BoxToggle.Position = UDim2.new(0, 0, 0, 0)

local ChamsToggle = createButton("Toggle Chams")
ChamsToggle.Position = UDim2.new(0, 0, 0, 40)

local TracerToggle = createButton("Toggle Tracers")
TracerToggle.Position = UDim2.new(0, 0, 0, 80)

local SkeletonToggle = createButton("Skeleton (R15)")
SkeletonToggle.Position = UDim2.new(0, 0, 0, 120)

local HealthBarToggle = createButton("Health Bar")
HealthBarToggle.Position = UDim2.new(0, 0, 0, 160)

local NameToggle = createButton("Toggle Names")
NameToggle.Position = UDim2.new(0, 0, 0, 200)
NameToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

local TeamFilterToggle = createButton("Remove Friendly Team ESP")
TeamFilterToggle.Position = UDim2.new(0, 0, 0, 240)
TeamFilterToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

-- BUTTON FUNCTIONS
BoxToggle.MouseButton1Click:Connect(function()
    boxESPEnabled = not boxESPEnabled
    if boxESPEnabled then
        BoxToggle.BackgroundColor3 = Color3.fromRGB(85, 170, 85)
    else
        BoxToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        for _, box in pairs(boxes) do
            box.Visible = false
        end
        boxes = {}
    end
end)

ChamsToggle.MouseButton1Click:Connect(function()
    chamsEnabled = not chamsEnabled
    if chamsEnabled then
        ChamsToggle.BackgroundColor3 = Color3.fromRGB(85, 170, 85)
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= player then
                addHighlight(plr)
            end
        end
    else
        ChamsToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        for plr, highlight in pairs(highlights) do
            highlight:Destroy()
        end
        highlights = {}
    end
end)

TracerToggle.MouseButton1Click:Connect(function()
    tracerEnabled = not tracerEnabled
    if tracerEnabled then
        TracerToggle.BackgroundColor3 = Color3.fromRGB(85, 170, 85)
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                createBeam(plr)
            end
        end
    else
        TracerToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        for plr, data in pairs(beamTracers) do
            if data.Beam then
                data.Beam.Enabled = false
                data.Beam:Destroy()
            end
            if data.Attachment0 then data.Attachment0:Destroy() end
            if data.Attachment1 then data.Attachment1:Destroy() end
        end
        beamTracers = {}
    end
end)

SkeletonToggle.MouseButton1Click:Connect(function()
    skeletonEnabled = not skeletonEnabled
    if skeletonEnabled then
        SkeletonToggle.BackgroundColor3 = Color3.fromRGB(85, 170, 85)
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= player then
                createSkeleton(plr)
            end
        end
    else
        SkeletonToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        for plr, skeletonLines in pairs(skeletons) do
            for _, line in pairs(skeletonLines) do
                line.Visible = false
            end
        end
    end
end)

HealthBarToggle.MouseButton1Click:Connect(function()
    healthBarEnabled = not healthBarEnabled
    if healthBarEnabled then
        HealthBarToggle.BackgroundColor3 = Color3.fromRGB(85, 170, 85)
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= player then
                if not healthBars[plr] then
                    healthBars[plr] = createHealthBar()
                end
            end
        end
    else
        HealthBarToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        for plr, healthBar in pairs(healthBars) do
            healthBar.background.Visible = false
            healthBar.health.Visible = false
        end
    end
end)

NameToggle.MouseButton1Click:Connect(function()
    nameESPEnabled = not nameESPEnabled
    if nameESPEnabled then
        NameToggle.BackgroundColor3 = Color3.fromRGB(85, 170, 85)
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= player then
                if not nameLabels[plr] then
                    nameLabels[plr] = createNameLabel()
                end
            end
        end
    else
        NameToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        for plr, nameLabel in pairs(nameLabels) do
            nameLabel.Visible = false
        end
    end
end)

TeamFilterToggle.MouseButton1Click:Connect(function()
    teamFilterEnabled = not teamFilterEnabled
    
    if teamFilterEnabled then
        TeamFilterToggle.BackgroundColor3 = Color3.fromRGB(85, 170, 85)
    else
        TeamFilterToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    end
    
    if chamsEnabled then
        for plr, highlight in pairs(highlights) do
            if not shouldShowPlayer(plr) then
                removeHighlight(plr)
            end
        end
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= player and shouldShowPlayer(plr) and plr.Character then
                addHighlight(plr)
            end
        end
    end
end)

-- MINIMIZE LOGIC
local minimized = false
MinimizeBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    ScrollFrame.Visible = not minimized
    MainFrame.Size = minimized and UDim2.new(0, 250, 0, 28) or UDim2.new(0, 250, 0, 340)
end)

-- RESPAWN HANDLERS
player.CharacterAdded:Connect(function()
    wait(0.5)
    if tracerEnabled then
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                createBeam(plr)
            end
        end
    end
    if skeletonEnabled then
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= player then
                createSkeleton(plr)
            end
        end
    end
    if healthBarEnabled then
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= player then
                if not healthBars[plr] then
                    healthBars[plr] = createHealthBar()
                end
            end
        end
    end
    if nameESPEnabled then
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= player then
                if not nameLabels[plr] then
                    nameLabels[plr] = createNameLabel()
                end
            end
        end
    end
end)

-- PLAYER ADDED HANDLERS
Players.PlayerAdded:Connect(function(plr)
    if plr == player then return end
    plr.CharacterAdded:Connect(function()
        wait(0.5)
        if tracerEnabled then
            createBeam(plr)
        end
        if chamsEnabled then
            addHighlight(plr)
        end
        if skeletonEnabled then
            createSkeleton(plr)
        end
        if healthBarEnabled then
            if not healthBars[plr] then
                healthBars[plr] = createHealthBar()
            end
        end
        if nameESPEnabled then
            if not nameLabels[plr] then
                nameLabels[plr] = createNameLabel()
            end
        end
    end)
end)

-- PLAYER CLEANUP
Players.PlayerRemoving:Connect(function(plr)
    if boxes[plr] then
        boxes[plr]:Remove()
        boxes[plr] = nil
    end
    
    removeHighlight(plr)
    
    if beamTracers[plr] then
        local data = beamTracers[plr]
        if data.Beam then data.Beam:Destroy() end
        if data.Attachment0 then data.Attachment0:Destroy() end
        if data.Attachment1 then data.Attachment1:Destroy() end
        beamTracers[plr] = nil
    end
    
    removeSkeleton(plr)
    removeHealthBar(plr)
    removeNameLabel(plr)
end)

-- EXISTING PLAYERS
for _, plr in pairs(Players:GetPlayers()) do
    if plr ~= player then
        plr.CharacterAdded:Connect(function()
            wait(0.5)
            if tracerEnabled then
                createBeam(plr)
            end
            if chamsEnabled then
                addHighlight(plr)
            end
            if skeletonEnabled then
                createSkeleton(plr)
            end
            if healthBarEnabled then
                if not healthBars[plr] then
                    healthBars[plr] = createHealthBar()
                end
            end
            if nameESPEnabled then
                if not nameLabels[plr] then
                    nameLabels[plr] = createNameLabel()
                end
            end
        end)
    end
end

-- RENDER LOOPS
boxConnection = RunService.RenderStepped:Connect(function()
    if boxESPEnabled then
        updateBoxes()
    else
        for _, box in pairs(boxes) do
            box.Visible = false
        end
    end
end)

chamsUpdateConnection = RunService.RenderStepped:Connect(function()
    if chamsEnabled then
        updateAllHighlights()
    end
end)

tracerConnection = RunService.RenderStepped:Connect(function()
    if tracerEnabled then
        updateTracers()
    else
        for _, data in pairs(beamTracers) do
            if data.Beam then
                data.Beam.Enabled = false
            end
        end
    end
end)

skeletonConnection = RunService.RenderStepped:Connect(function()
    if skeletonEnabled then
        updateSkeletons()
    else
        for _, skeletonLines in pairs(skeletons) do
            for _, line in pairs(skeletonLines) do
                line.Visible = false
            end
        end
    end
end)

healthBarConnection = RunService.RenderStepped:Connect(function()
    if healthBarEnabled then
        updateHealthBars()
    else
        for _, healthBar in pairs(healthBars) do
            healthBar.background.Visible = false
            healthBar.health.Visible = false
        end
    end
end)

nameESPConnection = RunService.RenderStepped:Connect(function()
    if nameESPEnabled then
        updateNameESP()
    else
        for _, nameLabel in pairs(nameLabels) do
            nameLabel.Visible = false
        end
    end
end)
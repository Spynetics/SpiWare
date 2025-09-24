local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Zones = {
	HCZ = workspace:WaitForChild("Heavy Containment Zone"),
	LCZ = workspace:WaitForChild("Light Containment Zone"),
	EZ = workspace:WaitForChild("Entrance Zone"),
	Surface = workspace:WaitForChild("Surface"),
	PocketDimension = nil -- noop
}

local PresetColors = {
	Color3.fromRGB(255, 0, 0),
	Color3.fromRGB(0, 255, 0),
	Color3.fromRGB(0, 0, 255),
	Color3.fromRGB(255, 255, 0),
	Color3.fromRGB(255, 0, 255),
	Color3.fromRGB(0, 255, 255)
}

local activeESP = {}

local function createOrUpdateBillboard(part, text, color)
	if not part or not part.Parent then
		warn("[ESP] invalid part for billboard, skipping")
		return
	end

	local billboard = part:FindFirstChild("CheckpointESP")
	if billboard and billboard:IsA("BillboardGui") then
		local label = billboard:FindFirstChild("Label")
		if label then
			label.Text = text
			label.TextColor3 = color
		end
		activeESP[part] = billboard
		-- debug
		--print("[ESP] Updated existing billboard for", part:GetFullName())
		return
	end

	-- create new
	billboard = Instance.new("BillboardGui")
	billboard.Name = "CheckpointESP"
	billboard.Size = UDim2.new(0, 150, 0, 30)
	billboard.StudsOffset = Vector3.new(0, 15, 0)
	billboard.AlwaysOnTop = true
	billboard.Adornee = part

	local label = Instance.new("TextLabel")
	label.Name = "Label"
	label.Size = UDim2.new(1, 0, 1, 0)
	label.BackgroundTransparency = 1
	label.TextTransparency = 0.2
	label.BorderSizePixel = 0
	label.Text = text
	label.TextColor3 = color
	label.TextStrokeTransparency = 0.3
	label.Font = Enum.Font.GothamBold
	label.TextScaled = true
	label.Parent = billboard

	billboard.Parent = part
	activeESP[part] = billboard
	print("[ESP] Created ESP for part:", part:GetFullName())
end

local function removeESPForPart(part)
	local gui = activeESP[part]
	if gui and gui.Parent then
		gui:Destroy()
	end
	activeESP[part] = nil
end

local function clearAllESP()
	local cnt = 0
	for part, gui in pairs(activeESP) do
		if gui and gui.Parent then
			gui:Destroy()
			cnt = cnt + 1
		end
		activeESP[part] = nil
	end

	for _, obj in ipairs(workspace:GetDescendants()) do
		if obj:IsA("BillboardGui") and obj.Name == "CheckpointESP" then
			obj:Destroy()
		end
	end

	print("[ESP] Cleared all ESPs. Removed:", cnt)
end

local function updateESPForCheckpoints(checkpoints)
	-- build a set of desired parts
	local desired = {}
	for i, cp in ipairs(checkpoints or {}) do
		if cp.part and cp.part.Parent then
			local color = PresetColors[((i - 1) % #PresetColors) + 1]
			desired[cp.part] = { label = cp.label, color = color }
		end
	end

	for part in pairs(activeESP) do
		if not desired[part] then
			removeESPForPart(part)
		end
	end

	for part, info in pairs(desired) do
		createOrUpdateBillboard(part, info.label, info.color)
	end
end

local function handleZone(zoneName, folder, checkpoints)
	print("[Zone] Entered:", zoneName)
	if not checkpoints or #checkpoints == 0 then
		clearAllESP()
		return
	end
	updateESPForCheckpoints(checkpoints)
end

local ZoneCheckpoints = {
	LCZ = {
		{ part = Zones.LCZ.CheckptA.Front, label = "Checkpoint A" },
		{ part = Zones.LCZ.CheckptB.Front, label = "Checkpoint B" }
	},
	HCZ = {
		{ part = Zones.HCZ.CheckptA.Front, label = "Checkpoint A" },
		{ part = Zones.HCZ.CheckptB.Front, label = "Checkpoint B" },
		{ part = Zones.HCZ.HID.Front, label = "HID" },
		{ part = Zones.HCZ.Warhead.Front, label = "Warhead" }
	},
	EZ = {
		{ part = Zones.EZ.GateA.Front, label = "GateA" },
		{ part = Zones.EZ.GateB.Front, label = "GateB" }
	}
}

local ZoneHandlers = {
	LCZ = function() handleZone("Light Containment Zone", Zones.LCZ, ZoneCheckpoints.LCZ) end,
	HCZ = function() handleZone("Heavy Containment Zone", Zones.HCZ, ZoneCheckpoints.HCZ) end,
	EZ  = function() handleZone("Entrance Zone", Zones.EZ, ZoneCheckpoints.EZ) end,
	Surface = function() print("[Zone] Entered Surface Zone"); handleZone("Surface", nil, nil) end,
	PocketDimension = function() print("[Zone] Entered PocketDimension"); handleZone("PocketDimension", nil, nil) end
}

local lastZone = nil
task.spawn(function()
	while true do
		local char = LocalPlayer and LocalPlayer.Character
		local humanoid = char and char:FindFirstChildOfClass("Humanoid")

		if not char or not humanoid or humanoid.Health <= 0 then
			if lastZone ~= nil then
				print("[Zone Tracker] character invalid/dead -> clearing ESPs and resetting lastZone")
				lastZone = nil
				clearAllESP()
			end
			task.wait(0.3)
		else
			local currentZone = char:GetAttribute("Zone")
			if currentZone ~= lastZone then
				print("[Zone Tracker] Zone changed:", tostring(lastZone), "->", tostring(currentZone))
				lastZone = currentZone

				local handler = ZoneHandlers[currentZone]
				if handler then
					handler()
				else
					print("[Zone Tracker] No handler for zone:", tostring(currentZone), " -> clearing ESPs")
					clearAllESP()
				end
			end
			task.wait(0.35)
		end
	end
end)

Players.LocalPlayer.CharacterAdded:Connect(function(char)
	local humanoid = char:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid.Died:Connect(function()
			print("[Zone Tracker] Humanoid died -> clearing ESPs")
			lastZone = nil
			clearAllESP()
		end)
	end

	char.ChildAdded:Connect(function(child)
		if child:IsA("Humanoid") then
			child.Died:Connect(function()
				print("[Zone Tracker] Humanoid died -> clearing ESPs")
				lastZone = nil
				clearAllESP()
			end)
		end
	end)
end)

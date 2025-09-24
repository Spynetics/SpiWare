_G.HeadSize = 6
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function UpdateHitboxes()
	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			local hrp = player.Character:FindFirstChild("Head") or player.Character.HumanoidRootPart

			if player.Team ~= LocalPlayer.Team then
				hrp.Size = Vector3.new(_G.HeadSize, _G.HeadSize, _G.HeadSize)
				hrp.Transparency = 0.8
				hrp.BrickColor = player.TeamColor
				hrp.Material = Enum.Material.Neon
				hrp.CanCollide = false
			else
				hrp.Size = Vector3.new(2, 2, 1)
				hrp.Transparency = 1
				hrp.BrickColor = BrickColor.new("Medium stone grey")
				hrp.Material = Enum.Material.Plastic
				hrp.CanCollide = true
			end
		end
	end
end

task.spawn(function()
	while true do
		UpdateHitboxes()
		task.wait(30)
	end
end)

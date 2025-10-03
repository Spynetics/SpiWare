local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

local camObj = player:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule"):WaitForChild("CameraCFrame")

RunService.RenderStepped:Connect(function()
    camObj.CFrame = camera.CFrame
end)

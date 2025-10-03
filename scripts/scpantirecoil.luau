local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local SafeScript = {}
SafeScript._connections = {}
SafeScript._active = false

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

print("[CameraSync] Script loaded. Player:", player, "Camera:", camera)

local function connectRenderStepped()
    print("[CameraSync] Connecting RenderStepped")
    local conn = RunService.RenderStepped:Connect(function()
        if not SafeScript._active then return end
        if not camera then
            warn("[CameraSync] CurrentCamera missing")
            return
        end
        -- Example: lock camera to current CFrame
        local suc, err = pcall(function()
            camera.CFrame = camera.CFrame -- Just reassign or modify as needed
        end)
        if not suc then
            warn("[CameraSync] Error updating camera:", err)
        end
    end)
    table.insert(SafeScript._connections, conn)
end

function SafeScript.start()
    if SafeScript._active then return end
    SafeScript._active = true
    connectRenderStepped()
    print("[CameraSync] Script active")
end

function SafeScript.stop()
    SafeScript._active = false
    print("[CameraSync] Script stopped")
end

function SafeScript.Shutdown()
    SafeScript._active = false
    for _, c in ipairs(SafeScript._connections) do
        if c and c.Disconnect then
            pcall(function() c:Disconnect() end)
        end
    end
    SafeScript._connections = {}
    print("[CameraSync] Shutdown complete")
end

return SafeScript

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local SafeScript = {}
SafeScript._connections = {}
SafeScript._active = false

local player = Players.LocalPlayer
if not player then
    warn("LocalPlayer missing; aborting script")
    return SafeScript
end

local camera = workspace.CurrentCamera
if not camera then
    warn("Camera missing; aborting script")
    return SafeScript
end

local camObj
local ok, err = pcall(function()
    camObj = player:WaitForChild("PlayerScripts", 10)
                   :WaitForChild("PlayerModule", 10)
                   :WaitForChild("CameraCFrame", 10)
end)
if not ok or not camObj then
    warn("Failed to get CameraCFrame:", err)
    return SafeScript
end

local function connectRenderStepped()
    local conn = RunService.RenderStepped:Connect(function()
        if SafeScript._active and camera and camObj and camObj:IsA("CFrameValue") then
            local suc, err = pcall(function()
                camObj.CFrame = camera.CFrame
            end)
            if not suc then warn("Error updating CameraCFrame:", err) end
        end
    end)
    table.insert(SafeScript._connections, conn)
end

function SafeScript.start()
    if SafeScript._active then return end
    SafeScript._active = true
    -- Only connect if no connections exist yet
    if #SafeScript._connections == 0 then
        connectRenderStepped()
    end
end

function SafeScript.stop()
    SafeScript._active = false
end

function SafeScript.Shutdown()
    SafeScript._active = false
    for _, c in ipairs(SafeScript._connections) do
        if c and c.Disconnect then
            pcall(function() c:Disconnect() end)
        end
    end
    SafeScript._connections = {}
    print("Camera Sync Script shutdown complete")
end

return SafeScript

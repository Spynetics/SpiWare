local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local SafeScript = {}
SafeScript._connections = {}
SafeScript._active = false

print("[CameraSync] Script loaded")

local player = Players.LocalPlayer
if not player then
    warn("[CameraSync] LocalPlayer missing; aborting script")
    return SafeScript
end
print("[CameraSync] LocalPlayer found:", player.Name)

local camera = workspace.CurrentCamera
if not camera then
    warn("[CameraSync] Camera missing; aborting script")
    return SafeScript
end
print("[CameraSync] CurrentCamera found")

local camObj
local ok, err = pcall(function()
    camObj = player:WaitForChild("PlayerScripts", 10)
                   :WaitForChild("PlayerModule", 10)
                   :WaitForChild("CameraCFrame", 10)
end)
if not ok or not camObj then
    warn("[CameraSync] Failed to get CameraCFrame:", err)
    return SafeScript
end
print("[CameraSync] CameraCFrame object found:", camObj:GetFullName())

local function connectRenderStepped()
    print("[CameraSync] Connecting RenderStepped")
    local conn = RunService.RenderStepped:Connect(function(dt)
        if SafeScript._active then
            if camera and camObj and camObj:IsA("CFrameValue") then
                local suc, e = pcall(function()
                    camObj.CFrame = camera.CFrame
                end)
                if not suc then
                    warn("[CameraSync] Error updating CameraCFrame:", e)
                else
                    print("[CameraSync] CameraCFrame synced at dt:", dt)
                end
            else
                warn("[CameraSync] Camera or camObj invalid")
            end
        else
            print("[CameraSync] RenderStepped called but _active = false")
        end
    end)
    table.insert(SafeScript._connections, conn)
    print("[CameraSync] RenderStepped connection created")
end

function SafeScript.start()
    if SafeScript._active then
        print("[CameraSync] start() called but already active")
        return
    end
    SafeScript._active = true
    print("[CameraSync] start() called, _active set to true")
    if #SafeScript._connections == 0 then
        connectRenderStepped()
    else
        print("[CameraSync] Reusing existing connections")
    end
end

function SafeScript.stop()
    SafeScript._active = false
    print("[CameraSync] stop() called, _active set to false")
end

function SafeScript.Shutdown()
    SafeScript._active = false
    print("[CameraSync] Shutdown called, cleaning up connections")
    for i, c in ipairs(SafeScript._connections) do
        if c and c.Disconnect then
            local suc, e = pcall(function()
                c:Disconnect()
            end)
            if not suc then
                warn("[CameraSync] Error disconnecting connection", i, e)
            else
                print("[CameraSync] Connection", i, "disconnected")
            end
        else
            print("[CameraSync] Connection", i, "invalid or already disconnected")
        end
    end
    SafeScript._connections = {}
    print("[CameraSync] Shutdown complete")
end

print("[CameraSync] Script ready")
return SafeScript

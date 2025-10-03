local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local SafeScript = {}
SafeScript._connections = {}
SafeScript._active = false
SafeScript._camObjReady = false

print("[CameraSync2] Script loaded")

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
-- Attempt to get CameraCFrame safely, retrying
local function fetchCamObj()
    local retries = 0
    local maxRetries = 20
    while retries < maxRetries do
        local ok, obj = pcall(function()
            return player:WaitForChild("PlayerScripts", 1)
                         :WaitForChild("PlayerModule", 1)
                         :WaitForChild("CameraCFrame", 1)
        end)
        if ok and obj then
            camObj = obj
            print("[CameraSync] CameraCFrame object found:", camObj:GetFullName())
            SafeScript._camObjReady = true
            return true
        end
        retries = retries + 1
        task.wait(0.5)
        print("[CameraSync] Waiting for CameraCFrame, attempt", retries)
    end
    warn("[CameraSync] Failed to fetch CameraCFrame after", maxRetries, "attempts")
    return false
end

local function connectRenderStepped()
    print("[CameraSync] Connecting RenderStepped")
    local conn = RunService.RenderStepped:Connect(function(dt)
        if not SafeScript._active then
            return
        end
        if not SafeScript._camObjReady or not camera or not camObj or not camObj:IsA("CFrameValue") then
            warn("[CameraSync] Camera or camObj invalid")
            return
        end
        local suc, e = pcall(function()
            camObj.CFrame = camera.CFrame
        end)
        if not suc then
            warn("[CameraSync] Error updating CameraCFrame:", e)
        else
            -- Uncomment for frame-by-frame debug
            -- print("[CameraSync] CameraCFrame synced at dt:", dt)
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
    print("[CameraSync] start() called, fetching CameraCFrame...")
    local ok = fetchCamObj()
    if not ok then
        warn("[CameraSync] Cannot start: CameraCFrame not ready")
        return
    end
    SafeScript._active = true
    connectRenderStepped()
    print("[CameraSync] Script is now active")
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
            local suc, e = pcall(function() c:Disconnect() end)
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

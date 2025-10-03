local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local SafeScript = {}
SafeScript._connections = {}
SafeScript._active = false

local function safeConnect(signal, func)
    local ok, conn = pcall(function()
        return signal:Connect(function(...)
            if not SafeScript._active then return end
            local s, e = pcall(func, ...)
            if not s then warn("Error in connection:", e) end
        end)
    end)
    if ok and conn then
        table.insert(SafeScript._connections, conn)
    elseif not ok then
        warn("Failed to connect:", conn)
    end
end

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

function SafeScript.start()
    if SafeScript._active then return end
    SafeScript._active = true

    if #SafeScript._connections == 0 then
        safeConnect(RunService.RenderStepped, function()
            if not camera or not camObj or not camObj:IsA("CFrameValue") then return end
            camObj.CFrame = camera.CFrame
        end)
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

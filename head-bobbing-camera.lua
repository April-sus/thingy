-- Head Bobbing Camera Script for Roblox

local player = game.Players.LocalPlayer
local camera = workspace.CurrentCamera
local runService = game:GetService("RunService")

local head = player.Character:WaitForChild("Head")

-- Settings
local bobAmount = 0.1 -- Amount of head bobbing
local bobSpeed = 10 -- Speed of head bobbing
local transparency = 0.5 -- Transparency of head
local cameraOffset = Vector3.new(0, 1.5, 0) -- Camera offset

-- Function to update camera and head movement
local function updateCamera()
    local time = tick()
    local bobbing = math.sin(time * bobSpeed) * bobAmount

    -- Update camera position
    camera.CFrame = camera.CFrame * CFrame.new(0, bobbing, 0) + cameraOffset

    -- Update head transparency
    head.Transparency = transparency
end

-- Update the camera in a loop
runService.RenderStepped:Connect(updateCamera)

-- Vehicle handling (if applicable)
local function onVehicleEnter(vehicle)
    -- Add vehicle specific handling here
end

-- Connect to vehicle events
-- Example: player.Character.Humanoid.SeatedChanged:Connect(onVehicleEnter)

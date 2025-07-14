-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Player
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

-- GUI Setup
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "TeleportGUI"

-- Teleport spots table
local tpSpots = {}

-- Function to create a button
local function createButton(text, position, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 180, 0, 35)
    button.Position = position
    button.Text = text
    button.BackgroundColor3 = Color3.fromRGB(60, 120, 180)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Font = Enum.Font.SourceSansBold
    button.TextSize = 18
    button.Parent = screenGui
    button.MouseButton1Click:Connect(callback)
end

-- Create Save TP and TP buttons
for i = 1, 3 do
    -- Save Button
    createButton("Save TP Spot " .. i, UDim2.new(0, 10, 0, 10 + (i - 1) * 80), function()
        tpSpots[i] = humanoidRootPart.Position
        print("Saved TP Spot " .. i)
    end)

    -- Teleport Button
    createButton("Teleport to Spot " .. i, UDim2.new(0, 10, 0, 45 + (i - 1) * 80), function()
        if tpSpots[i] then
            humanoidRootPart.CFrame = CFrame.new(tpSpots[i])
        else
            warn("TP Spot " .. i .. " not saved.")
        end
    end)
end

-- Final "Finish" Button
createButton("Run 'Finish' Event", UDim2.new(0, 10, 0, 260), function()
    local args = { [1] = "Finish" }

    local fruitMinigameEvent = ReplicatedStorage
        :WaitForChild("Remote", 9e9)
        :WaitForChild("FruitMinigameEvent", 9e9)

    fruitMinigameEvent:FireServer(unpack(args))
end)

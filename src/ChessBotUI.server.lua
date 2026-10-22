-- ChessBotUI.server.lua

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Create a RemoteEvent for communication between client and server
local ToggleBotEvent = Instance.new("RemoteEvent")
ToggleBotEvent.Name = "ToggleBotEvent"
ToggleBotEvent.Parent = ReplicatedStorage

local ChangeEloEvent = Instance.new("RemoteEvent")
ChangeEloEvent.Name = "ChangeEloEvent"
ChangeEloEvent.Parent = ReplicatedStorage

-- Function to create the UI for a player
local function createUI(player)
    local playerGui = Instance.new("ScreenGui")
    playerGui.Name = "ChessBotUI"
    playerGui.Parent = player:WaitForChild("PlayerGui")

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 200, 0, 150)
    frame.Position = UDim2.new(0.5, -100, 0.5, -75)
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    frame.Parent = playerGui

    local toggleButton = Instance.new("TextButton")
    toggleButton.Size = UDim2.new(0, 180, 0, 40)
    toggleButton.Position = UDim2.new(0.5, 0, 0, 10)
    toggleButton.AnchorPoint = Vector2.new(0.5, 0)
    toggleButton.Text = "Toggle Bot"
    toggleButton.Parent = frame

    local eloLabel = Instance.new("TextLabel")
    eloLabel.Size = UDim2.new(0, 180, 0, 20)
    eloLabel.Position = UDim2.new(0.5, 0, 0, 60)
    eloLabel.AnchorPoint = Vector2.new(0.5, 0)
    eloLabel.Text = "ELO: 1000"
    eloLabel.Parent = frame

    local eloSlider = Instance.new("TextBox")
    eloSlider.Size = UDim2.new(0, 180, 0, 30)
    eloSlider.Position = UDim2.new(0.5, 0, 0, 90)
    eloSlider.AnchorPoint = Vector2.new(0.5, 0)
    eloSlider.Text = "1000"
    eloSlider.Parent = frame

    local changeEloButton = Instance.new("TextButton")
    changeEloButton.Size = UDim2.new(0, 180, 0, 30)
    changeEloButton.Position = UDim2.new(0.5, 0, 0, 130)
    changeEloButton.AnchorPoint = Vector2.new(0.5, 0)
    changeEloButton.Text = "Change ELO"
    changeEloButton.Parent = frame

    -- Event handlers
    toggleButton.MouseButton1Click:Connect(function()
        ToggleBotEvent:FireClient(player)
    end)

    changeEloButton.MouseButton1Click:Connect(function()
        local newElo = tonumber(eloSlider.Text)
        if newElo then
            ChangeEloEvent:FireClient(player, newElo)
        end
    end)
end

-- Connect to player added event
Players.PlayerAdded:Connect(createUI)

-- Handle ToggleBotEvent
ToggleBotEvent.OnServerEvent:Connect(function(player)
    -- Toggle bot logic here
    print(player.Name .. " toggled the bot")
end)

-- Handle ChangeEloEvent
ChangeEloEvent.OnServerEvent:Connect(function(player, newElo)
    -- Change ELO logic here
    print(player.Name .. " changed ELO to " .. newElo)
end)

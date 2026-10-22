-- ChessBotUI.client.lua

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local chessBotUI = playerGui:WaitForChild("ChessBotUI")

local ToggleBotEvent = ReplicatedStorage:WaitForChild("ToggleBotEvent")
local ChangeEloEvent = ReplicatedStorage:WaitForChild("ChangeEloEvent")

-- Function to toggle the bot
local function toggleBot()
    ToggleBotEvent:FireServer()
end

-- Function to change the ELO
local function changeElo(newElo)
    ChangeEloEvent:FireServer(newElo)
end

-- Connect UI elements to functions
local frame = chessBotUI:WaitForChild("Frame")
local toggleButton = frame:WaitForChild("ToggleButton")
local eloSlider = frame:WaitForChild("EloSlider")
local changeEloButton = frame:WaitForChild("ChangeEloButton")

-- Event handlers
ToggleBotEvent.OnClientEvent:Connect(toggleBot)
ChangeEloEvent.OnClientEvent:Connect(changeElo)

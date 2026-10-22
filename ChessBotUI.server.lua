-- ChessBotUI.server.lua

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local ChessBotUI = Instance.new("ScreenGui")
ChessBotUI.Name = "ChessBotUI"
ChessBotUI.ResetOnSpawn = false

local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "ToggleButton"
ToggleButton.Size = UDim2.new(0, 100, 0, 50)
ToggleButton.Position = UDim2.new(0.5, -50, 0.5, -25)
ToggleButton.Text = "Bot: OFF"
ToggleButton.Parent = ChessBotUI

local EloButton = Instance.new("TextButton")
EloButton.Name = "EloButton"
EloButton.Size = UDim2.new(0, 100, 0, 50)
EloButton.Position = UDim2.new(0.5, -50, 0.5, 30)
EloButton.Text = "Change Elo"
EloButton.Parent = ChessBotUI

local function toggleBot()
    -- Toggle bot logic
    if ToggleButton.Text == "Bot: OFF" then
        ToggleButton.Text = "Bot: ON"
    else
        ToggleButton.Text = "Bot: OFF"
    end
end

local function changeElo()
    -- Change elo logic
    print("Elo changed")
end

ToggleButton.MouseButton1Click:Connect(toggleBot)
EloButton.MouseButton1Click:Connect(changeElo)

local function onPlayerAdded(player)
    local clone = ChessBotUI:Clone()
    clone.Parent = player:WaitForChild("PlayerGui")
end

Players.PlayerAdded:Connect(onPlayerAdded)

-- Initialize Stockfish
local Stockfish = require(game:GetService("ServerScriptService"):WaitForChild("Stockfish"))

local function getBestMove(fen)
    -- Get best move from Stockfish
    local bestMove = Stockfish.getBestMove(fen)
    return bestMove
end

-- Example usage
local fen = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1"
local bestMove = getBestMove(fen)
print("Best move: " .. bestMove)

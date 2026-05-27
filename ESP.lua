if getgenv().EnemyESPLoaded then
    return
end

getgenv().EnemyESPLoaded = true

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local ESPCache = {}

local function IsEnemy(player)
    if player == LocalPlayer then
        return false
    end

    if not LocalPlayer.Team or not player.Team then
        return true
    end

    return LocalPlayer.Team ~= player.Team
end

local function RemoveESP(player)
    local esp = ESPCache[player]

    if esp then
        esp:Destroy()
        ESPCache[player] = nil
    end
end

local function CreateESP(player, character)
    RemoveESP(player)

    local highlight = Instance.new("Highlight")
    highlight.Name = "EnemyESP"

    highlight.FillColor = Color3.fromRGB(255, 0, 0)
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)

    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0

    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Adornee = character
    highlight.Parent = character

    ESPCache[player] = highlight
end

local function UpdateESP(player)
    if not IsEnemy(player) then
        RemoveESP(player)
        return
    end

    local character = player.Character

    if not character then
        RemoveESP(player)
        return
    end

    local humanoid = character:FindFirstChildWhichIsA("Humanoid")

    if not humanoid then
        RemoveESP(player)
        return
    end

    if humanoid.Health <= 0 then
        RemoveESP(player)
        return
    end

    local currentESP = ESPCache[player]

    if currentESP and currentESP.Parent == character then
        return
    end

    CreateESP(player, character)
end

local function SetupCharacter(player, character)
    local humanoid = character:WaitForChild("Humanoid", 10)

    if not humanoid then
        return
    end

    UpdateESP(player)

    humanoid.Died:Connect(function()
        RemoveESP(player)
    end)

    humanoid:GetPropertyChangedSignal("Health"):Connect(function()
        if humanoid.Health <= 0 then
            RemoveESP(player)
        end
    end)
end

local function SetupPlayer(player)
    if player == LocalPlayer then
        return
    end

    if player.Character then
        task.spawn(SetupCharacter, player, player.Character)
    end

    player.CharacterAdded:Connect(function(character)
        task.spawn(SetupCharacter, player, character)
    end)

    player:GetPropertyChangedSignal("Team"):Connect(function()
        UpdateESP(player)
    end)
end

for _, player in ipairs(Players:GetPlayers()) do
    SetupPlayer(player)
end

Players.PlayerAdded:Connect(SetupPlayer)

Players.PlayerRemoving:Connect(function(player)
    RemoveESP(player)
end)

LocalPlayer:GetPropertyChangedSignal("Team"):Connect(function()
    for _, player in ipairs(Players:GetPlayers()) do
        UpdateESP(player)
    end
end)

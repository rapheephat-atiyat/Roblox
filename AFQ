local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Dabixic/windmodv4/refs/heads/main/lua"))()

-- Services & Variables
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local AutoFarmEnabled = false
local FastAttackEnabled = false
local FastAttackOneEyedReaperEnabled = false
local CriticalAttackEnabled = false
local CriticalAttackChildOfSunEnabled = false
local CriticalAttackKingOfCurseEnabled = false
local CriticalAttackOneEyedReaperEnabled = false
local CriticalAttackUmbrellaEnabled = false
local CriticalAttackQuincyEnabled = false
local AutoSkillEnabled = false
local SkillKeys = {
    Skill1 = false,
    Skill2 = false,
    Skill3 = false,
    SkillG = false,
    SkillF = false,
    SkillX = false
}

-- Remote Event Setup
local dataRemote = ReplicatedStorage:WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent")

-- Generic Attack Function (Merged for all weapons/styles)
local function FireAttackEvent(hitCountValue)
    local args = {
        {
            {
                state = Enum.HumanoidStateType.Running,
                hitcount = hitCountValue
            },
            "\f"
        }
    }
    dataRemote:FireServer(unpack(args))
end

-- Window Initialization
local Window = WindUI:CreateWindow({
    Title = "Rex Hub",
    Icon = "sword",
    Author = "by Rex",
    Folder = "RexHub_AFQ",
    Size = UDim2.fromOffset(580, 460),
    Transparent = true,
    Theme = "Midnight",
    SideBarWidth = 200,
    HasOutline = true,
})

Window:EditOpenButton({
    Title = "Open Rex Hub",
    Icon = "monitor",
    CornerRadius = UDim.new(0,16),
    StrokeThickness = 2,
    Color = ColorSequence.new(
        Color3.fromHex("FF0F7B"), 
        Color3.fromHex("F89B29")
    ),
    Draggable = true,
})

local Tabs = {
    Main = Window:Tab({ Title = "Main", Icon = "house", Desc = "Combat & Farming" }),
    Skill = Window:Tab({ Title = "Auto Skill", Icon = "sparkles", Desc = "Skill Automation" }),
    Config = Window:Tab({ Title = "Settings", Icon = "settings", Desc = "UI & Configuration" }),
}

-- Main Tab Sections
Tabs.Main:Section({ Title = "Combat Modules" })

Tabs.Main:Toggle({
    Title = "Enable Auto Farm (Teleport)",
    Value = false,
    Callback = function(value) 
        AutoFarmEnabled = value
    end
})

Tabs.Main:Toggle({
    Title = "Fast Attack (King Ripper Only)",
    Value = false,
    Callback = function(value) 
        FastAttackEnabled = value
    end
})

Tabs.Main:Toggle({
    Title = "Critical Attack (Hwak Only)",
    Value = false,
    Callback = function(value) 
        CriticalAttackEnabled = value
    end
})

Tabs.Main:Toggle({
    Title = "Critical Attack (Child Of Sun Only)",
    Value = false,
    Callback = function(value) 
        CriticalAttackChildOfSunEnabled = value
    end
})

Tabs.Main:Toggle({
    Title = "Critical Attack (King of Curse Only)",
    Value = false,
    Callback = function(value) 
        CriticalAttackKingOfCurseEnabled = value
    end
})

Tabs.Main:Toggle({
    Title = "Fast Attack (One-Eyed Reaper Only)",
    Value = false,
    Callback = function(value) 
        FastAttackOneEyedReaperEnabled = value
    end
})

Tabs.Main:Toggle({
    Title = "Critical Attack (One-Eyed Reaper Only)",
    Value = false,
    Callback = function(value) 
        CriticalAttackOneEyedReaperEnabled = value
    end
})

Tabs.Main:Toggle({
    Title = "Critical Attack (Umbrella Only)",
    Value = false,
    Callback = function(value) 
        CriticalAttackUmbrellaEnabled = value
    end
})

Tabs.Main:Toggle({
    Title = "Critical Attack (Quincy Only)",
    Value = false,
    Callback = function(value) 
        CriticalAttackQuincyEnabled = value
    end
})

-- Auto Skill Tab
Tabs.Skill:Section({ Title = "Skill Automation" })

Tabs.Skill:Toggle({
    Title = "Enable Auto Skill",
    Value = false,
    Callback = function(value) 
        AutoSkillEnabled = value
    end
})

Tabs.Skill:Divider()

Tabs.Skill:Toggle({
    Title = "Skill 1",
    Value = true,
    Callback = function(value) 
        SkillKeys.Skill1 = value
    end
})

Tabs.Skill:Toggle({
    Title = "Skill 2",
    Value = true,
    Callback = function(value) 
        SkillKeys.Skill2 = value
    end
})

Tabs.Skill:Toggle({
    Title = "Skill 3",
    Value = true,
    Callback = function(value) 
        SkillKeys.Skill3 = value
    end
})

Tabs.Skill:Toggle({
    Title = "Skill G",
    Value = true,
    Callback = function(value) 
        SkillKeys.SkillG = value
    end
})

Tabs.Skill:Toggle({
    Title = "Skill F",
    Value = true,
    Callback = function(value) 
        SkillKeys.SkillF = value
    end
})

Tabs.Skill:Toggle({
    Title = "Skill X",
    Value = true,
    Callback = function(value) 
        SkillKeys.SkillX = value
    end
})

-- Settings Tab (UI Configuration)
Tabs.Config:Section({ Title = "Window Settings" })

local themeValues = {}
for name, _ in pairs(WindUI:GetThemes()) do
    table.insert(themeValues, name)
end

local themeDropdown = Tabs.Config:Dropdown({
    Title = "Select Theme",
    Multi = false,
    AllowNone = false,
    Value = WindUI:GetCurrentTheme(),
    Values = themeValues,
    Callback = function(theme)
        WindUI:SetTheme(theme)
    end
})

Tabs.Config:Toggle({
    Title = "Window Transparency",
    Value = WindUI:GetTransparency(),
    Callback = function(value)
        Window:ToggleTransparency(value)
    end,
})

Tabs.Config:Keybind({
    Title = "Minimize Key",
    Desc = "Key to toggle UI visibility",
    Value = "LeftControl",
    Callback = function(v)
        Window:SetToggleKey(Enum.KeyCode[v])
    end
})

-- [THREAD 1] For Auto Farm (Focus on Movement)
task.spawn(function()
    while true do
        if AutoFarmEnabled then
            pcall(function()
                local character = LocalPlayer.Character
                local root = character and character:FindFirstChild("HumanoidRootPart")
                
                if root then
                    for _, npc in pairs(workspace.NPCs:GetChildren()) do
                        local humanoid = npc:FindFirstChildOfClass("Humanoid")
                        local hrp = npc:FindFirstChild("HumanoidRootPart")
                        
                        if humanoid and hrp and humanoid.Health > 0 then
                            -- Warp above head
                            root.CFrame = hrp.CFrame * CFrame.new(0, 5, 0) * CFrame.Angles(math.rad(-90), 0, 0)
                            break
                        end
                    end
                end
            end)
        end
        task.wait(0.1)
    end
end)

-- [THREAD 2] Attacks (Merged into a single loop)
task.spawn(function()
    while true do
        if FastAttackEnabled then FireAttackEvent(3) end
        if CriticalAttackEnabled then FireAttackEvent(4) end
        if CriticalAttackChildOfSunEnabled then FireAttackEvent(4) end
        if CriticalAttackKingOfCurseEnabled then FireAttackEvent(4) end
        if FastAttackOneEyedReaperEnabled then FireAttackEvent(3) end
        if CriticalAttackOneEyedReaperEnabled then FireAttackEvent(4) end
        if CriticalAttackUmbrellaEnabled then FireAttackEvent(4) end
        if CriticalAttackQuincyEnabled then FireAttackEvent(4) end
        task.wait()
    end
end)

-- [THREAD 3] For Auto Skill
task.spawn(function()
    local UserInputService = game:GetService("UserInputService")
    local skillKeysMap = {
        Skill1 = Enum.KeyCode.One,
        Skill2 = Enum.KeyCode.Two,
        Skill3 = Enum.KeyCode.Three,
        SkillG = Enum.KeyCode.G,
        SkillF = Enum.KeyCode.F,
        SkillX = Enum.KeyCode.X
    }
    
    while true do
        if AutoSkillEnabled then
            for skillName, keyCode in pairs(skillKeysMap) do
                if SkillKeys[skillName] then
                    pcall(function()
                        UserInputService:SendKeyEvent(true, keyCode, false, game)
                        task.wait(0.05)
                        UserInputService:SendKeyEvent(false, keyCode, false, game)
                    end)
                    task.wait(0.1)
                end
            end
        end
        task.wait(0.5)
    end
end)

Window:SelectTab(1)

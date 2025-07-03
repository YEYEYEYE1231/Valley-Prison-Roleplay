-- Street Life Remastered | Ultimate Hub
-- Compatible with Latest PC Executors: Wave, Fluxus V5, Electron, Delta
-- Use with robloxhackers.lol latest executor wave exploit updates

-- Script Name: streetlife_ultimatehub.lua
-- GitHub Repository: https://github.com/YEYEYEYE1231/Valley-Prison-Roleplay/blob/main/streetlife_ultimatehub.lua

-- Auto-Updater Loader
if not game:IsLoaded() then game.Loaded:Wait() end
local latestScript = game:HttpGet("https://raw.githubusercontent.com/YEYEYEYE1231/Valley-Prison-Roleplay/main/streetlife_ultimatehub.lua")
loadstring(latestScript)()

-- Executor Compatibility Check
local supportedExecutors = {"Wave", "Fluxus", "Electron", "Delta"}
local executorFound = false
for _, exec in pairs(supportedExecutors) do
    if identifyexecutor and string.find(identifyexecutor():lower(), exec:lower()) then
        executorFound = true
        break
    end
end

if not executorFound then
    game.Players.LocalPlayer:Kick("Unsupported Executor. Please use Wave, Fluxus V5, Electron, or Delta.")
    return
end

-- Load Kavo UI Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Street Life Remastered | Ultimate Hub", "Sentinel")

-- Auto Theme Switcher
local themeOptions = {Wave = "Ocean", Fluxus = "BloodTheme", Electron = "Midnight", Delta = "Sentinel"}
local currentExecutor = identifyexecutor and identifyexecutor():lower() or "default"
local currentTheme = "Sentinel"

for exec, theme in pairs(themeOptions) do
    if string.find(currentExecutor, exec:lower()) then
        currentTheme = theme
    end
end

-- Segmented Loader
local function loadMain()
    -- Tabs
    local Main = Window:NewTab("Main")
    local MainSection = Main:NewSection("Main Controls")

    MainSection:NewButton("Add New Game", "Load another script hub", function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/YEYEYEYE1231/Valley-Prison-Roleplay/main/streetlife_ultimatehub.lua"))()
    end)

    MainSection:NewButton("ATM Deposit & Withdraw", "Automate ATM interaction", function()
        -- Placeholder for ATM Auto Interaction
    end)

    MainSection:NewButton("Quick Access", "Quick buttons for essentials", function()
        -- Placeholder for Quick Access (TP to Shop/Bank)
    end)
end

local function loadCombat()
    local Combat = Window:NewTab("Combat")
    local CombatSection = Combat:NewSection("Combat Hacks")

    CombatSection:NewToggle("Godmode (Fist)", "Become invincible to fist damage", function(state)
        if state then
            game.Players.LocalPlayer.Character.Humanoid:GetPropertyChangedSignal("Health"):Connect(function()
                if game.Players.LocalPlayer.Character.Humanoid.Health < 100 then
                    game.Players.LocalPlayer.Character.Humanoid.Health = 100
                end
            end)
        end
    end)

    CombatSection:NewToggle("KillAura (Fist)", "Auto attack nearby enemies", function(state)
        getgenv().KillAuraEnabled = state
        while getgenv().KillAuraEnabled do
            for _, player in pairs(game.Players:GetPlayers()) do
                if player ~= game.Players.LocalPlayer and player.Character and (player.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 15 then
                    game:GetService("ReplicatedStorage").Events.Punch:FireServer(player.Character)
                end
            end
            wait(0.2)
        end
    end)

    CombatSection:NewButton("Kill All (Gun)", "Eliminate all players (Wave, Fluxus V5 Recommended)", function()
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer and player.Character then
                game:GetService("ReplicatedStorage").Events.Shoot:FireServer(player.Character.Head.Position)
            end
        end
    end)

    CombatSection:NewToggle("Silent Aim", "Automatic silent targeting", function(state)
        SilentAimEnabled = state
    end)

    CombatSection:NewToggle("Infinite Ammo", "Never run out of ammo", function(state)
        if state then
            local oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
                local args = {...}
                if getnamecallmethod() == "FireServer" and tostring(self) == "AmmoChange" then
                    args[2] = 9999
                    return self.FireServer(self, unpack(args))
                end
                return oldNamecall(self, ...)
            end)
        end
    end)
end

local function loadESP()
    local Visuals = Window:NewTab("Visuals")
    local VisualsSection = Visuals:NewSection("ESP & Visuals")

    VisualsSection:NewToggle("ESP Players", "See all players through walls", function(state)
        ESPEnabled = state
    end)

    VisualsSection:NewToggle("ESP Objects", "See interactable objects", function(state)
        -- Placeholder for ESP Objects
    end)

    VisualsSection:NewToggle("Glowing Hover", "Hover names with glow effect", function(state)
        -- Placeholder for Hover Glow Effect
    end)
end

local function loadMovement()
    local Movement = Window:NewTab("Movement")
    local MovementSection = Movement:NewSection("Movement Hacks")

    MovementSection:NewSlider("Walkspeed", "Change your walking speed", 100, 16, function(speed)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = speed
    end)

    MovementSection:NewToggle("Infinite Stamina", "Unlimited running stamina", function(state)
        if state then
            game.Players.LocalPlayer.Character.Stamina.Value = 100
        end
    end)

    MovementSection:NewToggle("Noclip", "Walk through walls", function(state)
        local RunService = game:GetService("RunService")
        local noclip = state
        RunService.Stepped:Connect(function()
            if noclip then
                for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                    if v:IsA("BasePart") and v.CanCollide == true then
                        v.CanCollide = false
                    end
                end
            end
        end)
    end)
end

local function loadSettings()
    local Settings = Window:NewTab("Settings")
    local SettingsSection = Settings:NewSection("Settings")

    SettingsSection:NewSlider("Clocktime", "Adjust in-game time", 24, 0, function(time)
        game.Lighting.ClockTime = time
    end)

    SettingsSection:NewButton("Reset Walkspeed", "Reset to default speed", function()
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
    end)

    SettingsSection:NewDropdown("UI Theme", "Change UI Theme", {"Ocean", "BloodTheme", "Sentinel", "Midnight", "Synapse"}, function(currentOption)
        -- UI reload recommended for full effect
    end)

    SettingsSection:NewKeybind("Toggle UI", "Keybind to show/hide UI", Enum.KeyCode.RightControl, function()
        Library:ToggleUI()
    end)
end

-- Load All Segments
loadMain()
loadCombat()
loadESP()
loadMovement()
loadSettings()

-- Silent Aim & ESP Core
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local SilentAimEnabled = false
local ESPEnabled = false

local function getClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = math.huge
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
            local pos, onScreen = workspace.CurrentCamera:WorldToScreenPoint(player.Character.HumanoidRootPart.Position)
            if onScreen then
                local distance = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(pos.X, pos.Y)).Magnitude
                if distance < shortestDistance then
                    shortestDistance = distance
                    closestPlayer = player
                end
            end
        end
    end
    return closestPlayer
end

local function setupESP(player)
    local Billboard = Instance.new("BillboardGui", player.Character.Head)
    Billboard.Size = UDim2.new(0, 100, 0, 40)
    Billboard.Adornee = player.Character.Head
    Billboard.AlwaysOnTop = true

    local NameTag = Instance.new("TextLabel", Billboard)
    NameTag.Size = UDim2.new(1, 0, 1, 0)
    NameTag.BackgroundTransparency = 1
    NameTag.Text = player.Name
    NameTag.TextColor3 = Color3.new(1, 0, 0)
    NameTag.TextStrokeTransparency = 0
end

RunService.RenderStepped:Connect(function()
    if SilentAimEnabled then
        local target = getClosestPlayer()
        if target then
            workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, target.Character.Head.Position)
        end
    end

    if ESPEnabled then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and not player.Character.Head:FindFirstChild("BillboardGui") then
                setupESP(player)
            end
        end
    end
end)

-- Anti-Detection Layer (Basic)
local oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
    local args = {...}
    if tostring(self) == "Kick" then
        return nil
    end
    return oldNamecall(self, ...)
end)

-- UI Loaded
print("Street Life Remastered | Ultimate Hub Loaded Successfully!")

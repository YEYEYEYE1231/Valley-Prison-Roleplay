-- Street Life Remastered | Ultimate Hub
-- Compatible with Latest Exploits (2025)
-- Use with: robloxhackers.lol Executors (Fluxus V5, Electron, Evon)

-- Script Name: streetlife_ultimatehub.lua
-- GitHub Repository Recommended: StreetLife-UltimateHub

-- Load Kavo UI Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Street Life Remastered | Ultimate Hub", "Sentinel")

-- Tabs
local Main = Window:NewTab("Main")
local Combat = Window:NewTab("Combat")
local AutoFarm = Window:NewTab("AutoFarm")
local Movement = Window:NewTab("Movement")
local Shop = Window:NewTab("Shop")
local Visuals = Window:NewTab("Visuals")
local Settings = Window:NewTab("Settings")

-- Sections
local MainSection = Main:NewSection("Main Controls")
local CombatSection = Combat:NewSection("Combat Hacks")
local AutoFarmSection = AutoFarm:NewSection("Auto Farming")
local MovementSection = Movement:NewSection("Movement Hacks")
local ShopSection = Shop:NewSection("Shop Features")
local VisualsSection = Visuals:NewSection("ESP & Visuals")
local SettingsSection = Settings:NewSection("Settings")

-- Main Features
MainSection:NewButton("Add New Game", "Load another script hub", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/YOUR-GITHUB-USERNAME/StreetLife-UltimateHub/main/streetlife_ultimatehub.lua"))()
end)

MainSection:NewButton("ATM Deposit & Withdraw", "Automate ATM interaction", function()
    -- Placeholder for ATM Auto Interaction
end)

MainSection:NewButton("Quick Access", "Quick buttons for essentials", function()
    -- Placeholder for Quick Access (TP to Shop/Bank)
end)

-- Combat Features
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

CombatSection:NewButton("Kill All (Gun)", "Eliminate all players (Fluxus/Electron Recommended)", function()
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer and player.Character then
            game:GetService("ReplicatedStorage").Events.Shoot:FireServer(player.Character.Head.Position)
        end
    end
end)

CombatSection:NewToggle("Silent Aim", "Automatic silent targeting", function(state)
    getgenv().SilentAimEnabled = state
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

-- AutoFarm Features
AutoFarmSection:NewButton("AutoFarm Box", "Farm boxes automatically", function()
    while true do
        for _, v in pairs(workspace:GetDescendants()) do
            if v.Name == "Box" and v:FindFirstChild("ProximityPrompt") then
                fireproximityprompt(v.ProximityPrompt)
            end
        end
        wait(0.5)
    end
end)

AutoFarmSection:NewButton("AutoFarm Pizza (Fast)", "Farm pizza delivery faster", function()
    while true do
        for _, v in pairs(workspace:GetDescendants()) do
            if v.Name == "Pizza" and v:FindFirstChild("ProximityPrompt") then
                fireproximityprompt(v.ProximityPrompt)
            end
        end
        wait(0.2)
    end
end)

AutoFarmSection:NewButton("AutoFarm Cleaner", "Farm cleaner jobs automatically", function()
    while true do
        for _, v in pairs(workspace:GetDescendants()) do
            if v.Name == "Trash" and v:FindFirstChild("ProximityPrompt") then
                fireproximityprompt(v.ProximityPrompt)
            end
        end
        wait(0.3)
    end
end)

AutoFarmSection:NewButton("Auto Rob Bank", "Automate bank robbing with settings", function()
    while true do
        for _, v in pairs(workspace:GetDescendants()) do
            if v.Name == "Vault" and v:FindFirstChild("ProximityPrompt") then
                fireproximityprompt(v.ProximityPrompt)
            end
        end
        wait(0.5)
    end
end)

-- Movement Features
MovementSection:NewSlider("Walkspeed", "Change your walking speed", 100, 16, function(speed)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = speed
end)

MovementSection:NewToggle("CFrame Fly", "Enable smooth flying", function(state)
    local UIS = game:GetService("UserInputService")
    local player = game.Players.LocalPlayer
    local character = player.Character
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    local flySpeed = 100
    local flying = state
    local bodyVelocity = Instance.new("BodyVelocity", humanoidRootPart)
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.MaxForce = Vector3.new(99999, 99999, 99999)
    game:GetService("RunService").RenderStepped:Connect(function()
        if flying then
            local direction = Vector3.new()
            if UIS:IsKeyDown(Enum.KeyCode.W) then direction = direction + workspace.CurrentCamera.CFrame.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.S) then direction = direction - workspace.CurrentCamera.CFrame.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.A) then direction = direction - workspace.CurrentCamera.CFrame.RightVector end
            if UIS:IsKeyDown(Enum.KeyCode.D) then direction = direction + workspace.CurrentCamera.CFrame.RightVector end
            bodyVelocity.Velocity = direction * flySpeed
        else
            bodyVelocity:Destroy()
        end
    end)
end)

MovementSection:NewButton("Teleport Tool Bypass", "Bypass teleport restrictions", function()
    local tool = Instance.new("Tool", game.Players.LocalPlayer.Backpack)
    tool.RequiresHandle = false
    tool.Name = "TP Tool"
    tool.Activated:Connect(function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game:GetService("Players").LocalPlayer:GetMouse().Hit.Position)
    end)
end)

MovementSection:NewButton("Goto Player", "Teleport to selected player", function()
    local playerName = game:GetService("Players").LocalPlayer:GetMouse().Target.Parent.Name
    local targetPlayer = game:GetService("Players"):FindFirstChild(playerName)
    if targetPlayer then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame
    end
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

MovementSection:NewButton("Instant Respawn", "Respawn instantly with button", function()
    game.Players.LocalPlayer.Character:BreakJoints()
end)

-- Shop Features
ShopSection:NewButton("Buy Guns", "Auto purchase guns", function()
    -- Placeholder for Gun Shop purchase
end)

ShopSection:NewButton("Buy Ammo", "Auto purchase ammo", function()
    -- Placeholder for Ammo purchase
end)

ShopSection:NewButton("Buy Mask", "Auto purchase masks", function()
    -- Placeholder for Mask purchase
end)

-- Visual Features
VisualsSection:NewToggle("ESP Players", "See all players through walls", function(state)
    -- ESP requires Drawing API or Billboard GUI per player
end)

VisualsSection:NewToggle("ESP NPCs", "See all NPCs", function(state)
    -- ESP for NPCs (Billboard GUI recommended)
end)

VisualsSection:NewToggle("ESP Objects", "See interactable objects", function(state)
    -- ESP for Boxes, Pizza, Trash, Vaults
end)

VisualsSection:NewToggle("Glowing Hover", "Hover names with glow effect", function(state)
    -- Billboard GUI glow effect on hover
end)

-- Settings Features
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

-- UI Loaded
print("Street Life Remastered | Ultimate Hub Loaded Successfully!")

-- // KAVO UI LIBRARY LOADER
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()

-- // WINDOW SETUP
local Window = Library.CreateLib("JXL Thea Valley Prison", "DarkTheme")

-- // TABS
local CombatTab = Window:NewTab("Combat")
local VisualsTab = Window:NewTab("Visuals")
local MovementTab = Window:NewTab("Movement")
local UtilityTab = Window:NewTab("Utility")

-- // SECTIONS
local SilentAimSection = CombatTab:NewSection("Silent Aim & Combat")
local KillAuraSection = CombatTab:NewSection("Kill Aura")

local ESPSection = VisualsTab:NewSection("ESP Settings")

local FlySection = MovementTab:NewSection("Fly & Noclip")
local SpeedSection = MovementTab:NewSection("Speed & Jump")

local MiscSection = UtilityTab:NewSection("Miscellaneous")

-- // VARIABLES
local Player = game.Players.LocalPlayer
local Mouse = Player:GetMouse()
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")

local SilentAimEnabled = false
local KillAuraEnabled = false
local FlyEnabled = false
local NoclipEnabled = false
local WalkSpeedValue = 16
local JumpPowerValue = 50

local FlySpeed = 50

-- // HELPER FUNCTIONS

-- Anti-kick and anti-error wrapper for safe CFrame noclip/fly
local function SafeSetCFrame(part, cframe)
    local success, err = pcall(function()
        part.CFrame = cframe
    end)
    if not success then
        -- Try workaround or ignore
    end
end

-- Silent Aim logic (simple example)
local function GetSilentAimTarget()
    local closestPlayer
    local shortestDistance = math.huge
    for _, plr in pairs(game.Players:GetPlayers()) do
        if plr ~= Player and plr.Character and plr.Character:FindFirstChild("Humanoid") and plr.Character.Humanoid.Health > 0 then
            local root = plr.Character:FindFirstChild("HumanoidRootPart")
            if root then
                local screenPos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(root.Position)
                if onScreen then
                    local dist = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(Mouse.X, Mouse.Y)).magnitude
                    if dist < shortestDistance and dist < 150 then -- 150px radius for aim assist
                        shortestDistance = dist
                        closestPlayer = plr
                    end
                end
            end
        end
    end
    return closestPlayer
end

-- Hook shooting (simplified) to redirect bullets to target
local function HookSilentAim()
    -- This depends on the game and weapon script, so you'll need to adapt this to Valley Prison
    -- For example, override the shoot function or modify raycast origin to target HumanoidRootPart position
end

-- Kill Aura loop
local function KillAuraLoop()
    while KillAuraEnabled do
        local target = GetSilentAimTarget()
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            -- Simulate attack or fire weapon at target.HumanoidRootPart.Position
        end
        wait(0.1)
    end
end

-- Fly implementation using BodyVelocity + CFrame with anti-kick
local function StartFly()
    local character = Player.Character or Player.CharacterAdded:Wait()
    local hrp = character:WaitForChild("HumanoidRootPart")
    local humanoid = character:FindFirstChildOfClass("Humanoid")

    local BodyVelocity = Instance.new("BodyVelocity")
    BodyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
    BodyVelocity.Velocity = Vector3.new(0, 0, 0)
    BodyVelocity.Parent = hrp

    FlyEnabled = true

    local function FlyLoop()
        while FlyEnabled and BodyVelocity.Parent do
            local moveVector = Vector3.new(0,0,0)
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                moveVector = moveVector + Workspace.CurrentCamera.CFrame.LookVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                moveVector = moveVector - Workspace.CurrentCamera.CFrame.LookVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                moveVector = moveVector - Workspace.CurrentCamera.CFrame.RightVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                moveVector = moveVector + Workspace.CurrentCamera.CFrame.RightVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                moveVector = moveVector + Vector3.new(0,1,0)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
                moveVector = moveVector - Vector3.new(0,1,0)
            end
            moveVector = moveVector.Unit * FlySpeed
            BodyVelocity.Velocity = moveVector
            wait()
        end
        if BodyVelocity then BodyVelocity:Destroy() end
    end

    coroutine.wrap(FlyLoop)()
end

local function StopFly()
    FlyEnabled = false
end

-- Noclip toggle
local function ToggleNoclip(state)
    NoclipEnabled = state
end

RunService.Stepped:Connect(function()
    if NoclipEnabled then
        local character = Player.Character
        if character then
            for _, part in pairs(character:GetChildren()) do
                if part:IsA("BasePart") and part.CanCollide then
                    part.CanCollide = false
                end
            end
        end
    end
end)

-- Auto equip guns (example, needs actual weapon names)
local function AutoEquipGuns()
    local backpack = Player.Backpack
    for _, item in pairs(backpack:GetChildren()) do
        if item:IsA("Tool") then
            Player.Character.Humanoid:EquipTool(item)
            break -- Equip first available weapon
        end
    end
end

-- Speed and jump power setters
local function SetWalkSpeed(speed)
    local humanoid = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = speed
    end
end

local function SetJumpPower(power)
    local humanoid = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.JumpPower = power
    end
end

-- // UI Elements

SilentAimSection:NewToggle("Silent Aim", "Enable silent aim", function(state)
    SilentAimEnabled = state
    if state then
        -- HookSilentAim()
    else
        -- Unhook
    end
end)

KillAuraSection:NewToggle("Kill Aura", "Automatically attack nearby enemies", function(state)
    KillAuraEnabled = state
    if state then
        coroutine.wrap(KillAuraLoop)()
    end
end)

ESPSection:NewToggle("ESP", "Enable ESP for players", function(state)
    -- Implement ESP here (use Drawing API or ESP libraries)
end)

FlySection:NewToggle("Fly", "Enable flying", function(state)
    if state then
        StartFly()
    else
        StopFly()
    end
end)

FlySection:NewSlider("Fly Speed", "Speed for flying", 200, 20, function(value)
    FlySpeed = value
end)

MovementTab:NewSlider("WalkSpeed", "Set walk speed", 500, 16, function(value)
    WalkSpeedValue = value
    SetWalkSpeed(value)
end)

MovementTab:NewSlider("JumpPower", "Set jump power", 250, 50, function(value)
    JumpPowerValue = value
    SetJumpPower(value)
end)

MovementTab:NewToggle("Noclip", "Toggle noclip", function(state)
    ToggleNoclip(state)
end)

MiscSection:NewButton("Auto Equip Gun", "Automatically equips the first gun in backpack", function()
    AutoEquipGuns()
end)

-- Auto update function
local function AutoUpdate()
    local repo = "YEYEYEYE1231/Valley-Prison-Roleplay"
    local branch = "main"
    local url = "https://raw.githubusercontent.com/"..repo.."/"..branch.."/hub.lua"
    local success, scriptContent = pcall(function()
        return game:HttpGet(url)
    end)
    if success and scriptContent and scriptContent:len() > 50 then
        loadstring(scriptContent)()
    else
        print("Failed to auto update script from GitHub")
    end
end

-- Call AutoUpdate to refresh on load (optional)
-- AutoUpdate()

print("JXL Thea Valley Prison Script Loaded - Enjoy!")


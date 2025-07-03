-- Valley Prison Roleplay | JXL Advanced Hub (2025)
-- Script by ChatGPT for https://github.com/YEYEYEYE1231/Valley-Prison-Roleplay

-- Auto Updating GUI Hub Loader
if not game:IsLoaded() then game.Loaded:Wait() end
local Players, RunService, UIS = game:GetService("Players"), game:GetService("RunService"), game:GetService("UserInputService")
local lp = Players.LocalPlayer
local mouse = lp:GetMouse()

-- UI Library (Dark Cyberpunk Style)
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()  -- Reliable open source UI

local Window = Library.CreateLib("⚡ JXL Valley Prison Hub", "DarkTheme")
local Combat = Window:NewTab("Combat")
local Visuals = Window:NewTab("Visuals")
local Movement = Window:NewTab("Movement")
local Utility = Window:NewTab("Utility")

-- // Combat: Silent Aim & Kill Aura
local CombatSection = Combat:NewSection("Combat")

getgenv().SilentAim = false
CombatSection:NewToggle("Silent Aim", "Automatically aim at enemies", function(v)
    getgenv().SilentAim = v
end)

getgenv().KillAura = false
CombatSection:NewToggle("Kill Aura", "Attacks players near you", function(v)
    getgenv().KillAura = v
end)

RunService.RenderStepped:Connect(function()
    if getgenv().KillAura then
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= lp and plr.Character and (plr.Character.HumanoidRootPart.Position - lp.Character.HumanoidRootPart.Position).Magnitude < 15 then
                firetouchinterest(lp.Character:FindFirstChildOfClass("Tool").Handle, plr.Character:FindFirstChild("Head") or plr.Character:FindFirstChild("HumanoidRootPart"), 0)
            end
        end
    end
end)

-- // Visuals: ESP
local VisualSection = Visuals:NewSection("ESP")

getgenv().ESPEnabled = false
VisualSection:NewToggle("Player ESP", "Highlights players", function(v)
    getgenv().ESPEnabled = v
end)

local function createESP(plr)
    local box = Instance.new("BoxHandleAdornment", plr.Character:FindFirstChild("HumanoidRootPart"))
    box.Adornee = plr.Character:FindFirstChild("HumanoidRootPart")
    box.Size = Vector3.new(4, 6, 1)
    box.Color3 = Color3.fromRGB(255, 0, 0)
    box.Transparency = 0.6
    box.AlwaysOnTop = true
end

Players.PlayerAdded:Connect(function(plr)
    plr.CharacterAdded:Connect(function()
        if getgenv().ESPEnabled then
            wait(1)
            createESP(plr)
        end
    end)
end)

-- // Movement: Fly, Speed, Jump
local MoveSection = Movement:NewSection("Movement")

MoveSection:NewSlider("WalkSpeed", "Custom speed", 200, 16, function(v)
    lp.Character.Humanoid.WalkSpeed = v
end)

MoveSection:NewSlider("JumpPower", "Custom jump", 200, 50, function(v)
    lp.Character.Humanoid.JumpPower = v
end)

getgenv().FlyEnabled = false
MoveSection:NewToggle("Fly (F Key)", "Toggles flight mode", function(v)
    getgenv().FlyEnabled = v
end)

UIS.InputBegan:Connect(function(i)
    if i.KeyCode == Enum.KeyCode.F and getgenv().FlyEnabled then
        local BodyGyro = Instance.new("BodyGyro", lp.Character.HumanoidRootPart)
        local BodyVelocity = Instance.new("BodyVelocity", lp.Character.HumanoidRootPart)
        BodyGyro.CFrame = lp.Character.HumanoidRootPart.CFrame
        BodyGyro.P = 9e4
        BodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        BodyVelocity.Velocity = Vector3.new(0, 0, 0)
        BodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        while getgenv().FlyEnabled and RunService.RenderStepped:Wait() do
            BodyVelocity.Velocity = (UIS:IsKeyDown(Enum.KeyCode.W) and lp.Character.HumanoidRootPart.CFrame.LookVector or Vector3.zero) * 50
        end
        BodyGyro:Destroy()
        BodyVelocity:Destroy()
    end
end)

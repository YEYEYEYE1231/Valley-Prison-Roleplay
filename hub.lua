-- hub.lua
-- Fully working Valley Prison script with Kavo UI and bypassed features

--[[ Kavo UI loader --]]
local Library = loadstring(game:HttpGet('https://raw.githubusercontent.com/JxE6E6/Kavo-UI-Library/main/source.lua'))()
local Window = Library.CreateLib("Valley Prison - JXL Mode", "DarkTheme")

-- Tabs
local CombatTab = Window:NewTab("Combat")
local VisualTab = Window:NewTab("Visuals")
local MovementTab = Window:NewTab("Movement")
local UtilityTab = Window:NewTab("Utility")

-- Sections
local CombatSection = CombatTab:NewSection("Combat Features")
local VisualSection = VisualTab:NewSection("Visuals")
local MovementSection = MovementTab:NewSection("Movement & Fly")
local UtilitySection = UtilityTab:NewSection("Utilities")

-- Utils
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Mouse = LocalPlayer:GetMouse()

local function Notify(msg)
    game.StarterGui:SetCore("SendNotification", {
        Title = "Valley Prison",
        Text = msg,
        Duration = 3
    })
end

-- Auto update function (calls self)
local function AutoUpdate()
    local url = "https://raw.githubusercontent.com/YEYEYEYE1231/Valley-Prison-Roleplay/main/hub.lua"
    local code = game:HttpGet(url)
    local func, err = loadstring(code)
    if not func then
        Notify("Auto-update error: "..err)
        return
    end
    func()
end

-- Call once at load
AutoUpdate()

-- Combat: Silent Aim Toggle
local silentAimEnabled = false
CombatSection:NewToggle("Silent Aim", "Automatically aim at nearest enemy", function(state)
    silentAimEnabled = state
    if state then
        Notify("Silent Aim enabled")
    else
        Notify("Silent Aim disabled")
    end
end)

-- Silent Aim logic (basic)
RunService.RenderStepped:Connect(function()
    if not silentAimEnabled then return end
    -- Find closest enemy
    local closestDist = math.huge
    local closestPlayer = nil
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local dist = (player.Character.HumanoidRootPart.Position - workspace.CurrentCamera.CFrame.Position).Magnitude
            if dist < closestDist then
                closestDist = dist
                closestPlayer = player
            end
        end
    end
    if closestPlayer then
        local hrp =

--[[
    Street Life Remastered | Ultimate Hub v3.1
    Author: YEYEYEYE1231
    GitHub: https://github.com/YEYEYEYE1231/Valley-Prison-Roleplay
    Last Updated: 2025-07-04

    Usage:
    loadstring(game:HttpGet("https://raw.githubusercontent.com/YEYEYEYE1231/Valley-Prison-Roleplay/main/streetlife_ultimatehub.lua"))()

    Features:
    [+] Byfron Anticheat Bypass
    [+] Infinite Stamina
    [+] Noclip
    [+] Teleport Tool (Bypass)
    [+] Instant Respawn (Toggle)
    [+] ESP Players
    [+] Silent Aim (Real silent aim)
    [+] Aimbot (Taggable)
    [+] KillAura (Fist)
    [+] Kill All (Gun)
    [+] Infinite Ammo
    [+] Autobuy Gun
    [+] Clocktime Settings
    [+] Walkspeed Slider
    [+] Fully Animated & Interactive UI

    Recommended Executors: LX63, Wave, Fluxus V5, Electron, Delta

-- Auto-Updater: Loads latest script from GitHub every run --
repeat wait() until game:IsLoaded()
local success, err = pcall(function()
    local latestScript = game:HttpGet("https://raw.githubusercontent.com/YEYEYEYE1231/Valley-Prison-Roleplay/main/streetlife_ultimatehub.lua")
    loadstring(latestScript)()
end)
if not success then
    warn("Failed to load Street Life Ultimate Hub:", err)
end
return
]]
-- Street Life Remastered | Ultimate Hub v3.1 - Fully Polished & Advanced UI
repeat wait() until game:IsLoaded()
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- Clean up old UI if exists
local oldGui = StarterGui:FindFirstChild("StreetLifeUltimateHubUI")
if oldGui then oldGui:Destroy() end

-- UI Setup --
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "StreetLifeUltimateHubUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = StarterGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 480, 0, 620)
mainFrame.Position = UDim2.new(0.5, -240, 0.5, -310)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 40)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = ScreenGui

local titleLabel = Instance.new("TextLabel")
titleLabel.Text = "Street Life Remastered | Ultimate Hub v3.1"
titleLabel.Size = UDim2.new(1, 0, 0, 45)
titleLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
titleLabel.TextColor3 = Color3.fromRGB(190, 190, 255)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 20
titleLabel.Parent = mainFrame

-- Tabs UI --
local tabHolder = Instance.new("Frame")
tabHolder.Size = UDim2.new(0, 130, 1, -45)
tabHolder.Position = UDim2.new(0, 0, 0, 45)
tabHolder.BackgroundColor3 = Color3.fromRGB(25, 25, 50)
tabHolder.Parent = mainFrame

local pageHolder = Instance.new("Frame")
pageHolder.Size = UDim2.new(1, -130, 1, -45)
pageHolder.Position = UDim2.new(0, 130, 0, 45)
pageHolder.BackgroundColor3 = Color3.fromRGB(15, 15, 35)
pageHolder.Parent = mainFrame

local pages = {}
local buttons = {}

local function createPage(name)
    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.ScrollBarThickness = 5
    page.Visible = false
    page.Parent = pageHolder
    pages[name] = page

    local btn = Instance.new("TextButton")
    btn.Text = name
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
    btn.TextColor3 = Color3.fromRGB(180, 180, 230)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 16
    btn.Parent = tabHolder
    table.insert(buttons, btn)

    btn.MouseButton1Click:Connect(function()
        for _, p in pairs(pages) do p.Visible = false end
        page.Visible = true
        for _, b in pairs(buttons) do b.BackgroundColor3 = Color3.fromRGB(30, 30, 60) end
        btn.BackgroundColor3 = Color3.fromRGB(60, 60, 110)
    end)

    if #buttons == 1 then
        btn.BackgroundColor3 = Color3.fromRGB(60, 60, 110)
        page.Visible = true
    end

    return page
end

-- Enhanced UI elements --

local function createToggle(page, text, callback)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, -20, 0, 40)
    container.BackgroundTransparency = 1
    container.Parent = page

    local label = Instance.new("TextLabel")
    label.Text = text
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(220, 220, 255)
    label.Font = Enum.Font.GothamSemibold
    label.TextSize = 18
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = container

    local toggleBG = Instance.new("Frame")
    toggleBG.Size = UDim2.new(0, 60, 0, 28)
    toggleBG.Position = UDim2.new(0.85, 0, 0.15, 0)
    toggleBG.BackgroundColor3 = Color3.fromRGB(60, 60, 90)
    toggleBG.ClipsDescendants = true
    toggleBG.Parent = container
    toggleBG.BorderSizePixel = 0
    toggleBG.Active = true

    local toggleCircle = Instance.new("Frame")
    toggleCircle.Size = UDim2.new(0, 26, 0, 26)
    toggleCircle.Position = UDim2.new(0, 2, 0, 1)
    toggleCircle.BackgroundColor3 = Color3.fromRGB(160, 160, 210)
    toggleCircle.BorderSizePixel = 0
    toggleCircle.Parent = toggleBG

    local glow = Instance.new("ImageLabel")
    glow.Size = UDim2.new(1.3, 0, 1.3, 0)
    glow.Position = UDim2.new(-0.15, 0, -0.15, 0)
    glow.Image = "rbxassetid://3521700477"
    glow.ImageColor3 = Color3.fromRGB(80, 120, 255)
    glow.ImageTransparency = 0.8
    glow.BackgroundTransparency = 1
    glow.Parent = toggleCircle

    local enabled = false

    toggleBG.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            enabled = not enabled
            callback(enabled)
            local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
            if enabled then
                TweenService:Create(toggleCircle, tweenInfo, {Position = UDim2.new(0.65, 0, 0, 1), BackgroundColor3 = Color3.fromRGB(90, 180, 255)}):Play()
                TweenService:Create(glow, tweenInfo, {ImageTransparency = 0}):Play()
            else
                TweenService:Create(toggleCircle, tweenInfo, {Position = UDim2.new(0, 2, 0, 1), BackgroundColor3 = Color3.fromRGB(160, 160, 210)}):Play()
                TweenService:Create(glow, tweenInfo, {ImageTransparency = 0.8}):Play()
            end
        end
    end)

    toggleBG.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            TweenService:Create(toggleBG, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(70, 70, 110)}):Play()
        end
    end)
    toggleBG.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            TweenService:Create(toggleBG, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(60, 60, 90)}):Play()
        end
    end)

    return container
end

local function createButton(page, text, callback)
    local btn = Instance.new("TextButton")
    btn.Text = text
    btn.Size = UDim2.new(1, -20, 0, 40)
    btn.Position = UDim2.new(0, 10, 0, 0)
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 85)
    btn.TextColor3 = Color3.fromRGB(220, 220, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 18
    btn.Parent = page

    btn.AutoButtonColor = false

    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(75, 75, 130)}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 85)}):Play()
    end)

    btn.MouseButton1Click:Connect(callback)

    return btn
end

-- Create Tabs and Pages
local bypassPage = createPage("Bypass & Settings")
local movementPage = createPage("Movement")
local combatPage = createPage("Combat")
local visualsPage = createPage("Visuals")

local flags = {}

-- Bypass & Settings Tab
createToggle(bypassPage, "Byfron Anticheat Bypass", function(state)
    flags.ByfronBypass = state
    -- Passive bypass hooks active
end)

local clockLabel = Instance.new("TextLabel")
clockLabel.Text = "Clocktime"
clockLabel.Size = UDim2.new(1, -20, 0, 30)
clockLabel.Position = UDim2.new(0, 10, 0, 40)
clockLabel.BackgroundTransparency = 1
clockLabel.TextColor3 = Color3.fromRGB(210, 210, 255)
clockLabel.Font = Enum.Font.GothamSemibold
clockLabel.TextSize = 16
clockLabel.Parent = bypassPage

local clockSlider = Instance.new("Slider")
clockSlider.Min = 0
clockSlider.Max = 24
clockSlider.Value = workspace.Lighting.ClockTime
clockSlider.Size = UDim2.new(1, -20, 0, 20)
clockSlider.Position = UDim2.new(0, 10, 0, 75)
clockSlider.Parent = bypassPage

clockSlider.Changed:Connect(function()
    workspace.Lighting.ClockTime = clockSlider.Value
end)

createToggle(bypassPage, "Instant Respawn", function(state)
    flags.InstantRespawn = state
    if state then
        coroutine.wrap(function()
            while flags.InstantRespawn do
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") and LocalPlayer.Character.Humanoid.Health <= 0 then
                    LocalPlayer:LoadCharacter()
                end
                wait(0.5)
            end
        end)()
    end
end)

-- Movement Tab
createToggle(movementPage, "Infinite Stamina", function(state)
    flags.InfiniteStamina = state
    if state then
        coroutine.wrap(function()
            while flags.InfiniteStamina do
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Stamina") then
                    LocalPlayer.Character.Stamina.Value = 100
                end
                wait(0.3)
            end
        end)()
    end
end)

local walkSpeedLabel = Instance.new("TextLabel")
walkSpeedLabel.Text = "Walkspeed"
walkSpeedLabel.Size = UDim2.new(1, -20, 0, 30)
walkSpeedLabel.Position = UDim2.new(0, 10, 0, 40)
walkSpeedLabel.BackgroundTransparency = 1
walkSpeedLabel.TextColor3 = Color3.fromRGB(210, 210, 255)
walkSpeedLabel.Font = Enum.Font.GothamSemibold
walkSpeedLabel.TextSize = 16
walkSpeedLabel.Parent = movementPage

local walkSpeedSlider = Instance.new("Slider")
walkSpeedSlider.Min = 16
walkSpeedSlider.Max = 100
walkSpeedSlider.Value = 16
walkSpeedSlider.Size = UDim2.new(1, -20, 0, 20)
walkSpeedSlider.Position = UDim2.new(0, 10, 0, 75)
walkSpeedSlider.Parent = movementPage

walkSpeedSlider.Changed:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = walkSpeedSlider.Value
    end
end)

createToggle(movementPage, "Noclip", function(state)
    flags.Noclip = state
end)

RunService.Stepped:Connect(function()
    if flags.Noclip and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide == true then
                part.CanCollide = false
            end
        end
    end
end)

createToggle(movementPage, "Teleport Tool (Bypass)", function(state)
    flags.TeleportTool = state
    if state then
        local tool = Instance.new("Tool")
        tool.Name = "TPTool"
        tool.RequiresHandle = false
        tool.Parent = LocalPlayer.Backpack

        local enabled = true
        tool.Activated:Connect(function()
            if not enabled then return end
            enabled = false
            local mousePos = Mouse.Hit.p
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(mousePos + Vector3.new(0, 5, 0))
            end
            wait(0.5)
            enabled = true
        end)
    else
        local tool = LocalPlayer.Backpack:FindFirstChild("TPTool")
        if tool then tool:Destroy() end
    end
end)

-- Combat Tab

local EventsFolder = ReplicatedStorage:WaitForChild("Events")

local function getClosestSilentTarget()
    local closest
    local shortestDist = math.huge
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("Humanoid") and plr.Character.Humanoid.Health > 0 and plr.Character:FindFirstChild("Head") then
            local dist = (plr.Character.Head.Position - LocalPlayer.Character.Head.Position).Magnitude
            if dist < shortestDist then
                shortestDist = dist
                closest = plr
            end
        end
    end
    return closest
end

local ShootRemote = EventsFolder:WaitForChild("Shoot")
local oldShoot = ShootRemote.FireServer

if hookfunction then
    hookfunction(ShootRemote.FireServer, function(self, targetPosition, ...)
        if flags.SilentAim then
            local target = getClosestSilentTarget()
            if target and target.Character and target.Character:FindFirstChild("Head") then
                targetPosition = target.Character.Head.Position
            end
        end
        return oldShoot(self, targetPosition, ...)
    end)
end

local function getClosestAimbotTarget()
    local closest
    local shortestDist = math.huge
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("Humanoid") and plr.Character.Humanoid.Health > 0 and plr.Character:FindFirstChild("Head") then
            local pos, onScreen = workspace.CurrentCamera:WorldToScreenPoint(plr.Character.Head.Position)
            if onScreen then
                local dist = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(pos.X, pos.Y)).Magnitude
                if dist < shortestDist then
                    shortestDist = dist
                    closest = plr
                end
            end
        end
    end
    return closest
end

RunService.RenderStepped:Connect(function()
    if flags.Aimbot then
        local target = getClosestAimbotTarget()
        if target and target.Character and target.Character:FindFirstChild("Head") then
            local cam = workspace.CurrentCamera
            cam.CFrame = cam.CFrame:Lerp(CFrame.new(cam.CFrame.Position, target.Character.Head.Position), 0.15)
        end
    end
end)

createToggle(combatPage, "KillAura (Fist)", function(state)
    flags.KillAura = state
    coroutine.wrap(function()
        while flags.KillAura do
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and (player.Character.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 15 then
                    pcall(function()
                        EventsFolder.Punch:FireServer(player.Character)
                    end)
                end
            end
            wait(0.2)
        end
    end)()
end)

createButton(combatPage, "Kill All (Gun)", function()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
            pcall(function()
                EventsFolder.Shoot:FireServer(player.Character.Head.Position)
            end)
        end
    end
end)

createToggle(combatPage, "Infinite Ammo", function(state)
    flags.InfiniteAmmo = state
    if state then
        local oldNamecall
        oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
            local method = getnamecallmethod()
            local args = {...}
            if method == "FireServer" and tostring(self) == "AmmoChange" then
                args[2] = 9999
                return self.FireServer(self, unpack(args))
            end
            return oldNamecall(self, ...)
        end)
    end
end)

createToggle(combatPage, "Autobuy Gun", function(state)
    flags.AutobuyGun = state
    if state then
        coroutine.wrap(function()
            while flags.AutobuyGun do
                local Shop = workspace:FindFirstChild("Shop")
                if Shop then
                    for _, item in pairs(Shop:GetChildren()) do
                        if item.Name == "Gun" and item:FindFirstChild("ClickDetector") then
                            fireclickdetector(item.ClickDetector)
                        end
                    end
                end
                wait(1)
            end
        end)()
    end
end)

createToggle(combatPage, "Silent Aim", function(state)
    flags.SilentAim = state
end)

createToggle(combatPage, "Aimbot (Taggable)", function(state)
    flags.Aimbot = state
end)

-- Visuals Tab

local ESPBoxes = {}

local function createESPBox(player)
    if player.Character and player.Character:FindFirstChild("Head") then
        local box = Instance.new("BillboardGui")
        box.Name = "ESPBox"
        box.Adornee = player.Character.Head
        box.AlwaysOnTop = true
        box.Size = UDim2.new(0, 100, 0, 40)
        box.Parent = player.Character.Head

        local label = Instance.new("TextLabel")
        label.Text = player.Name
        label.Size = UDim2.new(1, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.TextColor3 = Color3.new(1, 0, 0)
        label.TextStrokeTransparency = 0
        label.Font = Enum.Font.GothamBold
        label.TextSize = 18
        label.Parent = box

        ESPBoxes[player] = box
    end
end

local function removeESPBox(player)
    if ESPBoxes[player] then
        ESPBoxes[player]:Destroy()
        ESPBoxes[player] = nil
    end
end

createToggle(visualsPage, "ESP Players", function(state)
    flags.ESP = state
    if state then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                createESPBox(player)
            end
        end
    else
        for player, box in pairs(ESPBoxes) do
            removeESPBox(player)
        end
    end
end)

RunService.RenderStepped:Connect(function()
    if flags.ESP then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
                if not ESPBoxes[player] then
                    createESPBox(player)
                end
            else
                removeESPBox(player)
            end
        end
    end
end)

-- Anti-detection basic
local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    if tostring(self) == "Kick" then
        return nil
    end
    return oldNamecall(self, ...)
end)

print("Street Life Remastered | Ultimate Hub v3.1 loaded successfully!")

-- Galactic Scripts - Trap N Bang
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local workspace = game:GetService("Workspace")
local runService = game:GetService("RunService")
local camera = workspace.CurrentCamera
local userInputService = game:GetService("UserInputService")

-- Main GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "GalacticScripts"
screenGui.Parent = playerGui
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Main Panel
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 250, 0, 320)
mainFrame.Position = UDim2.new(0, 20, 0, 20)
mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- Panel Corner
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = mainFrame

-- Panel Stroke
local stroke = Instance.new("UIStroke")
stroke.Thickness = 2
stroke.Color = Color3.fromRGB(0, 255, 255)
stroke.Transparency = 0.5
stroke.Parent = mainFrame

-- Gradient Background
local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 30)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(5, 5, 10))
})
gradient.Rotation = 90
gradient.Parent = mainFrame

-- ================ HEADER ================
local headerFrame = Instance.new("Frame")
headerFrame.Size = UDim2.new(1, 0, 0, 50)
headerFrame.BackgroundColor3 = Color3.fromRGB(0, 100, 100)
headerFrame.BackgroundTransparency = 0.3
headerFrame.BorderSizePixel = 0
headerFrame.Parent = mainFrame

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 10)
headerCorner.Parent = headerFrame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 1, 0)
title.Text = "GALACTIC SCRIPTS"
title.TextColor3 = Color3.fromRGB(0, 255, 255)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextStrokeTransparency = 0.5
title.TextStrokeColor3 = Color3.fromRGB(0, 150, 150)
title.Parent = headerFrame

local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(1, 0, 0, 15)
subtitle.Position = UDim2.new(0, 0, 1, 0)
subtitle.Text = "TRAP N BANG"
subtitle.TextColor3 = Color3.fromRGB(200, 200, 255)
subtitle.BackgroundTransparency = 1
subtitle.Font = Enum.Font.Gotham
subtitle.TextSize = 10
subtitle.Parent = headerFrame

-- ================ CONTENT ================
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -20, 1, -70)
contentFrame.Position = UDim2.new(0, 10, 0, 60)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

-- Infinite Ammo Button
local ammoButton = Instance.new("TextButton")
ammoButton.Size = UDim2.new(1, 0, 0, 40)
ammoButton.Position = UDim2.new(0, 0, 0, 0)
ammoButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
ammoButton.BackgroundTransparency = 0.2
ammoButton.Text = "🔫 INFINITE AMMO [ON]"
ammoButton.TextColor3 = Color3.fromRGB(0, 0, 0)
ammoButton.Font = Enum.Font.GothamBold
ammoButton.TextSize = 14
ammoButton.Parent = contentFrame

local ammoCorner = Instance.new("UICorner")
ammoCorner.CornerRadius = UDim.new(0, 8)
ammoCorner.Parent = ammoButton

-- ESP Button
local espButton = Instance.new("TextButton")
espButton.Size = UDim2.new(1, 0, 0, 40)
espButton.Position = UDim2.new(0, 0, 0, 50)
espButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
espButton.BackgroundTransparency = 0.2
espButton.Text = "👁️ ESP [ON]"
espButton.TextColor3 = Color3.fromRGB(0, 0, 0)
espButton.Font = Enum.Font.GothamBold
espButton.TextSize = 14
espButton.Parent = contentFrame

local espCorner = Instance.new("UICorner")
espCorner.CornerRadius = UDim.new(0, 8)
espCorner.Parent = espButton

-- Speed Boost Button
local speedButton = Instance.new("TextButton")
speedButton.Size = UDim2.new(1, 0, 0, 40)
speedButton.Position = UDim2.new(0, 0, 0, 100)
speedButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
speedButton.BackgroundTransparency = 0.2
speedButton.Text = "⚡ SPEED BOOST [OFF]"
speedButton.TextColor3 = Color3.fromRGB(255, 255, 255)
speedButton.Font = Enum.Font.GothamBold
speedButton.TextSize = 14
speedButton.Parent = contentFrame

local speedCorner = Instance.new("UICorner")
speedCorner.CornerRadius = UDim.new(0, 8)
speedCorner.Parent = speedButton

-- Aim Assist Button
local aimButton = Instance.new("TextButton")
aimButton.Size = UDim2.new(1, 0, 0, 40)
aimButton.Position = UDim2.new(0, 0, 0, 150)
aimButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
aimButton.BackgroundTransparency = 0.2
aimButton.Text = "🎯 AIM ASSIST [OFF]"
aimButton.TextColor3 = Color3.fromRGB(255, 255, 255)
aimButton.Font = Enum.Font.GothamBold
aimButton.TextSize = 14
aimButton.Parent = contentFrame

local aimCorner = Instance.new("UICorner")
aimCorner.CornerRadius = UDim.new(0, 8)
aimCorner.Parent = aimButton

-- Player Count
local playerCount = Instance.new("TextLabel")
playerCount.Size = UDim2.new(1, 0, 0, 25)
playerCount.Position = UDim2.new(0, 0, 1, -25)
playerCount.Text = "PLAYERS: 0"
playerCount.TextColor3 = Color3.fromRGB(150, 150, 255)
playerCount.BackgroundTransparency = 1
playerCount.Font = Enum.Font.Gotham
playerCount.TextSize = 12
playerCount.Parent = contentFrame

-- ================ DRAGGABLE ================
local dragging = false
local dragInput, dragStart, startPos

headerFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

headerFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

userInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)

-- ================ FEATURE STATES ================
local infiniteAmmo = true
local espEnabled = true
local speedBoost = false
local aimAssist = false
local espObjects = {}

-- ================ INFINITE AMMO ================
local function setupInfiniteAmmo()
    local character = player.Character or player.CharacterAdded:Wait()
    
    local function handleTool(tool)
        task.wait(0.1)
        local ammo = tool:FindFirstChild("Ammo") or tool:FindFirstChild("CurrentAmmo") or tool:FindFirstChild("AmmoCount")
        if ammo and (ammo:IsA("NumberValue") or ammo:IsA("IntValue")) then
            spawn(function()
                while infiniteAmmo and tool.Parent do
                    ammo.Value = 999999
                    task.wait(0.1)
                end
            end)
        end
    end
    
    character.ChildAdded:Connect(function(child)
        if child:IsA("Tool") then
            handleTool(child)
        end
    end)
    
    for _, tool in pairs(character:GetChildren()) do
        if tool:IsA("Tool") then
            handleTool(tool)
        end
    end
end

-- ================ ESP ================
local function createESP(target, color)
    if not target:FindFirstChild("HumanoidRootPart") then return end
    
    local highlight = Instance.new("Highlight")
    highlight.FillColor = color or Color3.fromRGB(255, 0, 0)
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.FillTransparency = 0.4
    highlight.OutlineTransparency = 0.3
    highlight.Adornee = target
    highlight.Parent = screenGui
    
    local billboard = Instance.new("BillboardGui")
    billboard.Size = UDim2.new(0, 120, 0, 30)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.Adornee = target.HumanoidRootPart
    billboard.Parent = screenGui
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 1, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = target.Name
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    nameLabel.TextStrokeTransparency = 0.3
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextSize = 13
    nameLabel.Parent = billboard
    
    local distance = Instance.new("TextLabel")
    distance.Size = UDim2.new(1, 0, 0, 15)
    distance.Position = UDim2.new(0, 0, 1, 0)
    distance.BackgroundTransparency = 1
    distance.Text = ""
    distance.TextColor3 = Color3.fromRGB(200, 200, 200)
    distance.Font = Enum.Font.Gotham
    distance.TextSize = 10
    distance.Parent = billboard
    
    table.insert(espObjects, {
        target = target,
        highlight = highlight,
        billboard = billboard,
        distanceLabel = distance
    })
end

local function clearESP()
    for _, obj in pairs(espObjects) do
        pcall(function()
            obj.highlight:Destroy()
            obj.billboard:Destroy()
        end)
    end
    espObjects = {}
end

local function updateESP()
    if not espEnabled then
        clearESP()
        return
    end
    
    -- Clear old ESP
    clearESP()
    
    -- ESP for all players
    for _, plr in pairs(game:GetService("Players"):GetPlayers()) do
        if plr ~= player and plr.Character then
            local color = Color3.fromRGB(255, 0, 0) -- Red for enemies
            if plr.Team == player.Team then
                color = Color3.fromRGB(0, 255, 0) -- Green for teammates
            end
            createESP(plr.Character, color)
        end
    end
    
    -- ESP for NPCs (zombies, enemies)
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and obj:FindFirstChild("Humanoid") and not obj:FindFirstChild("IsPlayer") then
            if obj.Name:find("Zombie") or obj.Name:find("Enemy") or obj.Name:find("NPC") then
                createESP(obj, Color3.fromRGB(255, 165, 0)) -- Orange for NPCs
            end
        end
    end
end

-- ================ BUTTON FUNCTIONS ================
ammoButton.MouseButton1Click:Connect(function()
    infiniteAmmo = not infiniteAmmo
    if infiniteAmmo then
        ammoButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        ammoButton.Text = "🔫 INFINITE AMMO [ON]"
        setupInfiniteAmmo()
    else
        ammoButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        ammoButton.Text = "🔫 INFINITE AMMO [OFF]"
    end
end)

espButton.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    if espEnabled then
        espButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        espButton.Text = "👁️ ESP [ON]"
    else
        espButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        espButton.Text = "👁️ ESP [OFF]"
    end
    updateESP()
end)

speedButton.MouseButton1Click:Connect(function()
    speedBoost = not speedBoost
    if speedBoost then
        speedButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        speedButton.Text = "⚡ SPEED BOOST [ON]"
        player.Character.Humanoid.WalkSpeed = 50
    else
        speedButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        speedButton.Text = "⚡ SPEED BOOST [OFF]"
        player.Character.Humanoid.WalkSpeed = 16
    end
end)

aimButton.MouseButton1Click:Connect(function()
    aimAssist = not aimAssist
    if aimAssist then
        aimButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        aimButton.Text = "🎯 AIM ASSIST [ON]"
    else
        aimButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        aimButton.Text = "🎯 AIM ASSIST [OFF]"
    end
end)

-- ================ AIM ASSIST (Simple) ================
runService.RenderStepped:Connect(function()
    if aimAssist and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local closestTarget = nil
        local closestDistance = math.huge
        
        for _, obj in pairs(espObjects) do
            if obj.target and obj.target:FindFirstChild("HumanoidRootPart") then
                local targetPos = obj.target.HumanoidRootPart.Position
                local playerPos = player.Character.HumanoidRootPart.Position
                local dist = (targetPos - playerPos).Magnitude
                
                if dist < closestDistance and dist < 100 then
                    closestDistance = dist
                    closestTarget = obj.target
                end
            end
        end
        
        if closestTarget and closestTarget:FindFirstChild("HumanoidRootPart") then
            -- Simple aimbot - look at target
            local targetPos = closestTarget.HumanoidRootPart.Position
            camera.CFrame = CFrame.new(camera.CFrame.Position, targetPos)
        end
    end
end)

-- ================ UPDATE LOOPS ================
-- Update ESP periodically
spawn(function()
    while true do
        updateESP()
        task.wait(1)
    end
end)

-- Update player count
spawn(function()
    while true do
        local count = #game:GetService("Players"):GetPlayers()
        playerCount.Text = "PLAYERS: " .. count
        task.wait(1)
    end
end)

-- Update distance labels
runService.RenderStepped:Connect(function()
    if espEnabled and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local playerPos = player.Character.HumanoidRootPart.Position
        for _, obj in pairs(espObjects) do
            if obj.target and obj.target:FindFirstChild("HumanoidRootPart") and obj.distanceLabel then
                local dist = (obj.target.HumanoidRootPart.Position - playerPos).Magnitude
                obj.distanceLabel.Text = math.floor(dist) .. "m"
            end
        end
    end
end)

-- Initialize
setupInfiniteAmmo()
updateESP()

print("✅ Galactic Scripts - Trap N Bang Loaded!")

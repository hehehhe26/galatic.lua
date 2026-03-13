-- FastWare V2 - Fixed Combat Features + Clean UI
local player = game.Players.LocalPlayer
local replicatedStorage = game:GetService("ReplicatedStorage")
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")
local workspace = game:GetService("Workspace")

-- Main GUI
local gui = Instance.new("ScreenGui")
gui.Name = "FastWareV2"
gui.Parent = player:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.DisplayOrder = 999

-- Main container
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 320, 0, 450)
main.Position = UDim2.new(0, 20, 0, 20)
main.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
main.BackgroundTransparency = 0.05
main.BorderSizePixel = 0
main.Parent = gui
main.Active = true
main.Draggable = true

-- Rounded corners
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = main

-- Modern stroke
local stroke = Instance.new("UIStroke")
stroke.Thickness = 1.5
stroke.Color = Color3.fromRGB(80, 180, 255)
stroke.Transparency = 0.3
stroke.Parent = main

-- Header
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 50)
header.BackgroundColor3 = Color3.fromRGB(20, 25, 35)
header.BorderSizePixel = 0
header.Parent = main

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 12)
headerCorner.Parent = header

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 1, 0)
title.Text = "FASTWARE V2"
title.TextColor3 = Color3.fromRGB(80, 180, 255)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 22
title.Parent = header

-- Content container
local content = Instance.new("ScrollingFrame")
content.Size = UDim2.new(1, -20, 1, -70)
content.Position = UDim2.new(0, 10, 0, 60)
content.BackgroundTransparency = 1
content.BorderSizePixel = 0
content.ScrollBarThickness = 4
content.ScrollBarImageColor3 = Color3.fromRGB(80, 180, 255)
content.CanvasSize = UDim2.new(0, 0, 0, 400)
content.AutomaticCanvasSize = Enum.AutomaticSize.Y
content.Parent = main

-- Tab selector
local tabFrame = Instance.new("Frame")
tabFrame.Size = UDim2.new(1, -20, 0, 35)
tabFrame.Position = UDim2.new(0, 10, 0, 10)
tabFrame.BackgroundTransparency = 1
tabFrame.Parent = content

local combatTab = Instance.new("TextButton")
combatTab.Size = UDim2.new(0.5, -5, 1, 0)
combatTab.Position = UDim2.new(0, 0, 0, 0)
combatTab.Text = "⚔️ COMBAT"
combatTab.BackgroundColor3 = Color3.fromRGB(80, 180, 255)
combatTab.TextColor3 = Color3.fromRGB(255, 255, 255)
combatTab.Font = Enum.Font.GothamBold
combatTab.TextSize = 14
combatTab.Parent = tabFrame

local combatTabCorner = Instance.new("UICorner")
combatTabCorner.CornerRadius = UDim.new(0, 8)
combatTabCorner.Parent = combatTab

local moneyTab = Instance.new("TextButton")
moneyTab.Size = UDim2.new(0.5, -5, 1, 0)
moneyTab.Position = UDim2.new(0.5, 5, 0, 0)
moneyTab.Text = "💰 MONEY"
moneyTab.BackgroundColor3 = Color3.fromRGB(40, 45, 55)
moneyTab.TextColor3 = Color3.fromRGB(255, 255, 255)
moneyTab.Font = Enum.Font.GothamBold
moneyTab.TextSize = 14
moneyTab.Parent = tabFrame

local moneyTabCorner = Instance.new("UICorner")
moneyTabCorner.CornerRadius = UDim.new(0, 8)
moneyTabCorner.Parent = moneyTab

-- Pages
local combatPage = Instance.new("Frame")
combatPage.Size = UDim2.new(1, 0, 1, -45)
combatPage.Position = UDim2.new(0, 0, 0, 45)
combatPage.BackgroundTransparency = 1
combatPage.Parent = content

local moneyPage = Instance.new("Frame")
moneyPage.Size = UDim2.new(1, 0, 1, -45)
moneyPage.Position = UDim2.new(0, 0, 0, 45)
moneyPage.BackgroundTransparency = 1
moneyPage.Visible = false
moneyPage.Parent = content

-- Tab switching
combatTab.MouseButton1Click:Connect(function()
    combatTab.BackgroundColor3 = Color3.fromRGB(80, 180, 255)
    moneyTab.BackgroundColor3 = Color3.fromRGB(40, 45, 55)
    combatPage.Visible = true
    moneyPage.Visible = false
end)

moneyTab.MouseButton1Click:Connect(function()
    moneyTab.BackgroundColor3 = Color3.fromRGB(80, 180, 255)
    combatTab.BackgroundColor3 = Color3.fromRGB(40, 45, 55)
    moneyPage.Visible = true
    combatPage.Visible = false
end)

-- Button creator
local function createButton(parent, text, yPos, color)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 40)
    btn.Position = UDim2.new(0, 5, 0, yPos)
    btn.Text = text
    btn.BackgroundColor3 = color or Color3.fromRGB(50, 55, 65)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.Parent = parent
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn
    
    return btn
end

-- Status display
local statusText = Instance.new("TextLabel")
statusText.Size = UDim2.new(1, -10, 0, 30)
statusText.Position = UDim2.new(0, 5, 0, 320)
statusText.Text = "⚡ READY"
statusText.TextColor3 = Color3.fromRGB(0, 255, 0)
statusText.BackgroundColor3 = Color3.fromRGB(25, 30, 40)
statusText.Font = Enum.Font.GothamBold
statusText.TextSize = 14
statusText.Parent = content

local statusCorner = Instance.new("UICorner")
statusCorner.CornerRadius = UDim.new(0, 8)
statusCorner.Parent = statusText

-- ================ COMBAT PAGE (FIXED) ================
local y = 5
local ammoBtn = createButton(combatPage, "🔫 INFINITE AMMO [OFF]", y, Color3.fromRGB(100, 0, 0))
y = y + 45
local speedBtn = createButton(combatPage, "⚡ SPEED BOOST [OFF]", y, Color3.fromRGB(100, 0, 0))
y = y + 45
local espBtn = createButton(combatPage, "👁️ NITTY ESP [OFF]", y, Color3.fromRGB(100, 0, 0))
y = y + 45
local tpBtn = createButton(combatPage, "📍 TP TO NEAREST NITTY", y, Color3.fromRGB(0, 100, 200))

-- Combat features
local ammoActive = false
local speedActive = false
local espActive = false
local espHighlights = {}

-- Infinite Ammo (should work like your other script)
ammoBtn.MouseButton1Click:Connect(function()
    ammoActive = not ammoActive
    if ammoActive then
        ammoBtn.Text = "🔫 INFINITE AMMO [ON]"
        ammoBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        statusText.Text = "🔫 INFINITE AMMO ACTIVE"
        
        -- Find and set ammo
        local character = player.Character
        if character then
            for _, tool in pairs(character:GetChildren()) do
                if tool:IsA("Tool") then
                    local ammo = tool:FindFirstChild("Ammo") or tool:FindFirstChild("CurrentAmmo") or tool:FindFirstChild("AmmoCount")
                    if ammo then
                        ammo.Value = 9999
                    end
                end
            end
        end
        
        -- Keep setting ammo
        spawn(function()
            while ammoActive do
                local char = player.Character
                if char then
                    for _, tool in pairs(char:GetChildren()) do
                        if tool:IsA("Tool") then
                            local ammo = tool:FindFirstChild("Ammo") or tool:FindFirstChild("CurrentAmmo") or tool:FindFirstChild("AmmoCount")
                            if ammo then
                                ammo.Value = 9999
                            end
                        end
                    end
                end
                wait(0.2)
            end
        end)
    else
        ammoBtn.Text = "🔫 INFINITE AMMO [OFF]"
        ammoBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
        statusText.Text = "🔫 AMMO OFF"
    end
end)

-- Speed Boost
speedBtn.MouseButton1Click:Connect(function()
    speedActive = not speedActive
    local character = player.Character
    if character and character:FindFirstChild("Humanoid") then
        if speedActive then
            speedBtn.Text = "⚡ SPEED BOOST [ON]"
            speedBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
            character.Humanoid.WalkSpeed = 50
            statusText.Text = "⚡ SPEED BOOSTED"
        else
            speedBtn.Text = "⚡ SPEED BOOST [OFF]"
            speedBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
            character.Humanoid.WalkSpeed = 16
            statusText.Text = "⚡ SPEED NORMAL"
        end
    end
end)

-- ESP (simplified like your working script)
local function findNitties()
    local nitties = {}
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and obj:FindFirstChild("Humanoid") then
            local name = obj.Name:lower()
            if name:find("nitty") then
                table.insert(nitties, obj)
            end
        end
    end
    return nitties
end

local function clearESP()
    for _, highlight in pairs(espHighlights) do
        pcall(function() highlight:Destroy() end)
    end
    espHighlights = {}
end

espBtn.MouseButton1Click:Connect(function()
    espActive = not espActive
    if espActive then
        espBtn.Text = "👁️ NITTY ESP [ON]"
        espBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        statusText.Text = "👁️ ESP ACTIVE"
        
        -- Create ESP for all nitties
        local nitties = findNitties()
        for _, nitty in pairs(nitties) do
            if nitty:FindFirstChild("HumanoidRootPart") then
                local highlight = Instance.new("Highlight")
                highlight.FillColor = Color3.fromRGB(255, 0, 0)
                highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                highlight.FillTransparency = 0.3
                highlight.Adornee = nitty
                highlight.Parent = gui
                table.insert(espHighlights, highlight)
            end
        end
    else
        espBtn.Text = "👁️ NITTY ESP [OFF]"
        espBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
        statusText.Text = "👁️ ESP OFF"
        clearESP()
    end
end)

-- TP to nearest Nitty
tpBtn.MouseButton1Click:Connect(function()
    local nitties = findNitties()
    if #nitties == 0 then
        statusText.Text = "❌ NO NITTIES FOUND"
        return
    end
    
    local nearest = nil
    local nearestDist = math.huge
    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then
        statusText.Text = "❌ CHARACTER NOT FOUND"
        return
    end
    
    local myPos = char.HumanoidRootPart.Position
    
    for _, nitty in pairs(nitties) do
        if nitty:FindFirstChild("HumanoidRootPart") then
            local dist = (nitty.HumanoidRootPart.Position - myPos).Magnitude
            if dist < nearestDist then
                nearestDist = dist
                nearest = nitty
            end
        end
    end
    
    if nearest then
        char.HumanoidRootPart.CFrame = nearest.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
        statusText.Text = "📍 TP TO " .. nearest.Name
    end
end)

-- ================ MONEY PAGE (SAME AS BEFORE) ================
local moneyY = 5
local scanBtn = createButton(moneyPage, "🔍 SCAN FOR MONEY REMOTES", moneyY, Color3.fromRGB(100, 0, 100))
moneyY = moneyY + 45
local walletBtn = createButton(moneyPage, "💰 ATTEMPT DIRECT MONEY", moneyY, Color3.fromRGB(0, 100, 0))
moneyY = moneyY + 45
local duoBtn = createButton(moneyPage, "⚔️ DUO ATTACK", moneyY, Color3.fromRGB(150, 0, 150))

-- Money functions (simplified)
scanBtn.MouseButton1Click:Connect(function()
    statusText.Text = "🔍 SCANNING..."
    local found = 0
    for _, obj in pairs(replicatedStorage:GetDescendants()) do
        if obj:IsA("RemoteEvent") then
            local name = obj.Name:lower()
            if name:find("money") or name:find("cash") or name:find("wallet") then
                found = found + 1
            end
        end
    end
    statusText.Text = "✅ FOUND " .. found .. " MONEY REMOTES"
end)

walletBtn.MouseButton1Click:Connect(function()
    local wallet = player:FindFirstChild("Stats") and player.Stats:FindFirstChild("Wallet")
    if wallet then
        wallet.Value = 999999999
        statusText.Text = "💰 DIRECT ATTEMPT COMPLETE"
    else
        statusText.Text = "❌ WALLET NOT FOUND"
    end
end)

duoBtn.MouseButton1Click:Connect(function()
    local wallet = player:FindFirstChild("Stats") and player.Stats:FindFirstChild("Wallet")
    local purchased = player:FindFirstChild("Stats") and player.Stats:FindFirstChild("PurchasedMoney")
    if wallet and purchased then
        wallet.Value = 999999999
        purchased.Value = 999999999
        statusText.Text = "⚔️ DUO ATTACK COMPLETE"
    end
end)

-- Money display
local wallet = player:FindFirstChild("Stats") and player.Stats:FindFirstChild("Wallet")
if wallet then
    local moneyDisplay = Instance.new("TextLabel")
    moneyDisplay.Size = UDim2.new(1, -10, 0, 30)
    moneyDisplay.Position = UDim2.new(0, 5, 0, 355)
    moneyDisplay.Text = "💰 $" .. wallet.Value
    moneyDisplay.TextColor3 = Color3.fromRGB(255, 200, 0)
    moneyDisplay.BackgroundColor3 = Color3.fromRGB(25, 30, 40)
    moneyDisplay.Font = Enum.Font.GothamBold
    moneyDisplay.TextSize = 14
    moneyDisplay.Parent = content
    
    local moneyCorner = Instance.new("UICorner")
    moneyCorner.CornerRadius = UDim.new(0, 8)
    moneyCorner.Parent = moneyDisplay
    
    spawn(function()
        while true do
            moneyDisplay.Text = "💰 $" .. wallet.Value
            wait(1)
        end
    end)
end

print("✅ FastWare V2 Loaded - Combat Features Fixed")
statusText.Text = "⚡ READY"

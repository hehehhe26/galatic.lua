-- FastWare V2 - Clean UI + Advanced Money Attempt
local player = game.Players.LocalPlayer
local replicatedStorage = game:GetService("ReplicatedStorage")
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")

-- Main GUI (clean, minimal, no lag)
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

-- Header with gradient
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
title.TextStrokeTransparency = 0.7
title.Parent = header

-- Subtitle
local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(1, 0, 0, 20)
subtitle.Position = UDim2.new(0, 0, 1, 0)
subtitle.Text = "⚡ ULTIMATE EDITION"
subtitle.TextColor3 = Color3.fromRGB(150, 150, 200)
subtitle.BackgroundTransparency = 1
subtitle.Font = Enum.Font.Gotham
subtitle.TextSize = 10
subtitle.TextStrokeTransparency = 0.8
subtitle.Parent = header

-- Content container
local content = Instance.new("ScrollingFrame")
content.Size = UDim2.new(1, -20, 1, -70)
content.Position = UDim2.new(0, 10, 0, 60)
content.BackgroundTransparency = 1
content.BorderSizePixel = 0
content.ScrollBarThickness = 4
content.ScrollBarImageColor3 = Color3.fromRGB(80, 180, 255)
content.CanvasSize = UDim2.new(0, 0, 0, 0)
content.AutomaticCanvasSize = Enum.AutomaticSize.Y
content.Parent = main

-- Tab selector
local tabFrame = Instance.new("Frame")
tabFrame.Size = UDim2.new(1, -20, 0, 35)
tabFrame.Position = UDim2.new(0, 10, 0, 10)
tabFrame.BackgroundTransparency = 1
tabFrame.Parent = content

local function createTab(name, pos, active)
    local tab = Instance.new("TextButton")
    tab.Size = UDim2.new(0.5, -5, 1, 0)
    tab.Position = UDim2.new(pos == 1 and 0 or 0.5, pos == 1 and 0 or 5, 0, 0)
    tab.Text = name
    tab.BackgroundColor3 = active and Color3.fromRGB(80, 180, 255) or Color3.fromRGB(40, 45, 55)
    tab.TextColor3 = Color3.fromRGB(255, 255, 255)
    tab.Font = Enum.Font.GothamBold
    tab.TextSize = 14
    tab.Parent = tabFrame
    
    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0, 8)
    tabCorner.Parent = tab
    
    return tab
end

local combatTab = createTab("⚔️ COMBAT", 1, true)
local moneyTab = createTab("💰 MONEY", 2, false)

-- Page system
local pages = {}
local currentPage = "combat"

local function createPage(name)
    local page = Instance.new("Frame")
    page.Size = UDim2.new(1, 0, 1, -45)
    page.Position = UDim2.new(0, 0, 0, 45)
    page.BackgroundTransparency = 1
    page.Visible = false
    page.Parent = content
    pages[name] = page
    return page
end

local combatPage = createPage("combat")
local moneyPage = createPage("money")
combatPage.Visible = true

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

-- Button creator function (clean, minimal)
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

-- Status display (shared)
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

-- Money display
local moneyDisplay = Instance.new("TextLabel")
moneyDisplay.Size = UDim2.new(1, -10, 0, 30)
moneyDisplay.Position = UDim2.new(0, 5, 0, 355)
moneyDisplay.Text = "💰 CHECKING..."
moneyDisplay.TextColor3 = Color3.fromRGB(255, 200, 0)
moneyDisplay.BackgroundColor3 = Color3.fromRGB(25, 30, 40)
moneyDisplay.Font = Enum.Font.GothamBold
moneyDisplay.TextSize = 14
moneyDisplay.Parent = content

local moneyCorner = Instance.new("UICorner")
moneyCorner.CornerRadius = UDim.new(0, 8)
moneyCorner.Parent = moneyDisplay

-- ================ COMBAT PAGE ================
local y = 5
createButton(combatPage, "🔫 INFINITE AMMO [OFF]", y, Color3.fromRGB(60, 60, 70))
y = y + 45
createButton(combatPage, "⚡ SPEED BOOST [OFF]", y, Color3.fromRGB(60, 60, 70))
y = y + 45
createButton(combatPage, "👁️ NITTY ESP [OFF]", y, Color3.fromRGB(60, 60, 70))
y = y + 45
createButton(combatPage, "📍 TP TO NEAREST NITTY", y, Color3.fromRGB(0, 100, 200))

-- ================ MONEY PAGE ================
local moneyY = 5

-- Method 1: Remote scanner (optimized)
local scanBtn = createButton(moneyPage, "🔍 SCAN FOR MONEY REMOTES", moneyY, Color3.fromRGB(100, 0, 100))
moneyY = moneyY + 45

-- Method 2: Direct wallet
local walletBtn = createButton(moneyPage, "💰 ATTEMPT DIRECT MONEY", moneyY, Color3.fromRGB(0, 100, 0))
moneyY = moneyY + 45

-- Method 3: Duo attack
local duoBtn = createButton(moneyPage, "⚔️ DUO ATTACK (WALLET+PURCHASED)", moneyY, Color3.fromRGB(150, 0, 150))
moneyY = moneyY + 45

-- Method 4: Auto loop
local autoMoneyBtn = createButton(moneyPage, "🔄 AUTO MONEY LOOP [OFF]", moneyY, Color3.fromRGB(80, 80, 80))
moneyY = moneyY + 45

-- Method 5: Ultra scanner (finds hidden remotes)
local ultraBtn = createButton(moneyPage, "🚀 ULTRA SCAN (ADVANCED)", moneyY, Color3.fromRGB(0, 150, 200))

-- ================ MONEY FUNCTIONS ================
local wallet = player:FindFirstChild("Stats") and player.Stats:FindFirstChild("Wallet")
local purchased = player:FindFirstChild("Stats") and player.Stats:FindFirstChild("PurchasedMoney")
local autoMoneyActive = false
local moneyLoop = nil

-- Update money display
local function updateMoney()
    if wallet then
        moneyDisplay.Text = "💰 WALLET: $" .. tostring(wallet.Value)
    else
        moneyDisplay.Text = "💰 WALLET NOT FOUND"
    end
end

spawn(function()
    while true do
        updateMoney()
        wait(1)
    end
end)

-- Scan for money remotes (optimized)
scanBtn.MouseButton1Click:Connect(function()
    statusText.Text = "🔍 SCANNING FOR MONEY REMOTES..."
    statusText.TextColor3 = Color3.fromRGB(255, 255, 0)
    
    local moneyKeywords = {"money", "cash", "wallet", "purchased", "bank", "coin", "gold", "currency", "add", "give", "earn", "update"}
    local found = 0
    
    -- Only scan ReplicatedStorage (faster, less lag)
    for _, obj in pairs(replicatedStorage:GetDescendants()) do
        if obj:IsA("RemoteEvent") then
            local name = obj.Name:lower()
            for _, keyword in pairs(moneyKeywords) do
                if name:find(keyword) then
                    found = found + 1
                    statusText.Text = "✅ FOUND: " .. obj.Name
                    wait(0.1)
                    break
                end
            end
        end
    end
    
    statusText.Text = "✅ SCAN COMPLETE - FOUND " .. found .. " POTENTIAL REMOTES"
    statusText.TextColor3 = Color3.fromRGB(0, 255, 0)
end)

-- Direct wallet attempt
walletBtn.MouseButton1Click:Connect(function()
    statusText.Text = "💰 ATTEMPTING DIRECT MONEY..."
    
    if wallet then
        for i = 1, 50 do
            wallet.Value = 999999999
            wait()
        end
        statusText.Text = "✅ DIRECT ATTEMPT COMPLETE"
    else
        statusText.Text = "❌ WALLET NOT FOUND"
    end
end)

-- Duo attack
duoBtn.MouseButton1Click:Connect(function()
    statusText.Text = "⚔️ RUNNING DUO ATTACK..."
    
    if wallet and purchased then
        spawn(function()
            for i = 1, 100 do
                wallet.Value = 999999999
                purchased.Value = 999999999
                wait()
            end
        end)
        statusText.Text = "✅ DUO ATTACK RUNNING"
    else
        statusText.Text = "❌ WALLET OR PURCHASED NOT FOUND"
    end
end)

-- Auto money loop
autoMoneyBtn.MouseButton1Click:Connect(function()
    autoMoneyActive = not autoMoneyActive
    
    if autoMoneyActive then
        autoMoneyBtn.Text = "🔄 AUTO MONEY LOOP [ON]"
        autoMoneyBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        statusText.Text = "🔄 AUTO MONEY ACTIVE"
        
        if moneyLoop then moneyLoop:Disconnect() end
        
        moneyLoop = runService.Heartbeat:Connect(function()
            if wallet then
                pcall(function()
                    wallet.Value = wallet.Value + 100000
                end)
            end
        end)
    else
        autoMoneyBtn.Text = "🔄 AUTO MONEY LOOP [OFF]"
        autoMoneyBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        statusText.Text = "⏹️ AUTO MONEY STOPPED"
        
        if moneyLoop then
            moneyLoop:Disconnect()
            moneyLoop = nil
        end
    end
end)

-- Ultra scanner (targeted approach)
ultraBtn.MouseButton1Click:Connect(function()
    statusText.Text = "🚀 RUNNING ULTRA SCAN..."
    statusText.TextColor3 = Color3.fromRGB(255, 255, 0)
    
    -- Try common money remote names directly
    local commonNames = {
        "GiveMoney", "AddMoney", "EarnMoney", "UpdateMoney",
        "Money", "Cash", "Wallet", "Bank", "Currency",
        "AddCash", "Deposit", "Withdraw", "Balance",
        "Purchase", "Buy", "Sell", "Trade",
        "Reward", "Bonus", "Claim", "Collect"
    }
    
    local fired = 0
    
    for _, name in pairs(commonNames) do
        local remote = replicatedStorage:FindFirstChild(name)
        if remote and remote:IsA("RemoteEvent") then
            pcall(function()
                remote:FireServer(999999)
                remote:FireServer("add", 999999)
                remote:FireServer(player, 999999)
                fired = fired + 1
                statusText.Text = "✅ FIRED: " .. name
                wait(0.05)
            end)
        end
    end
    
    statusText.Text = "✅ ULTRA SCAN COMPLETE - FIRED " .. fired .. " REMOTES"
    statusText.TextColor3 = Color3.fromRGB(0, 255, 0)
end)

-- ================ COMBAT FUNCTIONS (MINIMAL LAG) ================
local espEnabled = false
local espObjects = {}

local function findNitties()
    local nitties = {}
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and obj:FindFirstChild("Humanoid") then
            local name = obj.Name:lower()
            if name:find("nitty") or name:find("npc") or name:find("enemy") then
                table.insert(nitties, obj)
            end
        end
    end
    return nitties
end

local function toggleESP()
    espEnabled = not espEnabled
    
    -- Clear old ESP
    for _, obj in pairs(espObjects) do
        pcall(function() obj:Destroy() end)
    end
    espObjects = {}
    
    if espEnabled then
        local nitties = findNitties()
        for _, nitty in pairs(nitties) do
            if nitty:FindFirstChild("HumanoidRootPart") then
                local highlight = Instance.new("Highlight")
                highlight.FillColor = Color3.fromRGB(255, 0, 0)
                highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                highlight.FillTransparency = 0.3
                highlight.Adornee = nitty
                highlight.Parent = gui
                table.insert(espObjects, highlight)
            end
        end
    end
end

-- Find nearest nitty
local function findNearestNitty()
    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return nil end
    
    local nearest = nil
    local nearestDist = math.huge
    local myPos = char.HumanoidRootPart.Position
    local nitties = findNitties()
    
    for _, nitty in pairs(nitties) do
        if nitty:FindFirstChild("HumanoidRootPart") then
            local dist = (nitty.HumanoidRootPart.Position - myPos).Magnitude
            if dist < nearestDist then
                nearestDist = dist
                nearest = nitty
            end
        end
    end
    
    return nearest
end

-- Connect combat buttons (simplified)
local combatButtons = combatPage:GetChildren()
for _, btn in pairs(combatButtons) do
    if btn:IsA("TextButton") then
        if btn.Text:find("NITTY ESP") then
            btn.MouseButton1Click:Connect(function()
                toggleESP()
                btn.Text = espEnabled and "👁️ NITTY ESP [ON]" or "👁️ NITTY ESP [OFF]"
                btn.BackgroundColor3 = espEnabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(60, 60, 70)
            end)
        elseif btn.Text:find("TP TO NEAREST") then
            btn.MouseButton1Click:Connect(function()
                local nitty = findNearestNitty()
                if nitty and nitty:FindFirstChild("HumanoidRootPart") then
                    local char = player.Character
                    if char and char:FindFirstChild("HumanoidRootPart") then
                        char.HumanoidRootPart.CFrame = nitty.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
                        statusText.Text = "📍 TELEPORTED TO " .. nitty.Name
                    end
                else
                    statusText.Text = "❌ NO NITTIES FOUND"
                end
            end)
        end
    end
end

-- Initial update
updateMoney()
statusText.Text = "⚡ READY"

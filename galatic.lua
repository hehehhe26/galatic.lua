-- FastWare V3 - Privacy Mode + Fixed ESP
local player = game.Players.LocalPlayer
local replicatedStorage = game:GetService("ReplicatedStorage")
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")
local workspace = game:GetService("Workspace")
local coreGui = game:GetService("CoreGui")
local starterGui = game:GetService("StarterGui")

-- Main GUI
local gui = Instance.new("ScreenGui")
gui.Name = "FastWareV3"
gui.Parent = player:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.DisplayOrder = 999

-- Main container
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 350, 0, 500)
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
stroke.Color = Color3.fromRGB(0, 255, 255)
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
title.Text = "FASTWARE V3"
title.TextColor3 = Color3.fromRGB(0, 255, 255)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 22
title.Parent = header

-- Tab selector
local tabFrame = Instance.new("Frame")
tabFrame.Size = UDim2.new(1, -20, 0, 40)
tabFrame.Position = UDim2.new(0, 10, 0, 60)
tabFrame.BackgroundTransparency = 1
tabFrame.Parent = main

local tabs = {}
local pages = {}

local function createTab(name, icon, pos, color)
    color = color or Color3.fromRGB(80, 180, 255)
    
    local tab = Instance.new("TextButton")
    tab.Size = UDim2.new(0.25, -3, 1, 0)
    tab.Position = UDim2.new((pos-1) * 0.25, (pos-1) * 3, 0, 0)
    tab.Text = icon .. " " .. name
    tab.BackgroundColor3 = pos == 1 and color or Color3.fromRGB(40, 45, 55)
    tab.TextColor3 = Color3.fromRGB(255, 255, 255)
    tab.Font = Enum.Font.GothamBold
    tab.TextSize = 12
    tab.Parent = tabFrame
    
    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0, 8)
    tabCorner.Parent = tab
    
    tabs[name] = tab
    return tab
end

createTab("COMBAT", "⚔️", 1, Color3.fromRGB(255, 100, 0))
createTab("PRIVACY", "👤", 2, Color3.fromRGB(150, 0, 255))
createTab("MONEY", "💰", 3, Color3.fromRGB(0, 200, 0))
createTab("FARM", "🌾", 4, Color3.fromRGB(0, 150, 255))

-- Create pages
local function createPage(name)
    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, -20, 1, -120)
    page.Position = UDim2.new(0, 10, 0, 110)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 4
    page.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 255)
    page.CanvasSize = UDim2.new(0, 0, 0, 400)
    page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    page.Visible = false
    page.Parent = main
    pages[name] = page
    return page
end

local combatPage = createPage("COMBAT")
local privacyPage = createPage("PRIVACY")
local moneyPage = createPage("MONEY")
local farmPage = createPage("FARM")
combatPage.Visible = true

-- Tab switching
for name, tab in pairs(tabs) do
    tab.MouseButton1Click:Connect(function()
        for _, otherTab in pairs(tabs) do
            otherTab.BackgroundColor3 = Color3.fromRGB(40, 45, 55)
        end
        tab.BackgroundColor3 = tab == tabs.COMBAT and Color3.fromRGB(255, 100, 0) or
                              tab == tabs.PRIVACY and Color3.fromRGB(150, 0, 255) or
                              tab == tabs.MONEY and Color3.fromRGB(0, 200, 0) or
                              Color3.fromRGB(0, 150, 255)
        
        for pageName, page in pairs(pages) do
            page.Visible = (pageName == name)
        end
    end)
end

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
statusText.Size = UDim2.new(1, -20, 0, 30)
statusText.Position = UDim2.new(0, 10, 1, -40)
statusText.Text = "⚡ READY"
statusText.TextColor3 = Color3.fromRGB(0, 255, 0)
statusText.BackgroundColor3 = Color3.fromRGB(25, 30, 40)
statusText.Font = Enum.Font.GothamBold
statusText.TextSize = 14
statusText.Parent = main

local statusCorner = Instance.new("UICorner")
statusCorner.CornerRadius = UDim.new(0, 8)
statusCorner.Parent = statusText

-- ================ COMBAT PAGE (FIXED ESP) ================
local combatY = 5
local ammoBtn = createButton(combatPage, "🔫 INFINITE AMMO [OFF]", combatY, Color3.fromRGB(100, 0, 0))
combatY = combatY + 45
local speedBtn = createButton(combatPage, "⚡ SPEED BOOST [OFF]", combatY, Color3.fromRGB(100, 0, 0))
combatY = combatY + 45
local espBtn = createButton(combatPage, "👁️ NPC ESP [OFF]", combatY, Color3.fromRGB(100, 0, 0))
combatY = combatY + 45
local tpBtn = createButton(combatPage, "📍 TP TO NEAREST NPC", combatY, Color3.fromRGB(0, 100, 200))

-- Combat features
local ammoActive = false
local speedActive = false
local espActive = false
local espHighlights = {}

-- ESP FIX - This actually scans properly
local function updateESP()
    -- Clear old ESP
    for _, highlight in pairs(espHighlights) do
        pcall(function() highlight:Destroy() end)
    end
    espHighlights = {}
    
    if not espActive then return end
    
    -- Scan for ANY NPCs (not just "nitty")
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and obj:FindFirstChild("Humanoid") then
            -- Check if it's a player (skip players)
            local isPlayer = false
            for _, plr in pairs(game:GetService("Players"):GetPlayers()) do
                if plr.Character == obj then
                    isPlayer = true
                    break
                end
            end
            
            if not isPlayer and obj:FindFirstChild("HumanoidRootPart") then
                -- Create highlight
                local highlight = Instance.new("Highlight")
                highlight.FillColor = Color3.fromRGB(255, 0, 0)
                highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                highlight.FillTransparency = 0.3
                highlight.Adornee = obj
                highlight.Parent = gui
                table.insert(espHighlights, highlight)
            end
        end
    end
    
    statusText.Text = "👁️ FOUND " .. #espHighlights .. " NPCS"
end

espBtn.MouseButton1Click:Connect(function()
    espActive = not espActive
    if espActive then
        espBtn.Text = "👁️ NPC ESP [ON]"
        espBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        statusText.Text = "👁️ SCANNING FOR NPCS..."
        updateESP()
        
        -- Auto-refresh every 5 seconds
        spawn(function()
            while espActive do
                wait(5)
                updateESP()
            end
        end)
    else
        espBtn.Text = "👁️ NPC ESP [OFF]"
        espBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
        statusText.Text = "👁️ ESP OFF"
        for _, highlight in pairs(espHighlights) do
            pcall(function() highlight:Destroy() end)
        end
        espHighlights = {}
    end
end)

-- TP to nearest NPC
tpBtn.MouseButton1Click:Connect(function()
    local npcs = {}
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and obj:FindFirstChild("Humanoid") and not game:GetService("Players"):GetPlayerFromCharacter(obj) then
            if obj:FindFirstChild("HumanoidRootPart") then
                table.insert(npcs, obj)
            end
        end
    end
    
    if #npcs == 0 then
        statusText.Text = "❌ NO NPCS FOUND"
        return
    end
    
    local nearest = nil
    local nearestDist = math.huge
    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    
    local myPos = char.HumanoidRootPart.Position
    
    for _, npc in pairs(npcs) do
        local dist = (npc.HumanoidRootPart.Position - myPos).Magnitude
        if dist < nearestDist then
            nearestDist = dist
            nearest = npc
        end
    end
    
    if nearest then
        char.HumanoidRootPart.CFrame = nearest.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
        statusText.Text = "📍 TP TO " .. nearest.Name
    end
end)

-- ================ PRIVACY PAGE ================
local privacyY = 5
local hideNameBtn = createButton(privacyPage, "👤 HIDE USERNAME [OFF]", privacyY, Color3.fromRGB(100, 0, 100))
privacyY = privacyY + 45
local hideIdBtn = createButton(privacyPage, "🆔 HIDE USER ID [OFF]", privacyY, Color3.fromRGB(100, 0, 100))
privacyY = privacyY + 45
local blockChatBtn = createButton(privacyPage, "💬 BLOCK CHAT [OFF]", privacyY, Color3.fromRGB(100, 0, 100))
privacyY = privacyY + 45
local hideGuiBtn = createButton(privacyPage, "🎮 HIDE CORE GUI [OFF]", privacyY, Color3.fromRGB(100, 0, 100))

-- Privacy features
local hideNameActive = false
local hideIdActive = false
local blockChatActive = false
local hideGuiActive = false
local privacyOverlays = {}

hideNameBtn.MouseButton1Click:Connect(function()
    hideNameActive = not hideNameActive
    
    if hideNameActive then
        -- Disable player list
        pcall(function() starterGui:SetCore("PlayerListEnabled", false) end)
        
        -- Create name blocker
        local blocker = Instance.new("ScreenGui")
        blocker.Name = "NameBlocker"
        blocker.Parent = player.PlayerGui
        blocker.ResetOnSpawn = false
        blocker.IgnoreGuiInset = true
        
        local bar = Instance.new("Frame")
        bar.Size = UDim2.new(1, 0, 0, 30)
        bar.Position = UDim2.new(0, 0, 0, 0)
        bar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        bar.BackgroundTransparency = 0.3
        bar.BorderSizePixel = 0
        bar.ZIndex = 100
        bar.Parent = blocker
        
        privacyOverlays.nameBlocker = blocker
        
        hideNameBtn.Text = "👤 HIDE USERNAME [ON]"
        hideNameBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        statusText.Text = "👤 USERNAME HIDDEN"
    else
        pcall(function() starterGui:SetCore("PlayerListEnabled", true) end)
        if privacyOverlays.nameBlocker then
            privacyOverlays.nameBlocker:Destroy()
            privacyOverlays.nameBlocker = nil
        end
        hideNameBtn.Text = "👤 HIDE USERNAME [OFF]"
        hideNameBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 100)
        statusText.Text = "👤 USERNAME VISIBLE"
    end
end)

hideIdBtn.MouseButton1Click:Connect(function()
    hideIdActive = not hideIdActive
    
    if hideIdActive then
        -- Try to hide top bar
        pcall(function()
            if coreGui:FindFirstChild("RobloxGui") then
                local topBar = coreGui.RobloxGui:FindFirstChild("TopBar")
                if topBar then topBar.Enabled = false end
            end
        end)
        
        -- Create ID blocker
        local blocker = Instance.new("ScreenGui")
        blocker.Name = "IdBlocker"
        blocker.Parent = player.PlayerGui
        blocker.ResetOnSpawn = false
        blocker.IgnoreGuiInset = true
        
        local bar = Instance.new("Frame")
        bar.Size = UDim2.new(1, 0, 0, 60)
        bar.Position = UDim2.new(0, 0, 0, 0)
        bar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        bar.BackgroundTransparency = 0.5
        bar.BorderSizePixel = 0
        bar.ZIndex = 100
        bar.Parent = blocker
        
        privacyOverlays.idBlocker = blocker
        
        hideIdBtn.Text = "🆔 HIDE USER ID [ON]"
        hideIdBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        statusText.Text = "🆔 USER ID HIDDEN"
    else
        pcall(function()
            if coreGui:FindFirstChild("RobloxGui") then
                local topBar = coreGui.RobloxGui:FindFirstChild("TopBar")
                if topBar then topBar.Enabled = true end
            end
        end)
        if privacyOverlays.idBlocker then
            privacyOverlays.idBlocker:Destroy()
            privacyOverlays.idBlocker = nil
        end
        hideIdBtn.Text = "🆔 HIDE USER ID [OFF]"
        hideIdBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 100)
        statusText.Text = "🆔 USER ID VISIBLE"
    end
end)

-- ================ MONEY PAGE (VISUAL ONLY - CAN'T FIX) ================
local moneyY = 5
local walletBtn = createButton(moneyPage, "💰 VISUAL MONEY ONLY", moneyY, Color3.fromRGB(100, 100, 100))
moneyY = moneyY + 45
local checkBtn = createButton(moneyPage, "📊 CHECK MONEY VALUES", moneyY, Color3.fromRGB(0, 100, 200))

-- Money display (visual only)
local wallet = player:FindFirstChild("Stats") and player.Stats:FindFirstChild("Wallet")
if wallet then
    local moneyDisplay = Instance.new("TextLabel")
    moneyDisplay.Size = UDim2.new(1, -10, 0, 30)
    moneyDisplay.Position = UDim2.new(0, 5, 0, 100)
    moneyDisplay.Text = "CURRENT: $" .. wallet.Value
    moneyDisplay.TextColor3 = Color3.fromRGB(255, 200, 0)
    moneyDisplay.BackgroundColor3 = Color3.fromRGB(25, 30, 40)
    moneyDisplay.Font = Enum.Font.GothamBold
    moneyDisplay.TextSize = 14
    moneyDisplay.Parent = moneyPage
    
    local moneyCorner = Instance.new("UICorner")
    moneyCorner.CornerRadius = UDim.new(0, 8)
    moneyCorner.Parent = moneyDisplay
end

walletBtn.MouseButton1Click:Connect(function()
    if wallet then
        wallet.Value = 999999999
        statusText.Text = "💰 VISUAL CHANGE - SERVER WILL REVERT"
    end
end)

checkBtn.MouseButton1Click:Connect(function()
    if wallet then
        statusText.Text = "📊 CURRENT: $" .. wallet.Value
    end
end)

-- ================ FARM PAGE ================
local farmY = 5
local startFarmBtn = createButton(farmPage, "▶️ START AUTO FARM", farmY, Color3.fromRGB(0, 100, 0))
farmY = farmY + 45
local stopFarmBtn = createButton(farmPage, "⏹️ STOP FARM", farmY, Color3.fromRGB(100, 0, 0))

print("✅ FastWare V3 Loaded - Privacy Mode Added")
statusText.Text = "⚡ READY"

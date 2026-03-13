-- FastWare - Premium Edition
local player = game.Players.LocalPlayer
local workspace = game:GetService("Workspace")
local userInputService = game:GetService("UserInputService")
local players = game:GetService("Players")
local runService = game:GetService("RunService")
local replicatedStorage = game:GetService("ReplicatedStorage")
local coreGui = game:GetService("CoreGui")
local starterGui = game:GetService("StarterGui")

-- Main GUI
local gui = Instance.new("ScreenGui")
gui.Name = "FastWare"
gui.Parent = player:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.DisplayOrder = 999

-- Main container
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 400, 0, 500)
main.Position = UDim2.new(0, 20, 0, 20)
main.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
main.BorderSizePixel = 0
main.Parent = gui
main.Active = true
main.Draggable = true

-- Modern shadow effect
local shadow = Instance.new("ImageLabel")
shadow.Size = UDim2.new(1, 20, 1, 20)
shadow.Position = UDim2.new(0, -10, 0, -10)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
shadow.ImageTransparency = 0.6
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(10, 10, 10, 10)
shadow.Parent = main
shadow.ZIndex = -1

-- Main corner
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = main

-- Glass effect background
local background = Instance.new("Frame")
background.Size = UDim2.new(1, 0, 1, 0)
background.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
background.BackgroundTransparency = 0.1
background.BorderSizePixel = 0
background.Parent = main

local bgCorner = Instance.new("UICorner")
bgCorner.CornerRadius = UDim.new(0, 12)
bgCorner.Parent = background

local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 25, 35)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 10, 15))
})
gradient.Rotation = 90
gradient.Parent = background

-- Accent line
local accentLine = Instance.new("Frame")
accentLine.Size = UDim2.new(1, -40, 0, 2)
accentLine.Position = UDim2.new(0, 20, 0, 60)
accentLine.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
accentLine.BorderSizePixel = 0
accentLine.Parent = main

local accentCorner = Instance.new("UICorner")
accentCorner.CornerRadius = UDim.new(0, 2)
accentCorner.Parent = accentLine

-- Header
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 50)
header.BackgroundTransparency = 1
header.Parent = main

local logo = Instance.new("TextLabel")
logo.Size = UDim2.new(0, 40, 0, 40)
logo.Position = UDim2.new(0, 15, 0, 5)
logo.Text = "⚡"
logo.TextColor3 = Color3.fromRGB(0, 200, 255)
logo.BackgroundTransparency = 1
logo.Font = Enum.Font.GothamBold
logo.TextSize = 30
logo.Parent = header

local title = Instance.new("TextLabel")
title.Size = UDim2.new(0, 200, 0, 25)
title.Position = UDim2.new(0, 60, 0, 8)
title.Text = "FASTWARE"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 22
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

local version = Instance.new("TextLabel")
version.Size = UDim2.new(0, 200, 0, 15)
version.Position = UDim2.new(0, 60, 0, 30)
version.Text = "PREMIUM EDITION v3"
version.TextColor3 = Color3.fromRGB(150, 150, 150)
version.BackgroundTransparency = 1
version.Font = Enum.Font.Gotham
version.TextSize = 11
version.TextXAlignment = Enum.TextXAlignment.Left
version.Parent = header

-- Tab bar
local tabBar = Instance.new("Frame")
tabBar.Size = UDim2.new(1, -30, 0, 40)
tabBar.Position = UDim2.new(0, 15, 0, 55)
tabBar.BackgroundTransparency = 1
tabBar.Parent = main

local tabIndicator = Instance.new("Frame")
tabIndicator.Size = UDim2.new(0.25, -2, 0, 3)
tabIndicator.Position = UDim2.new(0, 0, 1, -3)
tabIndicator.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
tabIndicator.BorderSizePixel = 0
tabIndicator.Parent = tabBar

local function createTab(name, icon, pos)
    local tab = Instance.new("TextButton")
    tab.Size = UDim2.new(0.25, -2, 1, -5)
    tab.Position = UDim2.new((pos-1) * 0.25, (pos-1) * 2, 0, 0)
    tab.Text = icon .. "  " .. name
    tab.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    tab.TextColor3 = pos == 1 and Color3.fromRGB(0, 200, 255) or Color3.fromRGB(150, 150, 150)
    tab.Font = Enum.Font.GothamBold
    tab.TextSize = 13
    tab.Parent = tabBar
    
    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0, 6)
    tabCorner.Parent = tab
    
    return tab
end

local combatTab = createTab("COMBAT", "⚔️", 1)
local espTab = createTab("ESP", "👁️", 2)
local privacyTab = createTab("PRIVACY", "🔒", 3)
local farmTab = createTab("FARM", "🌾", 4)

-- Content container
local content = Instance.new("Frame")
content.Size = UDim2.new(1, -30, 1, -150)
content.Position = UDim2.new(0, 15, 0, 105)
content.BackgroundTransparency = 1
content.Parent = main

-- Pages
local pages = {}
local function createPage()
    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 4
    page.ScrollBarImageColor3 = Color3.fromRGB(0, 200, 255)
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    page.Visible = false
    page.Parent = content
    return page
end

local combatPage = createPage()
local espPage = createPage()
local privacyPage = createPage()
local farmPage = createPage()
combatPage.Visible = true

-- Tab switching
local tabs = {combatTab, espTab, privacyTab, farmTab}
local pagesList = {combatPage, espPage, privacyPage, farmPage}

for i, tab in ipairs(tabs) do
    tab.MouseButton1Click:Connect(function()
        tabIndicator:TweenPosition(UDim2.new((i-1) * 0.25, (i-1) * 2, 0, 0), "Out", "Quad", 0.2, true)
        
        for _, t in ipairs(tabs) do
            t.TextColor3 = Color3.fromRGB(150, 150, 150)
        end
        tab.TextColor3 = Color3.fromRGB(0, 200, 255)
        
        for j, page in ipairs(pagesList) do
            page.Visible = (j == i)
        end
    end)
end

-- Button creator
local function createButton(parent, text, yPos, color, icon)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 45)
    btn.Position = UDim2.new(0, 5, 0, yPos)
    btn.BackgroundColor3 = color or Color3.fromRGB(25, 25, 30)
    btn.Text = (icon or "•") .. "  " .. text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.Parent = parent
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn
    
    return btn
end

-- Status bar
local statusBar = Instance.new("Frame")
statusBar.Size = UDim2.new(1, -30, 0, 35)
statusBar.Position = UDim2.new(0, 15, 1, -45)
statusBar.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
statusBar.BorderSizePixel = 0
statusBar.Parent = main

local statusCorner = Instance.new("UICorner")
statusCorner.CornerRadius = UDim.new(0, 8)
statusCorner.Parent = statusBar

local statusText = Instance.new("TextLabel")
statusText.Size = UDim2.new(1, -15, 1, 0)
statusText.Position = UDim2.new(0, 10, 0, 0)
statusText.Text = "⚡ READY"
statusText.TextColor3 = Color3.fromRGB(0, 255, 0)
statusText.BackgroundTransparency = 1
statusText.Font = Enum.Font.GothamBold
statusText.TextSize = 13
statusText.TextXAlignment = Enum.TextXAlignment.Left
statusText.Parent = statusBar

-- ================ COMBAT PAGE (WORKING FEATURES) ================
local combatY = 5
local ammoBtn = createButton(combatPage, "INFINITE AMMO", combatY, Color3.fromRGB(40, 40, 50), "🔫")
combatY = combatY + 50
local speedBtn = createButton(combatPage, "SPEED BOOST", combatY, Color3.fromRGB(40, 40, 50), "⚡")

-- Combat state
local ammoActive = false
local speedActive = false

-- Infinite ammo (WORKING)
ammoBtn.MouseButton1Click:Connect(function()
    ammoActive = not ammoActive
    if ammoActive then
        ammoBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        ammoBtn.Text = "🔫  INFINITE AMMO [ON]"
        statusText.Text = "🔫 INFINITE AMMO ACTIVE"
        
        -- Keep ammo maxed
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
        ammoBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        ammoBtn.Text = "🔫  INFINITE AMMO [OFF]"
        statusText.Text = "🔫 AMMO OFF"
    end
end)

-- Speed boost (WORKING)
speedBtn.MouseButton1Click:Connect(function()
    speedActive = not speedActive
    local char = player.Character
    if char and char:FindFirstChild("Humanoid") then
        if speedActive then
            speedBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
            speedBtn.Text = "⚡  SPEED BOOST [ON]"
            char.Humanoid.WalkSpeed = 50
            statusText.Text = "⚡ SPEED BOOSTED"
        else
            speedBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
            speedBtn.Text = "⚡  SPEED BOOST [OFF]"
            char.Humanoid.WalkSpeed = 16
            statusText.Text = "⚡ SPEED NORMAL"
        end
    end
end)

-- ================ ESP PAGE (NITTIES ONLY) ================
local espY = 5
local nittyEspBtn = createButton(espPage, "NITTY ESP", espY, Color3.fromRGB(40, 40, 50), "👁️")
espY = espY + 50
local refreshBtn = createButton(espPage, "REFRESH NITTIES", espY, Color3.fromRGB(40, 40, 50), "🔄")
espY = espY + 50
local tpBtn = createButton(espPage, "TP TO NEAREST NITTY", espY, Color3.fromRGB(0, 100, 200), "📍")

-- ESP state
local espActive = false
local espHighlights = {}

-- Find only Nitties
local function findNitties()
    local nitties = {}
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and obj:FindFirstChild("Humanoid") then
            -- Check if it's a Nitty (by name or pattern)
            local name = obj.Name:lower()
            if name:find("nitty") or name:find("npc") then
                -- Make sure it's not a player
                local isPlayer = false
                for _, plr in pairs(players:GetPlayers()) do
                    if plr.Character == obj then
                        isPlayer = true
                        break
                    end
                end
                if not isPlayer then
                    table.insert(nitties, obj)
                end
            end
        end
    end
    return nitties
end

-- Update ESP
local function updateNittyESP()
    -- Clear old ESP
    for _, highlight in pairs(espHighlights) do
        pcall(function() highlight:Destroy() end)
    end
    espHighlights = {}
    
    if not espActive then return end
    
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
    
    statusText.Text = "👁️ FOUND " .. #nitties .. " NITTIES"
end

nittyEspBtn.MouseButton1Click:Connect(function()
    espActive = not espActive
    if espActive then
        nittyEspBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        nittyEspBtn.Text = "👁️  NITTY ESP [ON]"
        updateNittyESP()
    else
        nittyEspBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        nittyEspBtn.Text = "👁️  NITTY ESP [OFF]"
        for _, highlight in pairs(espHighlights) do
            pcall(function() highlight:Destroy() end)
        end
        espHighlights = {}
        statusText.Text = "👁️ ESP OFF"
    end
end)

refreshBtn.MouseButton1Click:Connect(function()
    if espActive then
        updateNittyESP()
    else
        local count = #findNitties()
        statusText.Text = "👁️ " .. count .. " NITTIES IN GAME"
    end
end)

tpBtn.MouseButton1Click:Connect(function()
    local nitties = findNitties()
    if #nitties == 0 then
        statusText.Text = "❌ NO NITTIES FOUND"
        return
    end
    
    local nearest = nil
    local nearestDist = math.huge
    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    
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

-- ================ PRIVACY PAGE (WORKING FEATURES) ================
local privacyY = 5
local nameBtn = createButton(privacyPage, "HIDE USERNAME", privacyY, Color3.fromRGB(40, 40, 50), "👤")
privacyY = privacyY + 50
local chatBtn = createButton(privacyPage, "BLOCK CHAT", privacyY, Color3.fromRGB(40, 40, 50), "💬")

-- Privacy state
local nameHidden = false
local chatBlocked = false
local privacyOverlays = {}

nameBtn.MouseButton1Click:Connect(function()
    nameHidden = not nameHidden
    if nameHidden then
        nameBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        nameBtn.Text = "👤  HIDE USERNAME [ON]"
        
        -- Disable player list
        pcall(function() starterGui:SetCore("PlayerListEnabled", false) end)
        
        -- Create overlay
        local overlay = Instance.new("ScreenGui")
        overlay.Name = "NameBlocker"
        overlay.Parent = player.PlayerGui
        overlay.ResetOnSpawn = false
        overlay.IgnoreGuiInset = true
        
        local bar = Instance.new("Frame")
        bar.Size = UDim2.new(1, 0, 0, 30)
        bar.Position = UDim2.new(0, 0, 0, 0)
        bar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        bar.BackgroundTransparency = 0.5
        bar.BorderSizePixel = 0
        bar.ZIndex = 100
        bar.Parent = overlay
        
        privacyOverlays.nameOverlay = overlay
        statusText.Text = "👤 USERNAME HIDDEN"
    else
        nameBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        nameBtn.Text = "👤  HIDE USERNAME [OFF]"
        
        pcall(function() starterGui:SetCore("PlayerListEnabled", true) end)
        if privacyOverlays.nameOverlay then
            privacyOverlays.nameOverlay:Destroy()
            privacyOverlays.nameOverlay = nil
        end
        statusText.Text = "👤 USERNAME VISIBLE"
    end
end)

chatBtn.MouseButton1Click:Connect(function()
    chatBlocked = not chatBlocked
    if chatBlocked then
        chatBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        chatBtn.Text = "💬  BLOCK CHAT [ON]"
        
        -- Hide chat
        pcall(function()
            local chat = player.PlayerGui:FindFirstChild("Chat")
            if chat then chat.Enabled = false end
        end)
        
        statusText.Text = "💬 CHAT BLOCKED"
    else
        chatBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        chatBtn.Text = "💬  BLOCK CHAT [OFF]"
        
        pcall(function()
            local chat = player.PlayerGui:FindFirstChild("Chat")
            if chat then chat.Enabled = true end
        end)
        
        statusText.Text = "💬 CHAT VISIBLE"
    end
end)

-- ================ FARM PAGE (QUICK TP) ================
local farmY = 5
local butcherBtn = createButton(farmPage, "BUTCHER SPOT 1", farmY, Color3.fromRGB(40, 40, 50), "🥩")
farmY = farmY + 50
local butcherBtn2 = createButton(farmPage, "BUTCHER SPOT 2", farmY, Color3.fromRGB(40, 40, 50), "🔪")
farmY = farmY + 50
local butcherBtn3 = createButton(farmPage, "BUTCHER SPOT 3", farmY, Color3.fromRGB(40, 40, 50), "💰")

-- Farm positions (from original)
local farmSpots = {
    Vector3.new(-681.16, 3.36, -497.09),
    Vector3.new(-356.14, 3.36, -497.93),
    Vector3.new(-342.1, 3.36, -509.72)
}

butcherBtn.MouseButton1Click:Connect(function()
    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = CFrame.new(farmSpots[1])
        statusText.Text = "📍 TP TO SPOT 1"
    end
end)

butcherBtn2.MouseButton1Click:Connect(function()
    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = CFrame.new(farmSpots[2])
        statusText.Text = "📍 TP TO SPOT 2"
    end
end)

butcherBtn3.MouseButton1Click:Connect(function()
    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = CFrame.new(farmSpots[3])
        statusText.Text = "📍 TP TO SPOT 3"
    end
end)

-- Auto-refresh ESP if active
spawn(function()
    while true do
        if espActive then
            updateNittyESP()
        end
        wait(3)
    end
end)

-- Character respawn handling
player.CharacterAdded:Connect(function()
    wait(1)
    if speedActive then
        local char = player.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = 50
        end
    end
end)

print("✅ FastWare Premium Loaded")
statusText.Text = "⚡ READY"

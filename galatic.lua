-- FastWare Main Script
-- Place this in a LocalScript inside a ScreenGui in StarterGui

local FastWare = {}

-- UI Setup
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FastWareGUI"
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 400, 0, 500)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -250)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30,課40)
mainFrame.BackgroundTransparency = 0.2
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- Title
local title = Instance.new("TextLabel")
title.Name = "Title"
title.Text = "FASTWARE"
title.Size = UDim2.new(1, 0, 0, 50)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
title.TextColor3 = Color3.fromRGB(0, 255, 150)
title.Font = Enum.Font.GothamBold
title.TextSize = 28
title.Parent = mainFrame

-- Category buttons container
local categoryFrame = Instance.new("Frame")
categoryFrame.Name = "CategoryFrame"
categoryFrame.Size = UDim2.new(1, 0, 0, 40)
categoryFrame.Position = UDim2.new(0, 0, 0, 55)
categoryFrame.BackgroundTransparency = 1
categoryFrame.Parent = mainFrame

-- Content frame (where features appear)
local contentFrame = Instance.new("Frame")
contentFrame.Name = "ContentFrame"
contentFrame.Size = UDim2.new(1, 0, 1, -100)
contentFrame.Position = UDim2.new(0, 0, 0, 100)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

-- Categories
local categories = {
    "Weapons",
    "Money",
    "More"
}

local currentCategory = "Weapons"

-- Create category buttons
for i, catName in ipairs(categories) do
    local btn = Instance.new("TextButton")
    btn.Name = catName
    btn.Text = catName
    btn.Size = UDim2.new(0.33, -4, 1, 0)
    btn.Position = UDim2.new((i-1)/3, 2, 0, 0)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 18
    btn.Parent = categoryFrame
    
    btn.MouseButton1Click:Connect(function()
        currentCategory = catName
        FastWare.ShowCategory(catName)
    end)
end

-- Category Contents
FastWare.CategoryContents = {
    Weapons = function()
        -- Clear previous content
        for _, v in ipairs(contentFrame:GetChildren()) do
            v:Destroy()
        end
        
        -- Infinite Ammo Feature
        local infAmmoFrame = Instance.new("Frame")
        infAmmoFrame.Size = UDim2.new(1, -20, 0, 120)
        infAmmoFrame.Position = UDim2.new(0, 10, 0, 10)
        infAmmoFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
        infAmmoFrame.BackgroundTransparency = 0.1
        infAmmoFrame.Parent = contentFrame
        
        local infLabel = Instance.new("TextLabel")
        infLabel.Text = "INFINITE AMMO"
        infLabel.Size = UDim2.new(1, 0, 0, 30)
        infLabel.Position = UDim2.new(0, 0, 0, 5)
        infLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        infLabel.Font = Enum.Font.GothamBold
        infLabel.TextSize = 22
        infLabel.Parent = infAmmoFrame
        
        local desc = Instance.new("TextLabel")
        desc.Text = "Your gun will never run out of ammo."
        desc.Size = UDim2.new(1, 0, 0, 25)
        desc.Position = UDim2.new(0, 0, 0, 35)
        desc.TextColor3 = Color3.fromRGB(180, 180, 180)
        desc.Font = Enum.Font.Gotham
        desc.TextSize = 16
        desc.Parent = infAmmoFrame
        
        local toggleBtn = Instance.new("TextButton")
        toggleBtn.Text = "ACTIVATE"
        toggleBtn.Size = UDim2.new(0, 120, 0, 40)
        toggleBtn.Position = UDim2.new(0.5, -60, 0, 70)
        toggleBtn.BackgroundColor3 = Color3.fromRGB(80, 180, 80)
        toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        toggleBtn.Font = Enum.Font.GothamBold
        toggleBtn.TextSize = 18
        toggleBtn.Parent = infAmmoFrame
        
        local activated = false
        toggleBtn.MouseButton1Click:Connect(function()
            activated = not activated
            if activated then
                toggleBtn.Text = "ACTIVATED"
                toggleBtn.BackgroundColor3 = Color3.fromRGB(180, 80, 80)
                
                -- Infinite ammo logic
                spawn(function()
                    while activated do
                        -- This tries to find your gun and set ammo to max
                        local character = game.Players.LocalPlayer.Character
                        if character then
                            for _, tool in ipairs(character:GetChildren()) do
                                if tool:IsA("Tool") then
                                    -- Try common ammo properties
                                    local ammo = tool:FindFirstChild("Ammo")
                                    if ammo and ammo:IsA("IntValue") then
                                        ammo.Value = 999999
                                    end
                                    
                                    local clip = tool:FindFirstChild("Clip")
                                    if clip and clip:IsA("IntValue") then
                                        clip.Value = 999999
                                    end
                                end
                            end
                        end
                        wait(0.5)
                    end
                end)
            else
                toggleBtn.Text = "ACTIVATE"
                toggleBtn.BackgroundColor3 = Color3.fromRGB(80, 180, 80)
            end
        end)
    end,
    
    Money = function()
        -- Clear previous content
        for _, v in ipairs(contentFrame:GetChildren()) do
            v:Destroy()
        end
        
        -- Money Giver Feature
        local moneyFrame = Instance.new("Frame")
        moneyFrame.Size = UDim2.new(1, -20, 0, 150)
        moneyFrame.Position = UDim2.new(0, 10, 0, 10)
        moneyFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
        moneyFrame.BackgroundTransparency = 0.1
        moneyFrame.Parent = contentFrame
        
        local moneyLabel = Instance.new("TextLabel")
        moneyLabel.Text = "MONEY GIVER"
        moneyLabel.Size = UDim2.new(1, 0, 0, 30)
        moneyLabel.Position = UDim2.new(0, 0, 0, 5)
        moneyLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
        moneyLabel.Font = Enum.Font.GothamBold
        moneyLabel.TextSize = 22
        moneyLabel.Parent = moneyFrame
        
        local desc = Instance.new("TextLabel")
        desc.Text = "Click button to get $5,000 (non-visual, spendable)"
        desc.Size = UDim2.new(1, 0, 0, 25)
        desc.Position = UDim2.new(0, 0, 0, 35)
        desc.TextColor3 = Color3.fromRGB(180, 180, 180)
        desc.Font = Enum.Font.Gotham
        desc.TextSize = 16
        desc.Parent = moneyFrame
        
        local moneyBtn = Instance.new("TextButton")
        moneyBtn.Text = "GET $5,000"
        moneyBtn.Size = UDim2.new(0, 140, 0, 50)
        moneyBtn.Position = UDim2.new(0.5, -70, 0, 70)
        moneyBtn.BackgroundColor3 = Color3.fromRGB(100, 180, 220)
        moneyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        moneyBtn.Font = Enum.Font.GothamBold
        moneyBtn.TextSize = 20
        moneyBtn.Parent = moneyFrame
        
        -- Money giving logic
        moneyBtn.MouseButton1Click:Connect(function()
            -- Try to find money system in the game
            local player = game.Players.LocalPlayer
            
            -- Common money storage names
            local moneyNames = {"Money", "Cash", "Dollars", "Currency", "Points"}
            
            for _, name in ipairs(moneyNames) do
                local moneyValue = player:FindFirstChild(name)
                if moneyValue and moneyValue:IsA("IntValue") then
                    moneyValue.Value = moneyValue.Value + 5000
                    break
                end
            end
            
            -- If not found, try backpack
            local backpack = player:WaitForChild("Backpack")
            for _, item in ipairs(backpack:GetChildren()) do
                if item.Name == "Money" or item.Name == "Cash" then
                    if item:IsA("IntValue") then
                        item.Value = item.Value + 5000
                    end
                end
            end
        end)
    end,
    
    More = function()
        -- Clear previous content
        for _, v in ipairs(contentFrame:GetChildren()) do
            v:Destroy()
        end
        
        local moreFrame = Instance.new("Frame")
        moreFrame.Size = UDim2.new(1, -20, 0, 80)
        moreFrame.Position = UDim2.new(0, 10, 0, 10)
        moreFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
        moreFrame.BackgroundTransparency = 0.1
        moreFrame.Parent = contentFrame
        
        local moreLabel = Instance.new("TextLabel")
        moreLabel.Text = "MORE FEATURES"
        moreLabel.Size = UDim2.new(1, 0, 0, 30)
        moreLabel.Position = UDim2.new(0, 0, 0, 5)
        moreLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
        moreLabel.Font = Enum.Font.GothamBold
        moreLabel.TextSize = 22
        moreLabel.Parent = moreFrame
        
        local desc = Instance.new("TextLabel")
        desc.Text = "Add more features here later!"
        desc.Size = UDim2.new(1, 0, 0, 25)
        desc.Position = UDim2.new(0, 0, 0, 35)
        desc.TextColor3 = Color3.fromRGB(180, 180, 180)
        desc.Font = Enum.Font.Gotham
        desc.TextSize = 16
        desc.Parent = moreFrame
    end
}

-- Function to show category
FastWare.ShowCategory = function(category)
    if FastWare.CategoryContents[category] then
        FastWare.CategoryContents[category]()
    end
end

-- Initialize
FastWare.ShowCategory("Weapons")

-- Make UI draggable
local dragging = false
local dragStart
local startPos

mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)

mainFrame.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

mainFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

return FastWare

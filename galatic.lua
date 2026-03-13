-- Add this to the COMBAT PAGE section (around line 200-250 where other combat buttons are)

-- ================ HIDE NAME FEATURE ================
local y = 5 -- adjust this based on where your other buttons end
-- After your last combat button, add:

local hideNameBtn = createButton(combatPage, "👤 HIDE USERNAME [OFF]", y, Color3.fromRGB(100, 0, 100))
y = y + 45
local hideIdBtn = createButton(combatPage, "🆔 HIDE USER ID [OFF]", y, Color3.fromRGB(100, 0, 100))

-- State variables
local hideNameActive = false
local hideIdActive = false
local originalName = player.Name
local originalDisplayName = player.DisplayName

-- Function to hide username
local function toggleHideName()
    hideNameActive = not hideNameActive
    
    if hideNameActive then
        -- Try multiple methods to hide name
        
        -- Method 1: Hide playerlist completely
        pcall(function()
            game:GetService("StarterGui"):SetCore("PlayerListEnabled", false)
        end)
        
        -- Method 2: Try to modify core GUI (if possible)
        pcall(function()
            local coreGui = game:GetService("CoreGui")
            if coreGui:FindFirstChild("RobloxGui") then
                local playerList = coreGui.RobloxGui:FindFirstChild("PlayerList")
                if playerList then
                    playerList.Enabled = false
                end
            end
        end)
        
        -- Method 3: Create overlay to block name (client-side only)
        local screenGui = Instance.new("ScreenGui")
        screenGui.Name = "NameBlocker"
        screenGui.Parent = player:WaitForChild("PlayerGui")
        screenGui.ResetOnSpawn = false
        screenGui.IgnoreGuiInset = true
        
        -- Black bar overlay for top of screen where name appears
        local blackBar = Instance.new("Frame")
        blackBar.Size = UDim2.new(1, 0, 0, 30)
        blackBar.Position = UDim2.new(0, 0, 0, 0)
        blackBar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        blackBar.BackgroundTransparency = 0.3
        blackBar.BorderSizePixel = 0
        blackBar.ZIndex = 10
        blackBar.Parent = screenGui
        
        -- Store for cleanup
        if not _G.nameBlocker then _G.nameBlocker = {} end
        _G.nameBlocker = screenGui
        
        hideNameBtn.Text = "👤 HIDE USERNAME [ON]"
        hideNameBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        statusText.Text = "👤 USERNAME HIDDEN"
    else
        -- Restore playerlist
        pcall(function()
            game:GetService("StarterGui"):SetCore("PlayerListEnabled", true)
        end)
        
        -- Remove overlay
        if _G.nameBlocker then
            pcall(function() _G.nameBlocker:Destroy() end)
            _G.nameBlocker = nil
        end
        
        hideNameBtn.Text = "👤 HIDE USERNAME [OFF]"
        hideNameBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 100)
        statusText.Text = "👤 USERNAME VISIBLE"
    end
end

-- Function to hide User ID (more aggressive)
local function toggleHideId()
    hideIdActive = not hideIdActive
    
    if hideIdActive then
        -- Create a more aggressive blocker for the entire top bar
        local screenGui = Instance.new("ScreenGui")
        screenGui.Name = "IdBlocker"
        screenGui.Parent = player:WaitForChild("PlayerGui")
        screenGui.ResetOnSpawn = false
        screenGui.IgnoreGuiInset = true
        
        -- Full top bar blocker
        local topBlocker = Instance.new("Frame")
        topBlocker.Size = UDim2.new(1, 0, 0, 60)
        topBlocker.Position = UDim2.new(0, 0, 0, 0)
        topBlocker.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        topBlocker.BackgroundTransparency = 0.5
        topBlocker.BorderSizePixel = 0
        topBlocker.ZIndex = 20
        topBlocker.Parent = screenGui
        
        -- Store for cleanup
        if not _G.idBlocker then _G.idBlocker = {} end
        _G.idBlocker = screenGui
        
        -- Try to block specific UI elements
        pcall(function()
            local coreGui = game:GetService("CoreGui")
            if coreGui:FindFirstChild("RobloxGui") then
                local topBar = coreGui.RobloxGui:FindFirstChild("TopBar")
                if topBar then
                    topBar.Enabled = false
                end
            end
        end)
        
        hideIdBtn.Text = "🆔 HIDE USER ID [ON]"
        hideIdBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        statusText.Text = "🆔 USER ID HIDDEN"
    else
        -- Restore UI
        pcall(function()
            local coreGui = game:GetService("CoreGui")
            if coreGui:FindFirstChild("RobloxGui") then
                local topBar = coreGui.RobloxGui:FindFirstChild("TopBar")
                if topBar then
                    topBar.Enabled = true
                end
            end
        end)
        
        -- Remove blocker
        if _G.idBlocker then
            pcall(function() _G.idBlocker:Destroy() end)
            _G.idBlocker = nil
        end
        
        hideIdBtn.Text = "🆔 HIDE USER ID [OFF]"
        hideIdBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 100)
        statusText.Text = "🆔 USER ID VISIBLE"
    end
end

-- Connect buttons
hideNameBtn.MouseButton1Click:Connect(toggleHideName)
hideIdBtn.MouseButton1Click:Connect(toggleHideId)

-- Auto-cleanup on character respawn
player.CharacterAdded:Connect(function()
    -- Reapply name hiding if active
    if hideNameActive then
        task.wait(1)
        toggleHideName()
        toggleHideName() -- toggle twice to re-enable
    end
    if hideIdActive then
        task.wait(1)
        toggleHideId()
        toggleHideId()
    end
end)

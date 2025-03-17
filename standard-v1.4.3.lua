local DiscordLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/discord%20lib.txt"))()

local win = DiscordLib:Window("Standard Script Roblox version 1.4.3 By.carfty")

-- ---------------------------------------
-- ✅ Aimbot & FOV Settings
-- ---------------------------------------
local serv = win:Server("Aimbot & FOV Settings", "")

local aimbotSection = serv:Channel("Aimbot Settings")

local AimbotEnabled = false
local FOVEnabled = true
local FOVAmount = 90

-- Aimbot Toggle
aimbotSection:Toggle("Enable Aimbot", false, function(state)
    local AimbotScript = loadstring(game:HttpGet("https://raw.githubusercontent.com/Barry51203/Standard-Roblox-Script-v-0.2.1/refs/heads/main/aim-bot.lua"))()
    
    FOVEnabled = state
    local camera = game.Workspace.CurrentCamera
    if FOVEnabled then
        camera.FieldOfView = FOVAmount
    else
        camera.FieldOfView = 70
        print("FOV Disabled")
    end
end)

-- Lock Body Part Dropdown
aimbotSection:Dropdown("Lock Body Part (Default Head)", {"Head"}, function(part)
    Aimbot.LockPart = part
end)

local FovSection = serv:Channel("FOV Settings")

-- FOV Amount Slider
FovSection:Slider("FOV Amount", 60, 150, FOVAmount, function(amount)
    FOVAmount = amount
    local camera = game.Workspace.CurrentCamera
    if FOVEnabled then
        camera.FieldOfView = FOVAmount
    end
end)

-- Reset FOV Button
FovSection:Button("Reset FOV", function()
    AimbotEnabled = false
    FOVEnabled = true
    FOVAmount = 90
    local camera = game.Workspace.CurrentCamera
    camera.FieldOfView = FOVAmount
end)


-- ---------------------------------------
-- ✅ ESP Settings
-- ---------------------------------------
local serv = win:Server("ESP Settings", "")

local espSection = serv:Channel("ESP Settings")

local Esp = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/x114/RobloxScripts/main/OpenSourceEsp"))()

-- ESP Box Toggle
espSection:Toggle("ESP Box", false, function(state)
    Esp.Box = state
    Esp.BoxColor = Color3.fromRGB(255, 255, 255)
    Esp.BoxOutline = true
    Esp.BoxOutlineColor = Color3.fromRGB(0, 0, 0)
end)

-- ESP Health Bar Toggle
espSection:Toggle("ESP Health Bar", false, function(state)
    Esp.HealthBar = state
    Esp.HealthBarSide = "Left"
end)

-- ESP Name Toggle
espSection:Toggle("ESP Name", false, function(state)
    Esp.Names = state
    Esp.NamesColor = Color3.fromRGB(255, 255, 255)
    Esp.NamesOutline = true
    Esp.NamesFont = 2
    Esp.NamesSize = 13
end)


-- ---------------------------------------
-- ✅ Movement Settings
-- ---------------------------------------
local serv = win:Server("Movement Settings", "")

local movementSection = serv:Channel("Movement Settings")

-- Walk Speed Slider
movementSection:Slider("Walk Speed", 16, 600, 16, function(speed)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = speed
end)

-- Jump Power Slider
movementSection:Slider("Jump Power", 50, 600, 50, function(jumpPower)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = jumpPower
end)

-- Infinite Jump Button
movementSection:Button("Infinite Jump", function()
    local InfiniteJumpEnabled = true
    game:GetService("UserInputService").JumpRequest:Connect(function()
        if InfiniteJumpEnabled then
            game.Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):ChangeState("Jumping")
        end
    end)
end)

-- Ctrl + Click Teleport Button
movementSection:Button("Ctrl + Click Teleport", function()
    local UIS = game:GetService("UserInputService")
    local Player = game.Players.LocalPlayer
    local Mouse = Player:GetMouse()

    UIS.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 and UIS:IsKeyDown(Enum.KeyCode.LeftControl) then
            Player.Character:MoveTo(Mouse.Hit.p)
        end
    end)
end)


-- ---------------------------------------
-- ✅ Tools Section
-- ---------------------------------------
local serv = win:Server("Tools", "")

local toolsTab = serv:Channel("Tools")

-- FPS Booster Button
toolsTab:Button("Boost FPS", function()
    _G.Settings = {
        Players = {["Ignore Me"] = true, ["Ignore Others"] = true},
        Meshes = {Destroy = false, LowDetail = true},
        Images = {Invisible = true, LowDetail = false, Destroy = false},
        ["No Particles"] = true, ["No Camera Effects"] = true, ["No Explosions"] = true,
        ["No Clothes"] = true, ["Low Water Graphics"] = true, ["No Shadows"] = true,
        ["Low Rendering"] = true, ["Low Quality Parts"] = true
    }
    loadstring(game:HttpGet("https://raw.githubusercontent.com/CasperFlyModz/discord.gg-rips/main/FPSBooster.lua"))()
end)

-- DEX V5 Button
toolsTab:Button("DEX V5", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/dyyll/Dex-V5-leak/refs/heads/main/Dex%20V5.lua"))()
end)

-- Remote Spy Button
toolsTab:Button("Remote Spy", function()
    loadstring(game:HttpGetAsync("https://github.com/richie0866/remote-spy/releases/latest/download/RemoteSpy.lua"))()
end)

-- Infinite Yield Button
toolsTab:Button("Infinite Yield", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
end)


-- ---------------------------------------
-- ✅ Settings Section
-- ---------------------------------------
local serv = win:Server("Settings", "")

-- local settingsTab = serv:Channel("Settings")

local ContactTab = serv:Channel("Contact")
-- Buttons for Discord and YouTube links
ContactTab:Button("Discord: c4rfty.", "คลิกเพื่อเข้าร่วม Discord", function()
    setclipboard("https://discord.gg/YOUR_INVITE_LINK")
    game:GetService("GuiService"):OpenBrowser("https://discord.gg/YOUR_INVITE_LINK")
end)

ContactTab:Button("Youtube: Robloxeliteplayer", "คลิกเพื่อเข้าร่วม Youtube", function()
    setclipboard("https://www.youtube.com/@playerroblox55555")
    game:GetService("GuiService"):OpenBrowser("https://www.youtube.com/@playerroblox55555")
end)
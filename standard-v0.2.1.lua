local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))() 
local Window = Library.CreateLib("Standard Script Roblox version 0.2.1 [Beta] By.carfty", "BloodTheme") -- ใช้ธีม BloodTheme

-- ✅ Standard Tab
local standard = Window:NewTab("Standard")
local espSection = standard:NewSection("ESP Settings")

local Esp = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/x114/RobloxScripts/main/OpenSourceEsp"))()

espSection:NewToggle("ESP Box", "แสดงกล่องรอบผู้เล่น", function(state)
    Esp.Box = state
    Esp.BoxColor = Color3.fromRGB(255, 255, 255)
    Esp.BoxOutline = true
    Esp.BoxOutlineColor = Color3.fromRGB(0, 0, 0)
end)

espSection:NewToggle("ESP Health Bar", "แสดงหลอดเลือด", function(state)
    Esp.HealthBar = state
    Esp.HealthBarSide = "Left"
end)

espSection:NewToggle("ESP Name", "แสดงชื่อผู้เล่น", function(state)
    Esp.Names = state
    Esp.NamesColor = Color3.fromRGB(255, 255, 255)
    Esp.NamesOutline = true
    Esp.NamesFont = 2
    Esp.NamesSize = 13
end)

-- ✅ Movement Section
local movementSection = standard:NewSection("Movement Settings")

movementSection:NewSlider("Walk Speed", "ปรับความเร็วเดิน", 600, 16, function(speed)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = speed
end)

movementSection:NewSlider("Jump Power", "ปรับพลังกระโดด", 600, 50, function(jumpPower)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = jumpPower
end)

movementSection:NewButton("Infinite Jump", "กด Space กระโดดไม่จำกัด", function()
    local InfiniteJumpEnabled = true
    game:GetService("UserInputService").JumpRequest:Connect(function()
        if InfiniteJumpEnabled then
            game.Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):ChangeState("Jumping")
        end
    end)
end)

movementSection:NewButton("Ctrl + Click Teleport", "กด Ctrl + Click เพื่อวาร์ป", function()
    local UIS = game:GetService("UserInputService")
    local Player = game.Players.LocalPlayer
    local Mouse = Player:GetMouse()

    UIS.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 and UIS:IsKeyDown(Enum.KeyCode.LeftControl) then
            Player.Character:MoveTo(Mouse.Hit.p)
        end
    end)
end)

-- ✅ Utility Tools Section
local toolsTab = Window:NewTab("Tools")
local toolsSection = toolsTab:NewSection("Utility Scripts")

toolsSection:NewButton("Boost FPS", "เพิ่ม FPS โดยลดเอฟเฟค", function()
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

toolsSection:NewButton("DEX V5", "เครื่องมือ Dev Explorer", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/dyyll/Dex-V5-leak/refs/heads/main/Dex%20V5.lua"))()
end)

toolsSection:NewButton("Remote Spy", "ดักจับ Remote Events", function()
    loadstring(game:HttpGetAsync("https://github.com/richie0866/remote-spy/releases/latest/download/RemoteSpy.lua"))()
end)

toolsSection:NewButton("Infinite Yield", "คอมมานด์แอดมิน", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
end)

-- ✅ Settings Section
local settingsTab = Window:NewTab("Settings")
local settingsSection = settingsTab:NewSection("UI Settings")

settingsSection:NewKeybind("Toggle UI", "กดเพื่อซ่อน/แสดง UI", Enum.KeyCode.F, function()
	Library:ToggleUI()
end)

local themes = {
    "GrapeTheme",
    "BloodTheme",
    "Ocean",
    "Midnight",
    "Sentinel"
}


-- ✅ เพิ่ม Color Picker (Custom Theme Settings)
local colors = {
    SchemeColor = Color3.fromRGB(138, 43, 226), -- สีหลัก (GrapeTheme)
    Background = Color3.fromRGB(20, 20, 20),
    Header = Color3.fromRGB(30, 30, 30),
    TextColor = Color3.fromRGB(255, 255, 255),
    ElementColor = Color3.fromRGB(40, 40, 40)
}

local themes = {
    SchemeColor = colors.SchemeColor,
    Background = colors.Background,
    Header = colors.Header,
    TextColor = colors.TextColor,
    ElementColor = colors.ElementColor
}

local colorSection = settingsTab:NewSection("Theme Settings")

for theme, color in pairs(themes) do
    colorSection:NewColorPicker(theme, "Change your "..theme, color, function(color3)
        Library:ChangeColor(theme, color3)
    end)
end

local contactSection = settingsTab:NewSection("Contact")

contactSection:NewButton("Discord: c4rfty.", "คลิกเพื่อเข้าร่วม Discord", function()
    setclipboard("https://discord.gg/YOUR_INVITE_LINK") -- คัดลอกลิงก์ไปที่คลิปบอร์ด
    game:GetService("GuiService"):OpenBrowser("https://discord.gg/YOUR_INVITE_LINK") -- เปิดลิงก์ในเบราว์เซอร์
end)

contactSection:NewButton("Youtube: Robloxeliteplayer", "คลิกเพื่อเข้าร่วม Youtube", function()
    setclipboard("https://www.youtube.com/@playerroblox55555") -- คัดลอกลิงก์ไปที่คลิปบอร์ด
    game:GetService("GuiService"):OpenBrowser("https://www.youtube.com/@playerroblox55555") -- เปิดลิงก์ในเบราว์เซอร์
end)

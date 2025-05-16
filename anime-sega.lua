local DiscordLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/discord%20lib.txt"))() 

local win = DiscordLib:Window("Anime Saga Script version 1.0.0 By.carfty")

local Players = game:GetService("Players") 
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")

local localPlayer = Players.LocalPlayer
local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local walking = false
local clicking = false

-- เปิด noclip เมื่อกำลังบิน
RunService.Stepped:Connect(function()
    if walking then
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

-- Auto Click
spawn(function()
    while true do
        wait(0.1)
        if clicking then
            VirtualUser:Button1Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
            wait(0.05)
            VirtualUser:Button1Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        end
    end
end)

function FlyToBackOfTarget(target)
    local speed = 150
    local distanceBehind = 10 -- ปรับระยะห่างตรงนี้
    local backOffset = -target.CFrame.LookVector * distanceBehind
    local finalPos = target.Position + backOffset
    local direction = (finalPos - humanoidRootPart.Position).Unit
    local distance = (finalPos - humanoidRootPart.Position).Magnitude
    local travelTime = distance / speed

    local startTime = tick()
    while tick() - startTime < travelTime and walking do
        humanoidRootPart.CFrame = CFrame.new(humanoidRootPart.Position + direction * speed * RunService.Heartbeat:Wait())
    end

    while target.Parent ~= nil and walking do
        local backPos = target.Position - (target.CFrame.LookVector * distanceBehind)
        local humanoid = character:FindFirstChildOfClass("Humanoid")
	if humanoid then
      		humanoid:MoveTo(backPos)
	end

        RunService.Heartbeat:Wait()
    end
end

function FlyAndAttack()
    walking = true
    clicking = true
    character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
    humanoidRootPart = character:WaitForChild("HumanoidRootPart")

    for _, v in pairs(workspace.Enemy.Mob:GetChildren()) do
        if v:FindFirstChild("HumanoidRootPart") then
            FlyToBackOfTarget(v.HumanoidRootPart)
        end
    end

    walking = false
    clicking = false
end

-- ---------------------------------------
-- ✅ Auto Farm Settings (แทน Aimbot)
-- ---------------------------------------
local serv = win:Server("Auto Farm Settings", "")

local autoFarmSection = serv:Channel("Auto Farm")

local AutoFarmEnabled = false
local AutoFarmThread = nil

autoFarmSection:Toggle("Enable Auto Farm", false, function(state)
    AutoFarmEnabled = state
    if AutoFarmEnabled then
        print("Auto Farm Enabled")
        AutoFarmThread = spawn(function()
            while AutoFarmEnabled do
                FlyAndAttack()
                wait(1) -- เว้นช่วงก่อนเริ่มรอบใหม่
            end
        end)
    else
        print("Auto Farm Disabled")
        walking = false
        clicking = false
        if AutoFarmThread then
            coroutine.close(AutoFarmThread)
            AutoFarmThread = nil
        end
    end
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
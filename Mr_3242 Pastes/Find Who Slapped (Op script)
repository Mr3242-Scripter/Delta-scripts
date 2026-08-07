-- Fixing the script right now 



local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer

------------------------------------------------
-- UI LIBRARY
------------------------------------------------
local UI = loadstring(game:HttpGet(
    "https://pastebin.com/raw/4NHU7v35",
    true
))()

local Window = UI:CreateWindow("Find Who Slapped")

------------------------------------------------
-- STATE
------------------------------------------------
local AutoDodge = false
local NotifyEnabled = false
local DodgeLoop = false
local Showing = false

------------------------------------------------
-- REMOTES (your own game)
------------------------------------------------
local Events = ReplicatedStorage:WaitForChild("Events")
local DodgeRemote = Events:WaitForChild("Dodge")
local HitRemote = Events:WaitForChild("Hit")

------------------------------------------------
-- TOGGLES (NOW RELIABLE)
------------------------------------------------

------------------------------------------------
-- HIT BUTTON
------------------------------------------------

Window:AddButton({
    text = "Perfect Hit",
    callback = function()
        HitRemote:FireServer(0.9)
    end
})

Window:AddToggle({
    text = "Auto Dodge",
    state = false,
    callback = function(v)
        AutoDodge = v
        DodgeLoop = v
    end
})

Window:AddToggle({
    text = "Notify Who Slapped You",
    state = false,
    callback = function(v)
        NotifyEnabled = v
    end
})

------------------------------------------------
-- AUTO DODGE LOOP
------------------------------------------------
task.spawn(function()
    local keys = {
        "A","B","C","D","E","F","G","H","I","J",
        "K","L","M","N","O","P","Q","R","S","T",
        "U","V","W","X","Y","Z"
    }

    local i = 1

    while true do
        task.wait()

        if DodgeLoop then
            DodgeRemote:FireServer(keys[i])

            i += 1
            if i > #keys then
                i = 1
            end
        end
    end
end)

------------------------------------------------
-- NOTIFICATION GUI
------------------------------------------------
local Gui = Instance.new("ScreenGui")
Gui.Name = "HitNotifyGui"
Gui.ResetOnSpawn = false
Gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 460, 0, 70)
Frame.Position = UDim2.new(0.5, 0, 0.18, -100)
Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.BackgroundTransparency = 0.15
Frame.Visible = false
Frame.Parent = Gui

Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 14)

local Avatar = Instance.new("ImageLabel")
Avatar.Size = UDim2.new(0, 52, 0, 52)
Avatar.Position = UDim2.new(0, 10, 0.5, 0)
Avatar.AnchorPoint = Vector2.new(0, 0.5)
Avatar.BackgroundTransparency = 1
Avatar.Parent = Frame

Instance.new("UICorner", Avatar).CornerRadius = UDim.new(1, 0)

local Text = Instance.new("TextLabel")
Text.Size = UDim2.new(1, -80, 1, 0)
Text.Position = UDim2.new(0, 72, 0, 0)
Text.BackgroundTransparency = 1
Text.TextColor3 = Color3.fromRGB(255, 80, 80)
Text.Font = Enum.Font.GothamBold
Text.TextScaled = true
Text.TextXAlignment = Enum.TextXAlignment.Left
Text.Parent = Frame

------------------------------------------------
-- SHOW NOTIFICATION
------------------------------------------------
local function Show(attacker)
    if not NotifyEnabled then return end
    if Showing then return end

    Showing = true

    Text.Text = attacker.Name .. " slapped you!"

    Avatar.Image = Players:GetUserThumbnailAsync(
        attacker.UserId,
        Enum.ThumbnailType.HeadShot,
        Enum.ThumbnailSize.Size100x100
    )

    Frame.Visible = true

    TweenService:Create(Frame, TweenInfo.new(0.25), {
        Position = UDim2.new(0.5, 0, 0.18, 0)
    }):Play()

    task.wait(3)

    TweenService:Create(Frame, TweenInfo.new(0.25), {
        Position = UDim2.new(0.5, 0, 0.18, -100)
    }):Play()

    task.wait(0.25)

    Frame.Visible = false
    Showing = false
end

------------------------------------------------
-- DAMAGE DETECTION (CLOSEST PLAYER)
------------------------------------------------
local function Hook(char)
    local hum = char:WaitForChild("Humanoid")
    local root = char:WaitForChild("HumanoidRootPart")

    local last = hum.Health

    hum.HealthChanged:Connect(function(hp)
        if not NotifyEnabled then
            last = hp
            return
        end

        if hp < last then
            local closest, dist = nil, math.huge

            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local d = (p.Character.HumanoidRootPart.Position - root.Position).Magnitude
                    if d < dist then
                        dist = d
                        closest = p
                    end
                end
            end

            if closest then
                Show(closest)
            end
        end

        last = hp
    end)
end

if LocalPlayer.Character then
    Hook(LocalPlayer.Character)
end

LocalPlayer.CharacterAdded:Connect(Hook)

------------------------------------------------
-- LABEL
------------------------------------------------
Window:AddLabel({
    text = "TikTok: Mr_3242"
})

UI:Init()
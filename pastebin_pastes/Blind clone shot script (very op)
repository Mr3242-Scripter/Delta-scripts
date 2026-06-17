--// SERVICES
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

--// PLAYER
local LocalPlayer = Players.LocalPlayer

--// CLEAN RE-EXECUTE
if getgenv().TrainingUnload then
    pcall(getgenv().TrainingUnload)
end

--// REMOTES
local TrainingRemotes = ReplicatedStorage:WaitForChild("TrainingRemotes")
local HitTarget = TrainingRemotes:WaitForChild("HitTarget")
local StartTraining = TrainingRemotes:WaitForChild("StartTraining")
local StopTraining = TrainingRemotes:WaitForChild("StopTraining")

--// LOAD RAYFIELD
local Rayfield
repeat
    local s,r = pcall(function()
        return loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
    end)
    if s and r then Rayfield = r else task.wait(2) end
until Rayfield

--// FILTER NOTIFICATIONS
local oldNotify = Rayfield.Notify
Rayfield.Notify = function(self, data)
    if data and data.Title then
        local t = tostring(data.Title)
        if t:find("Rayfield") or t:find("Interface") then return end
    end
    return oldNotify(self, data)
end

--// CUSTOM NOTIFY
local function Notify(t,c)
    Rayfield:Notify({
        Title = t,
        Content = c,
        Duration = 3,
        Image = 4483362458
    })
end

--// WINDOW
local Window = Rayfield:CreateWindow({
    Name = "Blind clone shot",
    LoadingTitle = "easy money",
    LoadingSubtitle = "Follow me on TikTok Mr_3242",
    ConfigurationSaving = {Enabled = false},
    KeySystem = false
})

--// TABS
local MainTab = Window:CreateTab("Cheats", 4483362458)
local CreditsTab = Window:CreateTab("Credits", 4483362458)
local UnloadTab = Window:CreateTab("Unload", 4483362458)

------------------------------------------------
-- STATE
------------------------------------------------
local training = false
local auto = false
local delayTime = 0
local hitConnection
local inputConn
local running = true
local lastHit = 0

------------------------------------------------
-- FUNCTIONS
------------------------------------------------
local function hit()
    if training and running then
        HitTarget:FireServer()
    end
end

local function startTraining()
    if training then return end
    training = true
    StartTraining:FireServer()
   
end

local function stopTraining()
    training = false
    auto = false
    StopTraining:FireServer()

    if inputConn then
        inputConn:Disconnect()
        inputConn = nil
    end

    if hitConnection then
        hitConnection:Disconnect()
        hitConnection = nil
    end

   
end

local function bindInput()
    if inputConn then inputConn:Disconnect() end

    inputConn = UserInputService.InputBegan:Connect(function(input, gp)
        if gp or not training then return end

        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            hit()
        end
    end)
end

------------------------------------------------
-- AUTO HIT
------------------------------------------------

local burstAmount = 20

local function startAuto()
    if hitConnection then return end

    lastHit = os.clock()

    hitConnection = RunService.Heartbeat:Connect(function()
        if not auto or not training or not running then return end

        if delayTime <= 0 then
           
            for i = 1, burstAmount do
                hit()
            end
        else
            if os.clock() - lastHit >= delayTime then
                lastHit = os.clock()

              
                for i = 1, burstAmount do
                    hit()
                end
            end
        end
    end)
end

local function stopAuto()
    auto = false
    lastHit = 0

    if hitConnection then
        hitConnection:Disconnect()
        hitConnection = nil
    end
end

------------------------------------------------
-- TELEPORT
------------------------------------------------
local function teleport()
    local char = LocalPlayer.Character
    if not char then return end

    local root = char:FindFirstChild("HumanoidRootPart")
    if root then
        root.CFrame = CFrame.new(150, 22, -141)
       
    end
end

------------------------------------------------
-- UI
------------------------------------------------
MainTab:CreateButton({
    Name = "Start Training",
    Callback = function()
        startTraining()
        bindInput()
    end
})

MainTab:CreateButton({
    Name = "Stop Training",
    Callback = function()
        stopTraining()
    end
})

MainTab:CreateButton({
    Name = "Manual Hit",
    Callback = hit
})

MainTab:CreateButton({
    Name = "Teleport to Lobby",
    Callback = teleport
})

MainTab:CreateSlider({
    Name = "Auto Hit Delay",
    Range = {0,1},
    Increment = 0.01,
    CurrentValue = 0,
    Callback = function(v)
        delayTime = v
    end
})

MainTab:CreateToggle({
    Name = "Auto Hit",
    CurrentValue = false,
    Callback = function(v)
        auto = v
        if v then
            startAuto()
        else
            stopAuto()
        end
    end
})

------------------------------------------------
-- CREDITS
------------------------------------------------
CreditsTab:CreateParagraph({
    Title = "Credits",
    Content = "Script created by Mr_3242\nThanks for using the script!"
})

CreditsTab:CreateButton({
    Name = "Copy TikTok Link",
    Callback = function()
        setclipboard("https://www.tiktok.com/@Mr_3242")
        Notify("Copied","TikTok link copied")
    end
})

CreditsTab:CreateButton({
    Name = "Copy YouTube Link",
    Callback = function()
        setclipboard("https://www.youtube.com/@Mr_3242.")
        Notify("Copied","YouTube link copied")
    end
})

CreditsTab:CreateButton({
    Name = "Copy Twitch Link",
    Callback = function()
        setclipboard("https://m.twitch.tv/quantumx_42/home")
        Notify("Copied","Twitch link copied")
    end
})

------------------------------------------------
-- UNLOAD
------------------------------------------------
getgenv().TrainingUnload = function()
    running = false

    stopAuto()
    stopTraining()

    pcall(function()
        Rayfield:Destroy()
    end)

    getgenv().TrainingUnload = nil
end

UnloadTab:CreateButton({
    Name = "Unload Script",
    Callback = function()
        getgenv().TrainingUnload()
    end
})

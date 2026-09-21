--------------------------------------------------
-- CLEAN RE-EXECUTE
--------------------------------------------------
if getgenv().AutoFarmUnload then
    pcall(getgenv().AutoFarmUnload)
end

--------------------------------------------------
-- LOAD RAYFIELD
--------------------------------------------------
local Rayfield

repeat
    local s,r = pcall(function()
        return loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
    end)

    if s and r then
        Rayfield = r
    else
        task.wait(0.5)
    end
until Rayfield

--------------------------------------------------
-- FILTER NOTIFICATIONS
--------------------------------------------------
local oldNotify = Rayfield.Notify

Rayfield.Notify = function(self,data)
    if data and data.Title then
        local t = tostring(data.Title)

        if t:find("Rayfield") or t:find("Interface") then
            return
        end
    end

    return oldNotify(self,data)
end

--------------------------------------------------
-- NOTIFY
--------------------------------------------------
local function Notify(t,c)
    Rayfield:Notify({
        Title=t,
        Content=c,
        Duration=3,
        Image=4483362458
    })
end

--------------------------------------------------
-- WINDOW
--------------------------------------------------
local Window = Rayfield:CreateWindow({
    Name = "RNG Fights",
    LoadingTitle = "auto farm + auto roll",
    LoadingSubtitle = "follow me on TikTok Mr_3242",
    ConfigurationSaving = { Enabled = false },
    KeySystem = false
})

local Tab = Window:CreateTab("Main",4483362458)
local CreditsTab = Window:CreateTab("Credits",4483362458)
local UnloadTab = Window:CreateTab("Unload",4483362458)

local Status = Tab:CreateLabel("Status: Idle")

--------------------------------------------------
-- SERVICES
--------------------------------------------------
local Players = game:GetService("Players")
local Rep = game:GetService("ReplicatedStorage")
local VIM = game:GetService("VirtualInputManager")

local player = Players.LocalPlayer

local events = Rep:WaitForChild("EventsFolder")
local attacksFolder = Rep:WaitForChild("AttacksFolder")

local rollRemote = events:WaitForChild("GenerateAttack")
local updateRemote = events:WaitForChild("UpdateAttack")

local teleporter = workspace.Game.Lobby.Teleporter

--------------------------------------------------
-- STATE
--------------------------------------------------
local AutoRoll = false
local AutoFarm = false
local Rolling = false
local StopAfterAbility = nil
local currentAttack = nil
local running = true

_G.SkipArenaPhase = false

--------------------------------------------------
-- TRACK ATTACK
--------------------------------------------------
updateRemote.OnClientEvent:Connect(function(name)
    currentAttack = name
end)

--------------------------------------------------
-- AUTO ROLL
--------------------------------------------------
local function startAutoRoll()
    task.spawn(function()
        while AutoRoll and running do
            task.wait()

            rollRemote:FireServer("Random")

            if StopAfterAbility and currentAttack == StopAfterAbility then
                AutoRoll = false
                Rolling = false
                Status:Set("Stopped at "..StopAfterAbility)
            end
        end
    end)
end

--------------------------------------------------
-- WAIT FOR TELEPORT
--------------------------------------------------

local function waitForTeleport(hrp)
    local start = hrp.Position

    for i = 1, 50 do
        task.wait(0.1)

        if _G.SkipArenaPhase then
            _G.SkipArenaPhase = false
            return true
        end

        if (hrp.Position - start).Magnitude > 50 then
            return true
        end
    end

    return false
end

--------------------------------------------------
-- TARGET SYSTEM
--------------------------------------------------
local function getTarget(hrp)
    local best, dist = nil, math.huge

    for _,plr in pairs(Players:GetPlayers()) do
        if plr ~= player and plr.Character then

            local hum = plr.Character:FindFirstChild("Humanoid")
            local hrp2 = plr.Character:FindFirstChild("HumanoidRootPart")

            if hum and hrp2 and hum.Health > 0 then

                local yDifference = hrp2.Position.Y - hrp.Position.Y

                if yDifference <= 30 then
                    local d = (hrp.Position - hrp2.Position).Magnitude

                    if d < dist then
                        dist = d
                        best = plr
                    end
                end
            end
        end
    end

    return best
end

--------------------------------------------------
-- AUTO FARM
--------------------------------------------------
local function startAutoFarm()
    task.spawn(function()

        while AutoFarm and running do

            local char = player.Character or player.CharacterAdded:Wait()
            local hum = char:WaitForChild("Humanoid")
            local hrp = char:WaitForChild("HumanoidRootPart")

            Status:Set("Going to teleporter...")

            --------------------------------------------------
            -- TELEPORTER CHECK
            --------------------------------------------------
            local teleporterYDifference = teleporter.Position.Y - hrp.Position.Y

            if teleporterYDifference >= 30 then
                _G.SkipArenaPhase = true
                Status:Set("Skipping teleporter (too high)")
            else

                _G.SkipArenaPhase = false

                pcall(function()
                    hum:MoveTo(teleporter.Position)
                end)

                local success = waitForTeleport(hrp)

                pcall(function()
                    hum:Move(Vector3.zero)
                end)

                if not success then
                    task.wait(1)
                    continue
                end
            end

            --------------------------------------------------
            -- ARENA PHASE
            --------------------------------------------------
            Status:Set("Arena ⚔️")

            while AutoFarm and hum.Health > 0 and running do
                task.wait(0.1)

                if hum.Sit then
                    hum.Sit = false
                    hum:ChangeState(Enum.HumanoidStateType.Jumping)
                end

                rollRemote:FireServer("Random")

                if StopAfterAbility and currentAttack == StopAfterAbility then
                    AutoRoll = false
                    Rolling = false
                    Status:Set("Stopped at "..StopAfterAbility)
                end

                local target = getTarget(hrp)

                if target then
                    local enemyHRP = target.Character:FindFirstChild("HumanoidRootPart")
                    if enemyHRP then
                        hum:MoveTo(enemyHRP.Position)
                    end
                end

                if currentAttack then
                    for _,tool in pairs(player.Backpack:GetChildren()) do
                        if tool.Name == currentAttack then
                            tool.Parent = char
                        end
                    end
                end

                VIM:SendMouseButtonEvent(0,0,0,true,game,0)
                VIM:SendMouseButtonEvent(0,0,0,false,game,0)

                VIM:SendKeyEvent(true,Enum.KeyCode.Q,false,game)
                VIM:SendKeyEvent(false,Enum.KeyCode.Q,false,game)
            end

            Status:Set("Respawning...")

            repeat task.wait()
            until player.Character
            and player.Character:FindFirstChild("Humanoid")
            and player.Character.Humanoid.Health > 0

            Status:Set("Restarting...")
            task.wait(1)
        end
    end)
end

--------------------------------------------------
-- ABILITIES
--------------------------------------------------
local abilities = {}

for _,v in pairs(attacksFolder:GetChildren()) do
    if v:IsA("Folder") and v.Name ~= "Admin" then
        if v:FindFirstChild("Tool") then
            table.insert(abilities,v.Name)
        end
    end
end

--------------------------------------------------
-- UI
--------------------------------------------------
Tab:CreateToggle({
    Name = "Auto Farm (semi functional)",
    CurrentValue = false,
    Callback = function(v)
        AutoFarm = v
        if v then startAutoFarm() end
    end
})

Tab:CreateToggle({
    Name = "Auto Roll",
    CurrentValue = false,
    Callback = function(v)
        AutoRoll = v
        Rolling = v
        if v then startAutoRoll() end
    end
})

Tab:CreateDropdown({
    Name = "Stop Roll At Ability",
    Options = abilities,
    Callback = function(opt)
        StopAfterAbility = opt
    end
})

Tab:CreateParagraph({
    Title = "⚠️ use if auto farm broke ⚠️",
    Content = "Teleporter phase will be skipped if you click the button under this note"
})

Tab:CreateButton({
    Name = "Skip To Arena Phase",
    Callback = function()
        _G.SkipArenaPhase = true
        Status:Set("Arena ⚔️")
    end
})

--------------------------------------------------
-- CREDITS
--------------------------------------------------
CreditsTab:CreateParagraph({
    Title="Credits",
    Content="Script created by Mr_3242\nThanks for using the script!"
})

CreditsTab:CreateButton({
    Name="Copy TikTok Link",
    Callback=function()
        setclipboard("https://www.tiktok.com/@Mr_3242")
        Notify("Copied","TikTok link copied")
    end
})

CreditsTab:CreateButton({
    Name="Copy YouTube Link",
    Callback=function()
        setclipboard("https://www.youtube.com/@Mr_3242.")
        Notify("Copied","YouTube link copied")
    end
})

CreditsTab:CreateButton({
    Name="Copy Twitch Link",
    Callback=function()
        setclipboard("https://m.twitch.tv/quantumx_42/home")
        Notify("Copied","Twitch link copied")
    end
})

--------------------------------------------------
-- UNLOAD
--------------------------------------------------
getgenv().AutoFarmUnload = function()
    running = false
    AutoFarm = false
    AutoRoll = false
    Rolling = false

    pcall(function()
        Rayfield:Destroy()
    end)

    getgenv().AutoFarmUnload = nil
end

UnloadTab:CreateButton({
    Name = "Unload Script",
    Callback = function()
        getgenv().AutoFarmUnload()
    end
})
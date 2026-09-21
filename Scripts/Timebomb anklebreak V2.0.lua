repeat task.wait() until game:IsLoaded()

if _G.TimebombLoaded then
    if _G.TimebombUnload then
        pcall(_G.TimebombUnload)
    end
end
_G.TimebombLoaded = true

local SCRIPT_URL = "https://pastebin.com/raw/8BKFxAPu"

local queue =
    queue_on_teleport or
    (syn and syn.queue_on_teleport) or
    (fluxus and fluxus.queue_on_teleport)

if queue then
    queue([[
        repeat task.wait() until game:IsLoaded()
        task.wait(1)

        if _G.TimebombUnload then
            pcall(_G.TimebombUnload)
        end

        local success, err = pcall(function()
            loadstring(game:HttpGet("]]..SCRIPT_URL..[["))()
        end)

        if not success then
            warn("Teleport load failed:", err)
        end
    ]])
end

--// SERVICES
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

--// CONTROL
local ScriptRunning = true

--// SETTINGS
local HitboxEnabled = false
local HitboxSize = 5
local HitboxTransparency = 0.5
local IgnoreFriends = false

local AutoAnkle = false
local Radius = 12
local InfiniteRadius = false

local FlickAngle = 75
local FlickDelay = 0.18

local TargetHitboxEnabled = false
local TargetPlayerName = ""

-- WALK SPEED
local Humanoid
local WalkSpeedEnabled = false
local WalkSpeedValue = 16
local OriginalWalkSpeed = 16
local WalkSpeedConnection

--// GLOBAL UNLOAD
_G.TimebombUnload = function()
    ScriptRunning = false

    HitboxEnabled = false
    AutoAnkle = false
    TargetHitboxEnabled = false
    WalkSpeedEnabled = false

    pcall(function()
        if WalkSpeedConnection then
            WalkSpeedConnection:Disconnect()
        end
    end)

    pcall(function()
        if Humanoid then
            Humanoid.WalkSpeed = OriginalWalkSpeed or 16
        end
    end)

    -- reset hitboxes
    pcall(function()
        for _,p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer then
                local c = p.Character
                if c and c:FindFirstChild("HumanoidRootPart") then
                    local h = c.HumanoidRootPart
                    h.Size = Vector3.new(2,2,1)
                    h.Transparency = 1
                    h.Material = Enum.Material.Plastic
                    h.CanCollide = true
                end
            end
        end
    end)

    pcall(function()
        if Rayfield then
            Rayfield:Destroy()
        end
    end)
end

--// LOAD RAYFIELD (RETRY)
local Rayfield
repeat
    local success, result = pcall(function()
        return loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
    end)
    if success and result then
        Rayfield = result
    else
        task.wait(1)
    end
until Rayfield

--// NOTIFICATIONS
local OriginalNotify = Rayfield.Notify

Rayfield.Notify = function(self,data)
    if data and data.Title then
        local title = tostring(data.Title)
        if title:find("Interface") or title:find("Rayfield") then
            return
        end
    end
    return OriginalNotify(self,data)
end

local function Notify(title,text)
    Rayfield:Notify({
        Title = title,
        Content = text,
        Duration = 3,
        Image = 4483362458
    })
end

--// WINDOW
local Window = Rayfield:CreateWindow({
    Name = "Timebomb AnkleBreak V2.0",
    LoadingTitle = "Client Cheats",
    LoadingSubtitle = "Follow me on TikTok Mr_3242",
    ConfigurationSaving = {Enabled = false}
})

--------------------------------------------------
-- TABS
--------------------------------------------------

local CheatsTab = Window:CreateTab("Cheats",4483362458)
local CreditsTab = Window:CreateTab("Credits",4483362458)
local UnloadTab = Window:CreateTab("Unload",4483362458)

--------------------------------------------------
-- WALK SPEED SYSTEM
--------------------------------------------------

local function SetupCharacter(char)

    Humanoid = char:WaitForChild("Humanoid")
    OriginalWalkSpeed = Humanoid.WalkSpeed

    if WalkSpeedEnabled then
        Humanoid.WalkSpeed = WalkSpeedValue
    end

    if WalkSpeedConnection then
        WalkSpeedConnection:Disconnect()
    end

    WalkSpeedConnection =
        Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()

            if WalkSpeedEnabled and Humanoid.WalkSpeed ~= WalkSpeedValue then
                Humanoid.WalkSpeed = WalkSpeedValue
            end

        end)

end

if LocalPlayer.Character then
    SetupCharacter(LocalPlayer.Character)
end

LocalPlayer.CharacterAdded:Connect(SetupCharacter)

--------------------------------------------------
-- FUNCTIONS
--------------------------------------------------

local function hasBomb()
    local char = LocalPlayer.Character
    if not char then return false end
    return char:FindFirstChild("TimeBomb") ~= nil
end

local function getNearest()

    local char = LocalPlayer.Character
    if not char then return nil end

    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end

    local closest = nil
    local closestDist = math.huge

    for _,p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then

            local c = p.Character

            if c and c:FindFirstChild("HumanoidRootPart") then

                local dist =
                    (c.HumanoidRootPart.Position - hrp.Position).Magnitude

                if InfiniteRadius then

                    if dist < closestDist then
                        closestDist = dist
                        closest = c
                    end

                else

                    if dist <= Radius and dist < closestDist then
                        closestDist = dist
                        closest = c
                    end

                end

            end
        end
    end

    return closest
end

local function getPlayerFromPartial(name)

    name = string.lower(name)

    for _,player in pairs(Players:GetPlayers()) do
        if string.sub(string.lower(player.Name),1,#name) == name then
            return player
        end
    end

    return nil
end

--------------------------------------------------
-- UI
--------------------------------------------------

CheatsTab:CreateParagraph({Title="Universal",Content=""})

CheatsTab:CreateSlider({
    Name="WalkSpeed Slider",Range={16,30},Increment=1,Suffix="Speed",CurrentValue=16,
    Callback=function(value)
        WalkSpeedValue=value
        if WalkSpeedEnabled and Humanoid then
            Humanoid.WalkSpeed=value
        end
    end
})

CheatsTab:CreateToggle({
    Name="Enable WalkSpeed",CurrentValue=false,
    Callback=function(state)
        WalkSpeedEnabled=state
        if Humanoid then
            if state then
                Humanoid.WalkSpeed=WalkSpeedValue
            else
                Humanoid.WalkSpeed=OriginalWalkSpeed
            end
        end
    end
})

--------------------------------------------------
-- GAME RELATED CHEATS
--------------------------------------------------

CheatsTab:CreateParagraph({Title="Game Related Cheats",Content=""})

CheatsTab:CreateToggle({
    Name="Hitbox Extender",CurrentValue=false,
    Callback=function(v) HitboxEnabled=v end
})

CheatsTab:CreateToggle({
    Name="Ignore Friends (Hitbox)",CurrentValue=false,
    Callback=function(v) IgnoreFriends=v end
})

CheatsTab:CreateSlider({
    Name="Hitbox Size",Range={2,27},Increment=1,CurrentValue=5,Suffix="Studs",
    Callback=function(v) HitboxSize=v end
})

CheatsTab:CreateInput({
    Name="Hitbox Transparency",PlaceholderText="0-1",
    Callback=function(t)
        local n=tonumber(t)
        if n then HitboxTransparency=math.clamp(n,0,1) end
    end
})

--------------------------------------------------
-- AUTO ANKLEBREAK
--------------------------------------------------

CheatsTab:CreateParagraph({
    Title="Anklebreak Info",
    Content="Range above 12 will not work.\nHitbox sizes above 27 studs won’t work."
})

CheatsTab:CreateToggle({
    Name="Auto Anklebreak",CurrentValue=false,
    Callback=function(v) AutoAnkle=v end
})

CheatsTab:CreateSlider({
    Name="Anklebreak Range (Useless)",Range={1,12},Increment=1,CurrentValue=12,Suffix="Studs",
    Callback=function(v) Radius=v end
})

CheatsTab:CreateToggle({
    Name="Infinite Range (Useless)",CurrentValue=false,
    Callback=function(v) InfiniteRadius=v end
})

--------------------------------------------------
-- TARGET PLAYER HITBOX
--------------------------------------------------

CheatsTab:CreateToggle({
    Name="Target Player Hitbox",CurrentValue=false,
    Callback=function(v) TargetHitboxEnabled=v end
})

CheatsTab:CreateInput({
    Name="Target Player (Hitbox)",PlaceholderText="Enter username",
    Callback=function(text)
        local player=getPlayerFromPartial(text)
        if player then
            TargetPlayerName=player.Name
            Notify("Target Selected",player.Name.." locked as target")
        else
            TargetPlayerName=text
        end
    end
})

--------------------------------------------------
-- HITBOX LOOP
--------------------------------------------------

task.spawn(function()
    while ScriptRunning and task.wait(0.05) do
        for _,p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer then
                local c=p.Character
                if c and c:FindFirstChild("HumanoidRootPart") then
                    local h=c.HumanoidRootPart
                    local isFriend=LocalPlayer:IsFriendsWith(p.UserId)

                    if TargetHitboxEnabled then
                        if p.Name==TargetPlayerName then
                            h.Size=Vector3.new(HitboxSize,HitboxSize,HitboxSize)
                            h.Transparency=HitboxTransparency
                            h.Material=Enum.Material.Neon
                            h.CanCollide=false
                        else
                            h.Size=Vector3.new(2,2,1)
                            h.Transparency=1
                            h.Material=Enum.Material.Plastic
                            h.CanCollide=true
                        end

                    elseif HitboxEnabled then
                        if IgnoreFriends and isFriend then
                            h.Size=Vector3.new(2,2,1)
                            h.Transparency=1
                            h.Material=Enum.Material.Plastic
                            h.CanCollide=true
                        else
                            h.Size=Vector3.new(HitboxSize,HitboxSize,HitboxSize)
                            h.Transparency=HitboxTransparency
                            h.Material=Enum.Material.Neon
                            h.CanCollide=false
                        end

                    else
                        h.Size=Vector3.new(2,2,1)
                        h.Transparency=1
                        h.Material=Enum.Material.Plastic
                        h.CanCollide=true
                    end
                end
            end
        end
    end
end)

--------------------------------------------------
-- AUTO ANKLEBREAK LOOP
--------------------------------------------------

task.spawn(function()
    local dir=1
    while ScriptRunning and task.wait(FlickDelay) do
        if AutoAnkle and hasBomb() then
            local char=LocalPlayer.Character
            if not char then continue end
            local hrp=char:FindFirstChild("HumanoidRootPart")
            if not hrp then continue end
            local target=getNearest()
            if target then
                local targetHRP=target:FindFirstChild("HumanoidRootPart")
                if targetHRP then
                    hrp.CFrame=CFrame.lookAt(hrp.Position,targetHRP.Position)
                    hrp.CFrame=hrp.CFrame*CFrame.Angles(0,math.rad(FlickAngle*dir),0)
                    dir=-dir
                end
            end
        end
    end
end)

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
        Notify("Link Copied","TikTok link copied to clipboard")
    end
})

CreditsTab:CreateButton({
    Name="Copy YouTube Link",
    Callback=function()
        setclipboard("https://www.youtube.com/@Mr_3242")
        Notify("Link Copied","YouTube link copied to clipboard")
    end
})

CreditsTab:CreateButton({
    Name="Copy Twitch Link",
    Callback=function()
        setclipboard("https://m.twitch.tv/quantumx_42/home")
        Notify("Link Copied","Twitch link copied to clipboard")
    end
})

--------------------------------------------------
-- UNLOAD
--------------------------------------------------

UnloadTab:CreateButton({
    Name="Unload Script",
    Callback=function()
        Notify("Unloading","Stopping all scripts...")

        -- Stop the main script
        if _G.TimebombUnload then
            pcall(_G.TimebombUnload)
        end

        -- Destroy the Rayfield GUI completely
        pcall(function()
            if Rayfield then
                Rayfield:Destroy()
                Rayfield = nil
            end

            local CoreGui = game:GetService("CoreGui")
            for _,v in pairs(CoreGui:GetChildren()) do
                if v.Name:lower():find("rayfield") then
                    v:Destroy()
                end
            end
        end)

        -- Stop all loops safely
        ScriptRunning = false
        WalkSpeedEnabled = false
        HitboxEnabled = false
        AutoAnkle = false
        TargetHitboxEnabled = false

        -- Reset Humanoid WalkSpeed
        if Humanoid then
            Humanoid.WalkSpeed = OriginalWalkSpeed or 16
        end

        -- Mark script as unloaded
        _G.TimebombLoaded = false
        _G.TimebombUnload = nil
    end
})
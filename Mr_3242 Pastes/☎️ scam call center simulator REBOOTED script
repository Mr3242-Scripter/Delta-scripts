-- ===== Load Rayfield =====
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "☎️ scam call center simulator REBOOTED",
    LoadingTitle = "Free Money",
    LoadingSubtitle = "follow me on TikTok Mr_3242",
    ConfigurationSaving = { Enabled = false }
})

-- ===== Notification Filter =====
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

--// CLEAN RE-EXECUTE
if getgenv().AutoFarmUnload then
    pcall(getgenv().AutoFarmUnload)
end

-- ===== Tabs =====
local CheatsTab = Window:CreateTab("Cheats", 4483362458)
local CreditsTab = Window:CreateTab("Credits", 4483362458)
local UnloadTab = Window:CreateTab("Unload", 4483362458)

-- ===== Services =====
local player = game:GetService("Players").LocalPlayer
local rs = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")

-- ===== Auto get Bobux =====
local PhoneReward = rs:WaitForChild("PhoneReward")
local CallMade = rs:WaitForChild("CallMade")

local running = true
local rewardEnabled = false
local delayToWait = 0.5

CheatsTab:CreateToggle({
    Name = "Auto get Bobux",
    CurrentValue = false,
    Callback = function(v)
        rewardEnabled = v
    end
})

CheatsTab:CreateSlider({
    Name = "Delay to Wait",
    Range = {0,1},
    Increment = 0.05,
    CurrentValue = 0.5,
    Callback = function(v)
        delayToWait = v
    end
})

-- ===== ANTI LAG =====
local fpsConnection
local stored = {}
local antiLagEnabled = false

local function ApplyAntiLag(state)
    if state then
        stored = {}

        for _,v in pairs(game:GetDescendants()) do

            -- disable effects
            if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") or v:IsA("Fire") then
                stored[v] = {Enabled = v.Enabled}
                v.Enabled = false
            end

            if v:IsA("PostEffect") or v:IsA("Atmosphere") then
                stored[v] = {Enabled = v.Enabled}
                v.Enabled = false
            end

         
            if v:IsA("BasePart") then
                stored[v] = stored[v] or {}
                stored[v].Material = v.Material
                stored[v].Reflectance = v.Reflectance

                v.Material = Enum.Material.SmoothPlastic
                v.Reflectance = 0
            end

            -- textures (plants/details)
            if v:IsA("Decal") or v:IsA("Texture") then
                stored[v] = {Transparency = v.Transparency}
                v.Transparency = 1
            end
        end

        stored.Lighting = {
            GlobalShadows = Lighting.GlobalShadows,
            FogEnd = Lighting.FogEnd,
            Brightness = Lighting.Brightness
        }

        Lighting.GlobalShadows = false
        Lighting.FogEnd = 1e10
        Lighting.Brightness = 1

        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01

        fpsConnection = game.DescendantAdded:Connect(function(v)
            if v:IsA("ParticleEmitter") or v:IsA("Trail") then
                v.Enabled = false
            end
            if v:IsA("Decal") or v:IsA("Texture") then
                v.Transparency = 1
            end
            if v:IsA("BasePart") then
                v.Material = Enum.Material.SmoothPlastic
            end
        end)

    else
        for obj,data in pairs(stored) do
            if typeof(obj) == "Instance" and obj then
                pcall(function()
                    for prop,val in pairs(data) do
                        obj[prop] = val
                    end
                end)
            end
        end

        if stored.Lighting then
            Lighting.GlobalShadows = stored.Lighting.GlobalShadows
            Lighting.FogEnd = stored.Lighting.FogEnd
            Lighting.Brightness = stored.Lighting.Brightness
        end

        settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic

        if fpsConnection then
            fpsConnection:Disconnect()
            fpsConnection = nil
        end

        stored = {}
    end
end

CheatsTab:CreateToggle({
    Name = "Anti Lag",
    CurrentValue = false,
    Callback = function(v)
        antiLagEnabled = v
        ApplyAntiLag(v)
    end
})

-- ===== Disable Elevator GUI Fade =====
local playerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
local cutsceneGui = playerGui:WaitForChild("Cutscene")

local removedFade = nil
local fadeDisabled = false
local fadeConnection = nil

local function getFade()
    return cutsceneGui:FindFirstChild("Fade")
end

local function disableFade()
    local fade = getFade()

    if fade and not removedFade then
        removedFade = fade:Clone()
        fade:Destroy()
    end
end

local function restoreFade()
    if removedFade and not getFade() then
        removedFade:Clone().Parent = cutsceneGui
    end
end

CheatsTab:CreateToggle({
    Name = "Disable Elevator GUI Fade",
    CurrentValue = false,
    Callback = function(v)
        fadeDisabled = v

        if v then
            disableFade()

            if fadeConnection then
                fadeConnection:Disconnect()
            end

            fadeConnection = cutsceneGui.ChildAdded:Connect(function(child)
                if child.Name == "Fade" then
                    task.wait()

                    if fadeDisabled and child.Parent then
                        child:Destroy()
                    end
                end
            end)

        else
            if fadeConnection then
                fadeConnection:Disconnect()
                fadeConnection = nil
            end

            restoreFade()
        end
    end
})

-- ===== MAIN LOOP =====
task.spawn(function()
    while running do
        task.wait(delayToWait)
        if rewardEnabled then
            PhoneReward:FireServer()
            CallMade:FireServer()
        end
    end
end)

-- ===== Credits =====
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

-- ===== UNLOAD BUTTON  =====
getgenv().AutoFarmUnload = function()

    -- stop loops
    running = false
    rewardEnabled = false

    -- anti lag restore
    if antiLagEnabled then
        ApplyAntiLag(false)
        antiLagEnabled = false
    end

    -- fade restore
    fadeDisabled = false

    if fadeConnection then
        fadeConnection:Disconnect()
        fadeConnection = nil
    end

    restoreFade()
    removedFade = nil

    -- destroy rayfield
    pcall(function()
        Rayfield:Destroy()
    end)

    -- kill leftover rayfield guis
    pcall(function()
        for _,v in pairs(game:GetService("CoreGui"):GetChildren()) do
            local n = v.Name:lower()
            if n:find("rayfield")
            or n:find("sirius")
            or n:find("notify")
            or n:find("interface") then
                v:Destroy()
            end
        end
    end)

    -- remove unload function
    getgenv().AutoFarmUnload = nil
end

UnloadTab:CreateButton({
    Name = "Unload Script",
    Callback = function()
        if getgenv().AutoFarmUnload then
            getgenv().AutoFarmUnload()
        end
    end
})
--// RAYFIELD
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

--// CLEAN RE-EXECUTE
if getgenv().FpsController then
    pcall(getgenv().FpsController)
end

--// FILTER RAYFIELD SYSTEM NOTIFICATIONS
local oldNotify = Rayfield.Notify

Rayfield.Notify = function(self, data)
    if data and data.Title then
        local t = tostring(data.Title)

        if t:find("Rayfield") or t:find("Interface") then
            return
        end
    end

    return oldNotify(self, data)
end

--// CUSTOM NOTIFICATION
local function Notify(title, content)
    Rayfield:Notify({
        Title = title,
        Content = content,
        Duration = 3,
        Image = 4483362458
    })
end

--// WINDOW
local Window = Rayfield:CreateWindow({
    Name = "FPS Limiter",
    LoadingTitle = "Loading..",
    LoadingSubtitle = "Follow me on TikTok Mr_3242",

    ConfigurationSaving = {
        Enabled = false
    },

    Discord = {
        Enabled = false
    },

    KeySystem = false
})

--// TABS
local FPSTab = Window:CreateTab("FPS", 4483362458)
local CreditsTab = Window:CreateTab("Credits", 4483362458)
local UnloadTab = Window:CreateTab("Unload", 4483362458)

--// STATE
local RunService = game:GetService("RunService")

local fpsLimit = 60
local limiterEnabled = false

local fpsConnection

--// =========================================================
--// FPS COUNTER
--// =========================================================

local frameTimes = {}
local totalTime = 0
local updateTimer = 0
local window = 1

local FPSLabel = FPSTab:CreateLabel("FPS: --")

fpsConnection = RunService.RenderStepped:Connect(function(dt)
    frameTimes[#frameTimes + 1] = dt
    totalTime += dt
    updateTimer += dt

    -- Keep the latest 1 second of frame timing
    if totalTime > window then
        local excess = totalTime - window

        while #frameTimes > 0 and excess >= frameTimes[1] do
            excess -= frameTimes[1]
            totalTime -= frameTimes[1]
            table.remove(frameTimes, 1)
        end

        if #frameTimes > 0 then
            totalTime -= excess
            frameTimes[1] -= excess
        end
    end

    -- Update display every 0.1 seconds
    if updateTimer >= 0.1 then
        if totalTime > 0 then
            local fps = #frameTimes / totalTime

            FPSLabel:Set(
                string.format("FPS: %.1f", fps)
            )
        end

        updateTimer = 0
    end
end)

--// =========================================================
--// FPS LIMITER
--// =========================================================

local function setFPSLimit(value)
    if setfpscap then
        setfpscap(value)
    end
end

--// =========================================================
--// FPS SLIDER
--// =========================================================

FPSTab:CreateSlider({
    Name = "FPS Limit",
    Range = {1, 3000},
    Increment = 1,
    Suffix = " FPS",
    CurrentValue = 240,
    Flag = "FPSLimit",

    Callback = function(Value)
        fpsLimit = Value

        if limiterEnabled then
            setFPSLimit(fpsLimit)
        end
    end
})

--// =========================================================
--// UNLOCK FPS
--// =========================================================

FPSTab:CreateButton({
    Name = "Unlock FPS",

    Callback = function()
        if setfpscap then
            setfpscap(9999)
        end
    end
})

--// =========================================================
--// FPS LIMITER TOGGLE
--// =========================================================

local FPSLimiterToggle

FPSLimiterToggle = FPSTab:CreateToggle({
    Name = "FPS Limiter",
    CurrentValue = false,
    Flag = "FPSLimiter",

    Callback = function(Value)
        limiterEnabled = Value

        if limiterEnabled then
            setFPSLimit(fpsLimit)
        end
    end
})

--// =========================================================
--// CREDITS
--// =========================================================

CreditsTab:CreateParagraph({
    Title = "Credits",
    Content = "Script created by Mr_3242\nThanks for using the script!"
})

CreditsTab:CreateButton({
    Name = "Copy TikTok Link",

    Callback = function()
        if setclipboard then
            setclipboard("https://www.tiktok.com/@Mr_3242")
            Notify("Copied", "TikTok link copied")
        end
    end
})

CreditsTab:CreateButton({
    Name = "Copy YouTube Link",

    Callback = function()
        if setclipboard then
            setclipboard("https://www.youtube.com/@Mr_3242.")
            Notify("Copied", "YouTube link copied")
        end
    end
})

CreditsTab:CreateButton({
    Name = "Copy Twitch Link",

    Callback = function()
        if setclipboard then
            setclipboard("https://m.twitch.tv/quantumx_42/home")
            Notify("Copied", "Twitch link copied")
        end
    end
})

--// =========================================================
--// UNLOAD FUNCTION
--// =========================================================

getgenv().FpsController = function()

    -- Disable the limiter state
    limiterEnabled = false

    -- Turn the Rayfield toggle off
    pcall(function()
        FPSLimiterToggle:Set(false)
    end)

    -- Remove the executor FPS cap
    pcall(function()
        if setfpscap then
            setfpscap(9999)
        end
    end)

    -- Stop FPS counter
    pcall(function()
        if fpsConnection then
            fpsConnection:Disconnect()
            fpsConnection = nil
        end
    end)

    -- Destroy Rayfield
    pcall(function()
        Rayfield:Destroy()
    end)

    -- Clean global
    getgenv().FpsController = nil
end

--// =========================================================
--// UNLOAD BUTTON
--// =========================================================

UnloadTab:CreateButton({
    Name = "Unload Script",

    Callback = function()
        if getgenv().FpsController then
            getgenv().FpsController()
        end
    end
})
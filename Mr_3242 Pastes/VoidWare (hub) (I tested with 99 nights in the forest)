-- ==================== LOAD RAYFIELD (protected) ====================
local success, Rayfield = pcall(function()
    return loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
end)

if not success or not Rayfield then
    warn("[Voidware Loader] Failed to load Rayfield")
    return
end

-- Reset all flags on re-execute
shared.VoidDev = false
shared.VapeDeveloper = false
shared.VoidwareNetworkingDebug = false

-- ==================== WINDOW ====================
local Window = Rayfield:CreateWindow({
    Name = "99 Nights in the forest",
    LoadingTitle = "Voidware Loader",
    LoadingSubtitle = "Follow me on TikTok Mr_3242",
    ConfigurationSaving = {
        Enabled = false
    },
    KeySystem = false
})

-- ==================== SAFE NOTIFY ====================
local function Notify(title, content)
    pcall(function()
        Rayfield:Notify({
            Title = title,
            Content = content,
            Duration = 3,
            Image = 4483362458
        })
    end)
end

-- ==================== CLEANUP (resets flags) ====================
local function Cleanup()
    shared.VoidDev = false
    shared.VapeDeveloper = false
    shared.VoidwareNetworkingDebug = false
end

-- ==================== UNLOAD SYSTEM ====================
-- First clean any previous instance
if getgenv().VoidwareUnload then
    pcall(getgenv().VoidwareUnload)
end

getgenv().VoidwareUnload = function()
    pcall(function()
        if Rayfield and Rayfield.Destroy then
            Rayfield:Destroy()
        end
    end)
    getgenv().VoidwareUnload = nil
end

-- ==================== SHARED LOAD FUNCTION ====================
local function LoadScript()
    local success, err = pcall(function()
        loadstring(game:HttpGet("https://files.vapevoidware.xyz/VapeVoidware/VW-Add/main/nightsintheforest2.lua", true))()
    end)
    if not success then
        warn("[Voidware Loader] Load failed:", err)
    end
end

-- ==================== VOIDWARE LOADERS ====================
local LoadersTab = Window:CreateTab("Voidware loaders", 4483362458)

-- Button 1
LoadersTab:CreateParagraph({
    Title = "Button 1 - What this button does",
    Content = "This loads the 99 Nights script with VoidDev and VapeDeveloper enabled. It turns on developer mode so you get extra debug information, but it does not enable the full networking debug spam."
})

LoadersTab:CreateButton({
    Name = "Load with VoidDev + VapeDeveloper",
    Callback = function()
        if getgenv().VoidwareUnload then
            pcall(getgenv().VoidwareUnload)
        end

        Cleanup()
        shared.VoidDev = true
        shared.VapeDeveloper = true
        LoadScript()
    end
})

-- Button 2
LoadersTab:CreateParagraph({
    Title = "Button 2 - What this button does",
    Content = "This is the same as the first button, but also enables VoidwareNetworkingDebug. You will see a lot more information printed in the console (F9 / Delta console). Use this when you want to see what the script is doing in detail."
})

LoadersTab:CreateButton({
    Name = "Load with Full Debug (Networking)",
    Callback = function()
        if getgenv().VoidwareUnload then
            pcall(getgenv().VoidwareUnload)
        end

        Cleanup()
        shared.VoidDev = true
        shared.VoidwareNetworkingDebug = true
        shared.VapeDeveloper = true
        LoadScript()
    end
})

-- Button 3
LoadersTab:CreateParagraph({
    Title = "Button 3 - What this button does",
    Content = "This loads the 99 Nights script completely normally. No VoidDev, no VapeDeveloper, and no networking debug."
})

LoadersTab:CreateButton({
    Name = "Normal Load (No Dev Flags)",
    Callback = function()
        if getgenv().VoidwareUnload then
            pcall(getgenv().VoidwareUnload)
        end

        Cleanup()
        LoadScript()
    end
})

-- ==================== CREDITS ====================
local CreditsTab = Window:CreateTab("Credits", 4483362458)

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
        else
            Notify("Error", "setclipboard not available")
        end
    end
})

CreditsTab:CreateButton({
    Name = "Copy YouTube Link",
    Callback = function()
        if setclipboard then
            setclipboard("https://www.youtube.com/@Mr_3242.")
            Notify("Copied", "YouTube link copied")
        else
            Notify("Error", "setclipboard not available")
        end
    end
})

CreditsTab:CreateButton({
    Name = "Copy Twitch Link",
    Callback = function()
        if setclipboard then
            setclipboard("https://m.twitch.tv/quantumx_42/home")
            Notify("Copied", "Twitch link copied")
        else
            Notify("Error", "setclipboard not available")
        end
    end
})

-- ==================== UNLOAD ====================
local UnloadTab = Window:CreateTab("Unload", 4483362458)

UnloadTab:CreateButton({
    Name = "Unload Script",
    Callback = function()
        if getgenv().VoidwareUnload then
            getgenv().VoidwareUnload()
        end
    end
})
--// CLEAN RE-EXECUTE
if getgenv().Mr_3242_Hub_Unload then
    pcall(getgenv().Mr_3242_Hub_Unload)
end

--// LOAD UI
local Rayfield

repeat
    local success = pcall(function()
        Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
    end)

    task.wait(0.2)
until Rayfield

--// WINDOW
local Window = Rayfield:CreateWindow({
    Name = "TSB Moveset",
    Icon = 0,
    LoadingTitle = "Ultimate TSB Hub",
    LoadingSubtitle = "by Mr_3242",
    ShowText = "Rayfield",
    Theme = "Default",

    ToggleUIKeybind = "K",

    DisableRayfieldPrompts = false,
    DisableBuildWarnings = false,

    ConfigurationSaving = {
        Enabled = false,
    },

    Discord = {
        Enabled = false,
    },

    KeySystem = false,
})

--// FILTER NOTIFICATIONS
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

--// NOTIFY FUNCTION
local function Notify(title, content)
    Rayfield:Notify({
        Title = title,
        Content = content,
        Duration = 3,
        Image = 4483362458
    })
end

--// TABS
local Tabs = {
    Saitama = Window:CreateTab("Saitama", 17761220730),
    Garou = Window:CreateTab("Garou", 17761389537),
    Genos = Window:CreateTab("Genos", 17761225602),
    Sonic = Window:CreateTab("Sonic", 17761227311),
    MetalBat = Window:CreateTab("Metal Bat", 17761394635),
    AtomicSamurai = Window:CreateTab("Atomic Samurai", 17761396556),

    Credits = Window:CreateTab("Credits", 4483362458),
    Unload = Window:CreateTab("Unload", 4483362458)
}

--////////////////////////////////////////////////////
--// SAITAMA
--////////////////////////////////////////////////////

Tabs.Saitama:CreateButton({
    Name = "Mafioso",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Lovelymoonlight/Lovelymoonlight/refs/heads/main/Baldy%20to%20mafioso"))()
    end,
})

Tabs.Saitama:CreateButton({
    Name = "Choi Jong",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/nil071n/fireman/refs/heads/main/TSB"))()
    end,
})

Tabs.Saitama:CreateButton({
    Name = "KuyJuy (Character Menu)",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/4ntrax7w7v9/4ntrax-Scripts/refs/heads/main/KKJ-Moveset"))()
    end,
})

Tabs.Saitama:CreateButton({
    Name = "Kratos",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/OmarW-Git-hub/Kratos-Remake/refs/heads/main/KratosByOmarLol.txt"))()
    end,
})

Tabs.Saitama:CreateButton({
    Name = "Unsealed Gojo",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/zF6Rdky0"))()
    end,
})

Tabs.Saitama:CreateButton({
    Name = "Sung Jin Woo",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/hamletirl/sunjingwoo/refs/heads/main/sunjingwoo"))()
    end,
})

Tabs.Saitama:CreateButton({
    Name = "Naruto",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/LolnotaKid/NarutoBeatUpSasukeAss/refs/heads/main/NarutoCums"))()
    end,
})

Tabs.Saitama:CreateButton({
    Name = "Mahito",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Kenjihin69/Kenjihin69/refs/heads/main/Mahitotsbupdate"))()
    end,
})

--////////////////////////////////////////////////////
--// GAROU
--////////////////////////////////////////////////////

Tabs.Garou:CreateButton({
    Name = "Cosmic Garou",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/3msBRQXy", true))()
    end,
})

Tabs.Garou:CreateButton({
    Name = "Kung Fu Panda",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/DqXUTANt"))()
    end,
})

Tabs.Garou:CreateButton({
    Name = "Jester",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Reapvitalized/TSB/refs/heads/main/ARCAURA.lua"))()
    end,
})

Tabs.Garou:CreateButton({
    Name = "John Doe",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Luckyfromyoutube/JohnDoe/refs/heads/main/TSBMODEL"))()
    end,
})

Tabs.Garou:CreateButton({
    Name = "Minos Prime",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/S1gmaGuy/MinosPrimeFixed/refs/heads/main/ThefixIsSoSigma"))()
    end,
})

--////////////////////////////////////////////////////
--// GENOS
--////////////////////////////////////////////////////

Tabs.Genos:CreateButton({
    Name = "Star Glitchers",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Reapvitalized/TSB/refs/heads/main/SG_DEMO.lua"))()
    end,
})

--////////////////////////////////////////////////////
--// SONIC
--////////////////////////////////////////////////////

Tabs.Sonic:CreateButton({
    Name = "Chainsaw Man",
    Callback = function()
        loadstring(game:HttpGet("https://gist.githubusercontent.com/GoldenHeads2/0fd8d36993c850f3fac89e5adf793076/raw/ab4f5a42bd0b2e24a32a46301d533ea849ca771c/gistfile1.txt"))()
    end,
})

Tabs.Sonic:CreateButton({
    Name = "1x1x1x1",
    Callback = function()
        loadstring(game:HttpGet("https://gist.githubusercontent.com/GoldenHeads2/900e87ffc32f3c740930ccb106dd6abf/raw/358c5bf0f0a6aa25946718288dab006e3ae7e1d4/gistfile1.txt"))()
    end,
})

--////////////////////////////////////////////////////
--// METAL BAT
--////////////////////////////////////////////////////

Tabs.MetalBat:CreateButton({
    Name = "Reaper",
    Callback = function()
        getgenv().Music = false

        loadstring(game:HttpGet("https://raw.githubusercontent.com/Reapvitalized/TSB/main/APOPHENIA.lua"))()
    end,
})

Tabs.MetalBat:CreateButton({
    Name = "Apophenia",
    Callback = function()
        getgenv().Music = false
        getgenv().AttackQuality = "Low"
        getgenv().ConstantSpeed = false

        loadstring(game:HttpGet("https://raw.githubusercontent.com/Reapvitalized/TSB/main/APOPHENIA.lua"))()
    end,
})

--////////////////////////////////////////////////////
--// ATOMIC SAMURAI
--////////////////////////////////////////////////////

Tabs.AtomicSamurai:CreateButton({
    Name = "Floating Girl",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Reapvitalized/TSB/refs/heads/main/FLOATING_GIRL.lua"))()
    end,
})

Tabs.AtomicSamurai:CreateButton({
    Name = "Yuta",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/damir512/AtomicToYuta/main/Protected_8122576078506000.txt"))()
    end,
})

Tabs.AtomicSamurai:CreateButton({
    Name = "Dark Lord",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Qaiddanial2904/Main/refs/heads/main/Dark%20lord"))()
    end,
})

Tabs.AtomicSamurai:CreateButton({
    Name = "Sukuna",
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/The-Strongest-Battlegrounds-sukuna-moveset-19923"))()
    end,
})

--////////////////////////////////////////////////////
--// CREDITS
--////////////////////////////////////////////////////

Tabs.Credits:CreateParagraph({
    Title = "Credits",
    Content = "Script created by Mr_3242\nThanks for using the script!"
})

Tabs.Credits:CreateButton({
    Name = "Copy TikTok Link",
    Callback = function()
        setclipboard("https://www.tiktok.com/@Mr_3242")
        Notify("Copied", "TikTok link copied")
    end,
})

Tabs.Credits:CreateButton({
    Name = "Copy YouTube Link",
    Callback = function()
        setclipboard("https://www.youtube.com/@Mr_3242.")
        Notify("Copied", "YouTube link copied")
    end,
})

Tabs.Credits:CreateButton({
    Name = "Copy Twitch Link",
    Callback = function()
        setclipboard("https://m.twitch.tv/quantumx_42/home")
        Notify("Copied", "Twitch link copied")
    end,
})

--////////////////////////////////////////////////////
--// UNLOAD
--////////////////////////////////////////////////////

getgenv().Mr_3242_Hub_Unload = function()

    pcall(function()
        Rayfield:Destroy()
    end)

    getgenv().Mr_3242_Hub_Unload = nil
end

Tabs.Unload:CreateButton({
    Name = "Unload Script",
    Callback = function()
        getgenv().Mr_3242_Hub_Unload()
    end,
})
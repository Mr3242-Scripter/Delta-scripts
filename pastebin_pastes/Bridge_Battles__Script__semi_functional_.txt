---------------------------------------------------------------------
--// SERVICES
---------------------------------------------------------------------
local Players = game:GetService("Players")

---------------------------------------------------------------------
--// PLAYER
---------------------------------------------------------------------
local LocalPlayer = Players.LocalPlayer

---------------------------------------------------------------------
--// CLEAN RE-EXECUTE
---------------------------------------------------------------------
if getgenv().GamemodeUnload then
    pcall(getgenv().GamemodeUnload)
end

---------------------------------------------------------------------
--// LOAD RAYFIELD
---------------------------------------------------------------------
local Rayfield

repeat
    local s,r = pcall(function()
        return loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
    end)

    if s and r then
        Rayfield = r
    else
        task.wait(1)
    end
until Rayfield

---------------------------------------------------------------------
--// FILTER NOTIFICATIONS
---------------------------------------------------------------------
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

---------------------------------------------------------------------
--// CUSTOM NOTIFICATIONS
---------------------------------------------------------------------
local function Notify(title,content)

    Rayfield:Notify({
        Title = title,
        Content = content,
        Duration = 3,
        Image = 4483362458
    })

end

---------------------------------------------------------------------
--// WINDOW
---------------------------------------------------------------------
local Window = Rayfield:CreateWindow({
    Name = "Bridge Battles!",
    LoadingTitle = "Semi functional",
    LoadingSubtitle = "Follow me in TikTok Mr_3242",
    ConfigurationSaving = {
        Enabled = false
    }
})

---------------------------------------------------------------------
--// TABS
---------------------------------------------------------------------
local Tabs = {}

Tabs.CurrentGamemode = Window:CreateTab("Current Gamemode",4483362458)
Tabs.Classic = Window:CreateTab("Classic Gamemode",4483362458)
Tabs.Race = Window:CreateTab("Race Gamemode",4483362458)
Tabs.Showdown = Window:CreateTab("Showdown Gamemode",4483362458)
Tabs.Chaos = Window:CreateTab("Chaos Gamemode",4483362458)
Tabs.Credits = Window:CreateTab("Credits",4483362458)
Tabs.Unload = Window:CreateTab("Unload",4483362458)

---------------------------------------------------------------------
--// STATES
---------------------------------------------------------------------
local states = {}

local savedCFrame = nil
local atGiver = false

---------------------------------------------------------------------
--// GAMEMODES
---------------------------------------------------------------------
local Gamemodes = {
    Classic = {"Blue","Green","Red","Yellow"},
    Race = {"Blue","Red"},
    Showdown = {"Blue","Red"},
    Chaos = {"Black","Blue","Green","Orange","Pink","Purple","Red","Yellow"}
}

---------------------------------------------------------------------
--// CURRENT GAMEMODE
---------------------------------------------------------------------
local gmParagraph = Tabs.CurrentGamemode:CreateParagraph({
    Title = "Current Gamemode",
    Content = "Detecting..."
})

local function getGamemode()

    for mode in pairs(Gamemodes) do

        if workspace:FindFirstChild(mode) then
            return mode
        end

    end

    return "None"
end

task.spawn(function()

    while task.wait(0.5) do

        local mode = getGamemode()

        gmParagraph:Set({
            Title = "Current Gamemode",
            Content = "The current gamemode is " .. mode .. " Gamemode"
        })

    end

end)

---------------------------------------------------------------------
--// HELPERS
---------------------------------------------------------------------
local function getHRP()

    local char = LocalPlayer.Character
    if not char then return end

    return char:FindFirstChild("HumanoidRootPart")
end

local function getGiver(mode,team)

    local gm = workspace:FindFirstChild(mode)
    if not gm then return end

    local teamFolder = gm:FindFirstChild(team)
    if not teamFolder then return end

    local blockMain = teamFolder:FindFirstChild("BlockMain")
    if not blockMain then return end

    return blockMain:FindFirstChild("Giver")
end

---------------------------------------------------------------------
--// TELEPORT SYSTEM
---------------------------------------------------------------------
task.spawn(function()

    while task.wait(0.1) do

        local brick = LocalPlayer:FindFirstChild("BrickCount")
        local hrp = getHRP()

        if not brick or not hrp then
            continue
        end

        local currentMode = getGamemode()

        -------------------------------------------------------------
        -- TELEPORT TO GIVER
        -------------------------------------------------------------
        if brick.Value == 0 and not atGiver then

            for key,v in pairs(states) do

                if v then

                    local team = key:gsub(currentMode,"")
                    local giver = getGiver(currentMode,team)

                    if giver then

                        savedCFrame = hrp.CFrame

                        hrp.CFrame = giver.CFrame + Vector3.new(0,5,0)

                        atGiver = true

                        break
                    end
                end
            end
        end

        -------------------------------------------------------------
        -- TELEPORT BACK
        -------------------------------------------------------------
        if brick.Value > 0 and atGiver then

            if savedCFrame then
                hrp.CFrame = savedCFrame
            end

            atGiver = false
        end

    end

end)

---------------------------------------------------------------------
--// TOGGLE BUILDER
---------------------------------------------------------------------
local function createTeam(tab,mode,team)

    tab:CreateParagraph({
        Title = "========= "..string.upper(team).." TEAM =========",
        Content = mode.." "..team.." blocks giver"
    })

    tab:CreateToggle({
        Name = team,
        CurrentValue = false,

        Callback = function(v)
            states[mode..team] = v
        end
    })

end

---------------------------------------------------------------------
--// BUILD GAMEMODE TABS
---------------------------------------------------------------------
for mode,teams in pairs(Gamemodes) do

    for _,team in ipairs(teams) do
        createTeam(Tabs[mode],mode,team)
    end

end

---------------------------------------------------------------------
--// CREDITS
---------------------------------------------------------------------
Tabs.Credits:CreateParagraph({
    Title="Credits",
    Content="Script created by Mr_3242\nThanks for using the script!"
})
 
Tabs.Credits:CreateButton({
    Name="Copy TikTok Link",
    Callback=function()
        setclipboard("https://www.tiktok.com/@Mr_3242")
        Notify("Copied","TikTok link copied")
    end
})
 
Tabs.Credits:CreateButton({
    Name="Copy YouTube Link",
    Callback=function()
        setclipboard("https://www.youtube.com/@Mr_3242.")
        Notify("Copied","YouTube link copied")
    end
})
 
Tabs.Credits:CreateButton({
    Name="Copy Twitch Link",
    Callback=function()
        setclipboard("https://m.twitch.tv/pantherarmy_42/home")
        Notify("Copied","Twitch link copied")
    end
})

---------------------------------------------------------------------
--// UNLOAD
---------------------------------------------------------------------
Tabs.Unload:CreateButton({
    Name = "Unload Script",

    Callback = function()

        for k in pairs(states) do
            states[k] = false
        end

        atGiver = false
        savedCFrame = nil

        task.wait(0.1)

        pcall(function()
            Rayfield:Destroy()
        end)

        getgenv().GamemodeUnload = nil
    end
})

---------------------------------------------------------------------
--// GLOBAL UNLOAD
---------------------------------------------------------------------
getgenv().GamemodeUnload = function()

    for k in pairs(states) do
        states[k] = false
    end

    atGiver = false
    savedCFrame = nil

    pcall(function()
        Rayfield:Destroy()
    end)

    getgenv().GamemodeUnload = nil
end
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer

local developerProductIdToggle = 1858193567
local developerProductIdButton = 1886208086

--// STATE
local NukeEnabled = false
local XPEnabled = false
local DamageCaseoh = false
local ScriptRunning = true

--// WINDOW
local Window = Rayfield:CreateWindow({
    Name = "A Very Hungry CaseOh 🧇",
    LoadingTitle = "Admin panel",
    LoadingSubtitle = "Follow me on TikTok Mr_3242",
    ConfigurationSaving = { Enabled = false },
    Discord = { Enabled = false },
    KeySystem = false
})

--// TABS
local MainTab = Window:CreateTab("Main", 4483362458)
local WeaponTab = Window:CreateTab("Weapons", 4483362458)
local ToolTab = Window:CreateTab("Tools", 4483362458)
local CreditsTab = Window:CreateTab("Credits", 4483362458)
local UnloadTab = Window:CreateTab("Unload", 4483362458)

--// FILTER NOTIFICATIONS
local oldNotify = Rayfield.Notify
Rayfield.Notify = function(self, data)
    if data and data.Title then
        local t = tostring(data.Title)
        if t:find("Rayfield") or t:find("Interface") then return end
    end
    return oldNotify(self, data)
end

--// NOTIFY
local function Notify(t,c)
    Rayfield:Notify({
        Title=t,
        Content=c,
        Duration=3,
        Image=4483362458
    })
end

--// CLEAN RE-EXECUTE
if getgenv().KillstreakUnload then
    pcall(getgenv().KillstreakUnload)
end

--// FUNCTIONS
local function ActivateNuke()
    task.spawn(function()
        while NukeEnabled and ScriptRunning do
            pcall(function()
                MarketplaceService:SignalPromptProductPurchaseFinished(
                    LocalPlayer.UserId,
                    developerProductIdToggle,
                    true
                )
            end)
            task.wait(0.1)
        end
    end)
end

local function ActivateXP()
    task.spawn(function()
        while XPEnabled and ScriptRunning do
            pcall(function()
                local args = {
                    [1] = 999999999,
                    [2] = "8NYEG50HeTQHspveEFhS"
                }

                ReplicatedStorage:WaitForChild("Damage"):FireServer(unpack(args))
            end)
            task.wait()
        end
    end)
end

--// MAIN TAB
MainTab:CreateToggle({
    Name = "Nuke",
    CurrentValue = false,
    Flag = "NukeToggle",
    Callback = function(v)
        NukeEnabled = v
        if v then ActivateNuke() end
    end
})

MainTab:CreateButton({
    Name = "become case oh",
    Callback = function()
        pcall(function()
            MarketplaceService:SignalPromptProductPurchaseFinished(
                LocalPlayer.UserId,
                developerProductIdButton,
                true
            )
        end)
    end
})

MainTab:CreateToggle({
    Name = "Inf XP",
    CurrentValue = false,
    Flag = "InfXPToggle",
    Callback = function(v)
        XPEnabled = v
        if v then ActivateXP() end
    end
})

MainTab:CreateParagraph({
    Title = "Warning",
    Content = "Kill caseoh removes caseoh permanently and it won't ever appear again."
})

MainTab:CreateButton({
    Name = "Kill caseoh",
    Callback = function()
        Notify("Warning", "Removing caseoh permanently...")

        task.spawn(function()
            while ScriptRunning do
                task.wait()
                pcall(function()
                    ReplicatedStorage.RemoveItem:FireServer(workspace.Respawn)
                    ReplicatedStorage.RemoveItem:FireServer(workspace.CaseOh)
                    ReplicatedStorage.RemoveItem:FireServer(workspace.MiniCaseOh)
                end)
            end
        end)
    end
})

MainTab:CreateToggle({
    Name = "Damage CaseOh [Weapon Required]",
    CurrentValue = false,
    Flag = "DamageCaseoh",
    Callback = function(v)
        DamageCaseoh = v

        task.spawn(function()
            while DamageCaseoh and ScriptRunning do
                local Character = LocalPlayer.Character
                local Tool = Character and Character:FindFirstChildOfClass("Tool")

                if Tool and workspace:FindFirstChild("CaseOh") then
                    local args = {
                        Tool,
                        {
                            p = Vector3.new(-905.8367309570313, 11.358884811401367, -486.8328857421875),
                            pid = 1,
                            part = workspace.CaseOh.UpperTorso,
                            d = 83.7686996459961,
                            maxDist = 72.82382202148438,
                            h = workspace.CaseOh.CaseOhHumanoid,
                            m = Enum.Material.Plastic,
                            n = Vector3.new(-0.49207738041877747, 0.6165332794189453, 0.6146109700202942),
                            t = 0.0998840840170001,
                            sid = 3,
                        }
                    }

                    ReplicatedStorage.WeaponsSystem.Network.WeaponHit:FireServer(unpack(args))
                end

                task.wait(0.0001)
            end
        end)
    end
})

--// WEAPONS TAB
WeaponTab:CreateButton({
    Name = "AdminGun",
    Callback = function()
        ReplicatedStorage.NewTool:FireServer("AdminGun")
    end
})

WeaponTab:CreateButton({
    Name = "SunLauncher",
    Callback = function()
        ReplicatedStorage.NewTool:FireServer("SunLauncher")
    end
})

WeaponTab:CreateButton({
    Name = "RF Rocket Launcher",
    Callback = function()
        ReplicatedStorage.NewTool:FireServer("RapidRocketlauncher")
    end
})

local Weapons = {
    "Minigun","Rocketlauncher","SMG","Shotgun","Sniper","AssaultRifle",
    "Pistol","GrenadeLauncher","Railgun","LMG","BlackHoleGun",
    "BananaLauncher","GunGun","BurgerLauncher","ConfettiCannon",
    "Crossbow","CarLauncher","Baconator","AntiMatter","Waffle-Inator","PigeonLauncher",
}

for _, v in ipairs(Weapons) do
    WeaponTab:CreateButton({
        Name = v,
        Callback = function()
            ReplicatedStorage.NewTool:FireServer(v)
        end
    })
end

--// TOOLS TAB
ToolTab:CreateButton({
    Name = "Jeep",
    Callback = function()
        ReplicatedStorage.NewTool:FireServer("JEEP")
    end
})

local Tools = {
    "SuperFusionCoil","FusionCoil","SpeedCoil",
    "SuperSpeedCoil","GravityCoil","Regen","Paintball",
}

for _, v in ipairs(Tools) do
    ToolTab:CreateButton({
        Name = v,
        Callback = function()
            ReplicatedStorage.NewTool:FireServer(v)
        end
    })
end

--// CREDITS
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

--// UNLOAD SYSTEM
getgenv().KillstreakUnload = function()
    ScriptRunning = false
    NukeEnabled = false
    XPEnabled = false
    DamageCaseoh = false

    pcall(function()
        Rayfield:Destroy()
    end)

    getgenv().KillstreakUnload = nil
end

UnloadTab:CreateButton({
    Name = "Unload Script",
    Callback = function()
        getgenv().KillstreakUnload()
    end
})

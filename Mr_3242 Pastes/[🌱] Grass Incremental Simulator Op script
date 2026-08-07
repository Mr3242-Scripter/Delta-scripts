local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

local Window = Rayfield:CreateWindow({
   Name = "[🌱] Grass Incremental Simulator",
   LoadingTitle = "easily beat the game",
   LoadingSubtitle = "follow me on TikTok Mr_3242",
   ConfigurationSaving = { Enabled = false }
})

---------------------------------------------------
-- REMOTES
---------------------------------------------------
local Remotes = RS:WaitForChild("Remotes")

local grassRemote = Remotes:WaitForChild("GrassCollect")
local strengthRemote = Remotes:WaitForChild("IncreaseMuscle")
local popRemote = Remotes:WaitForChild("IncreasePop")
local upRemote = Remotes:WaitForChild("Upgrade")
local rebRemote = Remotes:WaitForChild("Rebirth")

---------------------------------------------------
-- FLAGS + THREAD CONTROL
---------------------------------------------------
local Flags = {
    AutoFarm = false,
    AutoStrength = false,
    AutoPop = false,
    AutoValue = false,
    AutoAmount = false,
    AutoGrowth = false,
    AutoRebirth = false
}

local Threads = {}

local function StartThread(name, func)
    if Threads[name] then return end
    Threads[name] = task.spawn(function()
        func()
        Threads[name] = nil
    end)
end

---------------------------------------------------
-- SPEED SYSTEM
---------------------------------------------------
local Character, Humanoid
local WalkSpeedEnabled = false
local WalkSpeedValue = 16
local OriginalWalkSpeed = 16

local function ApplySpeed()
    if Humanoid and WalkSpeedEnabled then
        Humanoid.WalkSpeed = WalkSpeedValue
    end
end

local function SetupCharacter(char)
    Character = char
    Humanoid = char:WaitForChild("Humanoid")

    OriginalWalkSpeed = Humanoid.WalkSpeed
    task.wait(0.1)
    ApplySpeed()
end

if LocalPlayer.Character then
    SetupCharacter(LocalPlayer.Character)
end

LocalPlayer.CharacterAdded:Connect(SetupCharacter)

-- anti-reset loop
task.spawn(function()
    while task.wait(0.25) do
        if WalkSpeedEnabled and Humanoid then
            if Humanoid.WalkSpeed ~= WalkSpeedValue then
                Humanoid.WalkSpeed = WalkSpeedValue
            end
        end
    end
end)

---------------------------------------------------
-- MAIN TAB
---------------------------------------------------
local MainTab = Window:CreateTab("Auto Farm", 4483362458)

MainTab:CreateSlider({
   Name = "speed",
   Range = {16, 200},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(v)
      WalkSpeedValue = v
      ApplySpeed()
   end,
})

MainTab:CreateToggle({
   Name = "Enable Speed",
   CurrentValue = false,
   Callback = function(v)
      WalkSpeedEnabled = v

      if Humanoid then
         if v then
            Humanoid.WalkSpeed = WalkSpeedValue
         else
            Humanoid.WalkSpeed = OriginalWalkSpeed
         end
      end
   end,
})

---------------------------------------------------
-- INFINITE GRASS
---------------------------------------------------
MainTab:CreateToggle({
   Name = "Infinite Glass",
   CurrentValue = false,
   Callback = function(v)
      Flags.AutoFarm = v

      if v then
         StartThread("Farm", function()
            while Flags.AutoFarm do
               grassRemote:FireServer({
                  normal = 150,
                  silver = 300,
                  ruby = 50,
                  golden = 50,
                  diamond = 25
               })
               task.wait(0.07)
            end
         end)
      end
   end,
})

---------------------------------------------------
-- STRENGTH
---------------------------------------------------
MainTab:CreateToggle({
   Name = "Infinity Strength",
   CurrentValue = false,
   Callback = function(v)
      Flags.AutoStrength = v

      if v then
         StartThread("Strength", function()
            while Flags.AutoStrength do
               strengthRemote:FireServer()
               task.wait(0.1)
            end
         end)
      end
   end,
})

---------------------------------------------------
-- AUTO POP
---------------------------------------------------
MainTab:CreateToggle({
   Name = "Auto Pop (BETA!)",
   CurrentValue = false,
   Callback = function(v)
      Flags.AutoPop = v

      if v then
         StartThread("Pop", function()
            while Flags.AutoPop do
               popRemote:FireServer(false)
               task.wait(0.15)
            end
         end)
      end
   end,
})

---------------------------------------------------
-- UPGRADES TAB
---------------------------------------------------
local UpgradeTab = Window:CreateTab("Upgrades", 4483362458)

local function UpgradeLoop(name, payload)
    StartThread(name, function()
        while Flags[name] do
            upRemote:FireServer(payload)
            task.wait(0.2)
        end
    end)
end

UpgradeTab:CreateToggle({
   Name = "Auto Upgrade Grass Value",
   CurrentValue = false,
   Callback = function(v)
      Flags.AutoValue = v
      if v then
         UpgradeLoop("AutoValue", {
            {currencyName = "Grass", amount = 1, max = 99, upgradeValue = "GrassValue", cost = 2}
         })
      end
   end,
})

UpgradeTab:CreateToggle({
   Name = "Auto Upgrade Grass Amount",
   CurrentValue = false,
   Callback = function(v)
      Flags.AutoAmount = v
      if v then
         UpgradeLoop("AutoAmount", {
            {currencyName = "Grass", amount = 1, max = 49, upgradeValue = "GrassAmount", cost = 3}
         })
      end
   end,
})

UpgradeTab:CreateToggle({
   Name = "Auto Upgrade Growth Rate",
   CurrentValue = false,
   Callback = function(v)
      Flags.AutoGrowth = v
      if v then
         UpgradeLoop("AutoGrowth", {
            {currencyName = "Grass", amount = 1, max = 7, upgradeValue = "SpawnRate1", cost = 5}
         })
      end
   end,
})

UpgradeTab:CreateToggle({
   Name = "Auto Rebirth",
   CurrentValue = false,
   Callback = function(v)
      Flags.AutoRebirth = v

      if v then
         StartThread("Rebirth", function()
            while Flags.AutoRebirth do
               rebRemote:FireServer()
               task.wait(0.3)
            end
         end)
      end
   end,
})

---------------------------------------------------
-- ANTI AFK
---------------------------------------------------
task.spawn(function()
   local vu = game:GetService("VirtualUser")

   LocalPlayer.Idled:Connect(function()
      vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
      task.wait(1)
      vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
   end)
end)
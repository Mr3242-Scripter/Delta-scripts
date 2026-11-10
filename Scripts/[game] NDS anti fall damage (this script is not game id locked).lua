--// Anti Fall Damage

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer

local TARGET_PLACE_ID = 189707 -- Natural Disaster Survival
local antiFallEnabled = true
local connection

local function notify(title, text, duration)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = title,
            Text = text,
            Duration = duration or 5
        })
    end)
end

-- Place check warning
if game.PlaceId ~= TARGET_PLACE_ID then
    notify(
        "Warning",
        "Not Natural Disaster Survival. Script will still run anyway.",
        6
    )
else
    notify(
        "AntiFall",
        "Natural Disaster Survival detected. Script active.",
        4
    )
end

local function attach(character)
    local root = character:WaitForChild("HumanoidRootPart")

    if connection then
        connection:Disconnect()
    end

    local hb = RunService.Heartbeat
    local rsd = RunService.RenderStepped
    local zero = Vector3.zero

    connection = hb:Connect(function()
        if not antiFallEnabled or not root or not root.Parent then
            if connection then connection:Disconnect() end
            return
        end

        local vel = root.AssemblyLinearVelocity
        root.AssemblyLinearVelocity = zero
        rsd:Wait()
        root.AssemblyLinearVelocity = vel
    end)
end

if player.Character then
    attach(player.Character)
end

player.CharacterAdded:Connect(function(char)
    if antiFallEnabled then
        attach(char)
    end
end)

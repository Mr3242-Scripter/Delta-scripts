local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Badass Hub",
    LoadingTitle = "Badass Hub",
    LoadingSubtitle = "Mr_3242",
    ConfigurationSaving = { Enabled = false }
})

local Tab = Window:CreateTab("Badass Experience", 4483362458)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local MarketplaceService = game:GetService("MarketplaceService")


local function u8()
    local v2 = MarketplaceService:GetDeveloperProductsAsync():GetCurrentPage()
    local v6 = {}

    local v3, v4, v5 = pairs(v2)

    while true do
        local v7
        v5, v7 = v3(v4, v5)

        if v5 == nil then
            break
        end

        if string.find(v7.Name, "Tier 3") then
            table.insert(v6, v7.ProductId)
        end
    end

    return v6
end

------------------------------------------------
-- BUTTON: Delete Effects
------------------------------------------------
Tab:CreateButton({
    Name = "Delete Effects",
    Callback = function()
        local gui = LocalPlayer:FindFirstChild("PlayerGui")
        if gui then
            local fx = gui:FindFirstChild("Effects")
            if fx then
                fx.Enabled = false
            end
        end
    end
})

------------------------------------------------
-- TOGGLE: Infinite Money
------------------------------------------------
local inf = false

Tab:CreateToggle({
    Name = "Infinite Money",
    CurrentValue = false,

    Callback = function(state)
        inf = state

        task.spawn(function()
            local v33 = u8()

            while inf do
                for _, productId in pairs(v33) do
                    MarketplaceService:SignalPromptProductPurchaseFinished(
                        LocalPlayer.UserId,
                        productId,
                        true
                    )
                end
                task.wait()
            end
        end)
    end
})

------------------------------------------------
-- INPUT: Walkspeed
------------------------------------------------
Tab:CreateInput({
    Name = "Walkspeed",
    PlaceholderText = "Enter speed",
    RemoveTextAfterFocusLost = false,

    Callback = function(text)
        local char = LocalPlayer.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")

        local speed = tonumber(text)
        if hum and speed then
            hum.WalkSpeed = speed
        end
    end
})
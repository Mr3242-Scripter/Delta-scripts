--// CLEAN RE-EXECUTE
if getgenv().GrieferUnload then
    pcall(getgenv().GrieferUnload)
end

-- Load Rayfield
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Create Window
local Window = Rayfield:CreateWindow({
    Name = "Voxels [🛠️]",
    LoadingTitle = "Ultimate Griefer",
    LoadingSubtitle = "Follow me on TikTok Mr_3242",
    ConfigurationSaving = { Enabled = false },
    Discord = { Enabled = false },
    KeySystem = false
})

--// FILTER NOTIFICATIONS
local oldNotify = Rayfield.Notify
if oldNotify then
    Rayfield.Notify = function(self, data)
        if data and data.Title then
            local t = tostring(data.Title)
            if t:find("Rayfield") or t:find("Interface") then return end
        end
        return oldNotify(self, data)
    end
end

--// NOTIFY
local function Notify(t, c)
    Rayfield:Notify({
        Title = t,
        Content = c,
        Duration = 3,
        Image = 4483362458
    })
end

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local remote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("PlaceBlock")
local BlockStorage = ReplicatedStorage:WaitForChild("BlockStorage")

-- Player / Character
local player = Players.LocalPlayer
local character
local humanoidRootPart

local function setupCharacter(char)
    character = char
    humanoidRootPart = char:WaitForChild("HumanoidRootPart", 10)
end

if player.Character then
    setupCharacter(player.Character)
end
player.CharacterAdded:Connect(setupCharacter)

-- Configuration
local BuilderConfig = {
    selectedBlock = "Oak Log",
    blockType = "Oak Log",
    material = Enum.NormalId.Top,
    previewEnabled = true,
    previewTransparency = 0.7,
    previewColor = Color3.fromRGB(255, 255, 255),
    isPlacing = false,
    fillSize = 5,
    showFillPreview = false,
    customFillSize = 10
}

-- Preview storage
local previewParts = {}
local fillPreviewParts = {}
local previewConnection = nil
local lastPreviewPos = nil

-- ====================
-- PREVIEW SYSTEM
-- ====================
local function createPreviewPart(position, size)
    local part = Instance.new("Part")
    part.Name = "BlockPreview"
    part.Size = Vector3.new(size, size, size)
    part.Position = position
    part.Anchored = true
    part.CanCollide = false
    part.Transparency = BuilderConfig.previewTransparency
    part.Color = BuilderConfig.previewColor
    part.Material = Enum.Material.Neon
    part.CastShadow = false

    local highlight = Instance.new("SelectionBox")
    highlight.Adornee = part
    highlight.Color3 = BuilderConfig.previewColor
    highlight.Parent = part

    part.Parent = workspace
    return part
end

local function clearPreviews()
    for _, part in ipairs(previewParts) do
        if part and part.Parent then
            part:Destroy()
        end
    end
    table.clear(previewParts)
end

local function clearFillPreview()
    for _, part in ipairs(fillPreviewParts) do
        if part and part.Parent then
            part:Destroy()
        end
    end
    table.clear(fillPreviewParts)
end

-- ====================
-- BLOCK PLACEMENT
-- ====================
local function placeBlock(position)
    local blockFolder = BlockStorage:FindFirstChild(BuilderConfig.blockType)
    
    if not blockFolder then
        warn("[Missing block]:", BuilderConfig.blockType)
        Notify("Error", "Missing block: " .. tostring(BuilderConfig.blockType))
        return
    end

    local success, err = pcall(function()
        local args = {
            blockFolder,
            BuilderConfig.material,
            position,
            BuilderConfig.selectedBlock
        }
        remote:FireServer(unpack(args))
    end)

    if not success then
        warn("[PlaceBlock Error]:", err)
        Notify("Error", "Failed to place block")
    end
end

local function placeBlockInstantly(position)
    task.spawn(placeBlock, position)
end

local function updateSelectedBlock(blockName)
    BuilderConfig.selectedBlock = blockName
    BuilderConfig.blockType = BlockTypeMap[blockName] or "1Grass"

    local colorMap = {
        ["Oak Log"] = Color3.fromRGB(139, 69, 19),
        ["Grass Block"] = Color3.fromRGB(100, 200, 100),
        ["Stone"] = Color3.fromRGB(128, 128, 128),
        ["Brick"] = Color3.fromRGB(178, 34, 34),
        ["Glass"] = Color3.fromRGB(173, 216, 230),
        ["Gold Block"] = Color3.fromRGB(255, 215, 0),
        ["Iron Block"] = Color3.fromRGB(200, 200, 200),
        ["Diamond Block"] = Color3.fromRGB(0, 255, 255),
        ["Emerald Block"] = Color3.fromRGB(0, 200, 0),
        ["Redstone Block"] = Color3.fromRGB(255, 0, 0)
    }
    BuilderConfig.previewColor = colorMap[blockName] or Color3.fromRGB(255, 255, 255)
end

-- ====================
-- FILL SYSTEM (INFINITE)
-- ====================
local function showFillPreview(position, size)
    clearFillPreview()
    if not BuilderConfig.previewEnabled or not BuilderConfig.showFillPreview then return end

    local halfSize = math.floor(size / 2)

    local startPos = Vector3.new(
        math.floor(position.X / 4) * 4,
        math.floor(position.Y / 4) * 4,
        math.floor(position.Z / 4) * 4
    )

    for x = -halfSize, halfSize do
        for y = -halfSize, halfSize do
            for z = -halfSize, halfSize do
                if not outlineOnly or
                   math.abs(x) == halfSize or
                   math.abs(y) == halfSize or
                   math.abs(z) == halfSize then

                    local blockPos = Vector3.new(
                        startPos.X + (x * 4),
                        startPos.Y + (y * 4),
                        startPos.Z + (z * 4)
                    )

                    local preview = createPreviewPart(blockPos, 4)
                    preview.Transparency = 0.8
                    preview.Color = Color3.fromRGB(0, 200, 255)
                    table.insert(fillPreviewParts, preview)
                end
            end
        end
    end
end

local function fillArea(position, size)
    if BuilderConfig.isPlacing then return end
    BuilderConfig.isPlacing = true
    clearFillPreview()

    local halfSize = math.floor(size / 2)

    local startPos = Vector3.new(
        math.floor(position.X / 4) * 4,
        math.floor(position.Y / 4) * 4,
        math.floor(position.Z / 4) * 4
    )

    local totalBlocks = (size * 2 + 1) ^ 3
    print("Starting fill:", totalBlocks, "blocks...")

    local count = 0

    for x = -halfSize, halfSize do
        for y = -halfSize, halfSize do
            for z = -halfSize, halfSize do
                local blockPos = Vector3.new(
                    startPos.X + (x * 4),
                    startPos.Y + (y * 4),
                    startPos.Z + (z * 4)
                )

                placeBlockInstantly(blockPos)

                count += 1
                if count % 100 == 0 then
                    task.wait()
                end
            end
        end
    end

    BuilderConfig.isPlacing = false
    print("✓ Fill complete! (" .. totalBlocks .. " blocks)")
    Notify("Fill Complete", totalBlocks .. " blocks placed")
end

-- ====================
-- REAL-TIME PREVIEW
-- ====================
local function startPreviewSystem()
    if previewConnection then
        previewConnection:Disconnect()
        previewConnection = nil
    end

    if not BuilderConfig.previewEnabled then return end

    previewConnection = RunService.Heartbeat:Connect(function()
        if BuilderConfig.isPlacing or not humanoidRootPart or not humanoidRootPart.Parent then
            return
        end

        local lookVector = humanoidRootPart.CFrame.LookVector
        local previewPos = humanoidRootPart.Position + (lookVector * 12)

        previewPos = Vector3.new(
            math.floor(previewPos.X / 4) * 4 + 2,
            math.floor(previewPos.Y / 4) * 4 + 2,
            math.floor(previewPos.Z / 4) * 4 + 2
        )

        if lastPreviewPos and (previewPos - lastPreviewPos).Magnitude < 0.1 then
            return
        end
        lastPreviewPos = previewPos

        clearPreviews()

        local preview = createPreviewPart(previewPos, 4)
        preview.Color = BuilderConfig.previewColor
        table.insert(previewParts, preview)

        if BuilderConfig.showFillPreview then
            showFillPreview(previewPos, BuilderConfig.fillSize)
        end
    end)
end

-- ====================
-- UI
-- ====================
-- Block Selection Tab
local BlockTab = Window:CreateTab("Block Selection", 4483362458)
BlockTab:CreateSection("Choose Block Type")

local BlockStorage = ReplicatedStorage:WaitForChild("BlockStorage")

-- Create a button for every block in BlockStorage
for _, block in ipairs(BlockStorage:GetChildren()) do
    BlockTab:CreateButton({
        Name = block.Name,
        Callback = function()
            BuilderConfig.selectedBlock = block.Name
            BuilderConfig.blockType = block.Name
            
            -- Optional color update
            BuilderConfig.previewColor = Color3.fromRGB(255, 255, 255)
            
            Notify("Block Selected", block.Name)
        end
    })
end

-- Instant Build
local BuildTab = Window:CreateTab("Instant Build", 4483362458)
BuildTab:CreateSection("Zero-Delay Building")

BuildTab:CreateButton({
    Name = "Place Block",
    Callback = function()
        if not humanoidRootPart then return end
        local lookVector = humanoidRootPart.CFrame.LookVector
        local placePos = humanoidRootPart.Position + (lookVector * 10)
        placePos = Vector3.new(
            math.floor(placePos.X / 4) * 4 + 2,
            math.floor(placePos.Y / 4) * 4 + 2,
            math.floor(placePos.Z / 4) * 4 + 2
        )
        placeBlockInstantly(placePos)
    end
})

BuildTab:CreateButton({
    Name = "Instant 10x10 Platform",
    Callback = function()
        if BuilderConfig.isPlacing or not humanoidRootPart then return end
        BuilderConfig.isPlacing = true

        local startPos = humanoidRootPart.Position

        for x = -5, 5 do
            for z = -5, 5 do
                local pos = Vector3.new(
                    startPos.X + (x * 8),
                    startPos.Y - 5,
                    startPos.Z + (z * 8)
                )
                pos = Vector3.new(
                    math.floor(pos.X / 4) * 4 + 2,
                    math.floor(pos.Y / 4) * 4 + 2,
                    math.floor(pos.Z / 4) * 4 + 2
                )
                placeBlockInstantly(pos)
            end
        end

        BuilderConfig.isPlacing = false
        Notify("Platform", "10x10 platform created!")
    end
})

-- Fill Tool
local FillTab = Window:CreateTab("Fill Tool", 4483362458)
FillTab:CreateSection("Custom Size Filling (Infinite)")

local function setFillSize(size)
    if size < 1 then size = 1 end
    BuilderConfig.fillSize = size
    BuilderConfig.customFillSize = size
    clearFillPreview()
    Notify("Fill Size", "Set to " .. size)
end

FillTab:CreateInput({
    Name = "Custom Fill Size",
    PlaceholderText = "Enter any size (infinite)",
    RemoveTextAfterFocusLost = false,
    Callback = function(txt)
        local size = tonumber(txt)
        if size and size > 0 then
            setFillSize(size)
        end
    end
})

FillTab:CreateButton({
    Name = "Small (3x3x3)",
    Callback = function()
        setFillSize(3)
    end
})

FillTab:CreateButton({
    Name = "Medium (7x7x7)",
    Callback = function()
        setFillSize(7)
    end
})

FillTab:CreateButton({
    Name = "Large (15x15x15)",
    Callback = function()
        setFillSize(15)
    end
})

FillTab:CreateButton({
    Name = "Massive (25x25x25)",
    Callback = function()
        setFillSize(25)
    end
})

FillTab:CreateToggle({
    Name = "Show Fill Preview",
    CurrentValue = false,
    Callback = function(state)
        BuilderConfig.showFillPreview = state
        if not state then
            clearFillPreview()
        end
    end
})

FillTab:CreateButton({
    Name = "Fill at Cursor",
    Callback = function()
        if not humanoidRootPart then return end
        local lookVector = humanoidRootPart.CFrame.LookVector
        local fillPos = humanoidRootPart.Position + (lookVector * 15)
        fillArea(fillPos, BuilderConfig.fillSize)
    end
})

FillTab:CreateButton({
    Name = "Fill Below",
    Callback = function()
        if not humanoidRootPart then return end
        local pos = humanoidRootPart.Position
        fillArea(Vector3.new(pos.X, pos.Y - 8, pos.Z), BuilderConfig.fillSize)
    end
})

FillTab:CreateButton({
    Name = "Fill Around",
    Callback = function()
        if not humanoidRootPart then return end
        fillArea(humanoidRootPart.Position, BuilderConfig.fillSize)
    end
})

-- Preview
local PreviewTab = Window:CreateTab("Preview", 4483362458)
PreviewTab:CreateSection("Visual Settings")

PreviewTab:CreateToggle({
    Name = "Enable Preview",
    CurrentValue = true,
    Callback = function(state)
        BuilderConfig.previewEnabled = state
        if state then
            startPreviewSystem()
        else
            if previewConnection then
                previewConnection:Disconnect()
                previewConnection = nil
            end
            clearPreviews()
            clearFillPreview()
            lastPreviewPos = nil
        end
    end
})

PreviewTab:CreateSlider({
    Name = "Preview Transparency",
    Range = {30, 90},
    Increment = 1,
    Suffix = "%",
    CurrentValue = 70,
    Callback = function(value)
        BuilderConfig.previewTransparency = value / 100

        for _, part in ipairs(previewParts) do
            if part and part.Parent then
                part.Transparency = BuilderConfig.previewTransparency
            end
        end
        for _, part in ipairs(fillPreviewParts) do
            if part and part.Parent then
                part.Transparency = 0.8
            end
        end
    end
})

-- Keybinds
local KeyTab = Window:CreateTab("Keybinds", 4483362458)
KeyTab:CreateSection("Instant Controls")

KeyTab:CreateKeybind({
    Name = "INSTANT Place",
    CurrentKeybind = "E",
    HoldToInteract = false,
    Callback = function()
        if not humanoidRootPart then return end
        local lookVector = humanoidRootPart.CFrame.LookVector
        local placePos = humanoidRootPart.Position + (lookVector * 10)
        placePos = Vector3.new(
            math.floor(placePos.X / 4) * 4 + 2,
            math.floor(placePos.Y / 4) * 4 + 2,
            math.floor(placePos.Z / 4) * 4 + 2
        )
        placeBlockInstantly(placePos)
    end
})

KeyTab:CreateKeybind({
    Name = "INSTANT Fill",
    CurrentKeybind = "F",
    HoldToInteract = false,
    Callback = function()
        if not humanoidRootPart then return end
        local lookVector = humanoidRootPart.CFrame.LookVector
        local fillPos = humanoidRootPart.Position + (lookVector * 15)
        fillArea(fillPos, BuilderConfig.customFillSize)
    end
})

KeyTab:CreateKeybind({
    Name = "Toggle UI",
    CurrentKeybind = "RightShift",
    HoldToInteract = false,
    Callback = function()
        pcall(function()
            Rayfield:Toggle()
        end)
    end
})

KeyTab:CreateKeybind({
    Name = "Cycle Block",
    CurrentKeybind = "Q",
    HoldToInteract = false,
    Callback = function()
        local currentIndex = table.find(AvailableBlocks, BuilderConfig.selectedBlock) or 1
        local nextIndex = (currentIndex % #AvailableBlocks) + 1
        updateSelectedBlock(AvailableBlocks[nextIndex])
        Notify("Block Cycled", AvailableBlocks[nextIndex])
    end
})

-- Utilities
local UtilTab = Window:CreateTab("Utilities", 4483362458)
UtilTab:CreateSection("Tools")

UtilTab:CreateButton({
    Name = "Clear All Previews",
    Callback = function()
        clearPreviews()
        clearFillPreview()
        lastPreviewPos = nil
        Notify("Previews", "Cleared")
    end
})

UtilTab:CreateButton({
    Name = "Emergency Stop",
    Callback = function()
        BuilderConfig.isPlacing = false
        clearPreviews()
        clearFillPreview()
        lastPreviewPos = nil
        Notify("Emergency Stop", "All placement stopped")
    end
})

UtilTab:CreateParagraph({
    Title = "Settings Info",
    Content = "Delay: 0ms (Instant)\nFill Size: Infinite"
})

-- Credits
local CreditsTab = Window:CreateTab("Credits", 4483362458)

CreditsTab:CreateParagraph({
    Title = "Credits",
    Content = "Script created by Mr_3242\nThanks for using the script!"
})

CreditsTab:CreateButton({
    Name = "Copy TikTok Link",
    Callback = function()
        setclipboard("https://www.tiktok.com/@Mr_3242")
        Notify("Copied", "TikTok link copied")
    end
})

CreditsTab:CreateButton({
    Name = "Copy YouTube Link",
    Callback = function()
        setclipboard("https://www.youtube.com/@Mr_3242.")
        Notify("Copied", "YouTube link copied")
    end
})

CreditsTab:CreateButton({
    Name = "Copy Twitch Link",
    Callback = function()
        setclipboard("https://m.twitch.tv/quantumx_42/home")
        Notify("Copied", "Twitch link copied")
    end
})

-- Unload
local UnloadTab = Window:CreateTab("Unload", 4483362458)

getgenv().GrieferUnload = function()
    BuilderConfig.isPlacing = false
    BuilderConfig.previewEnabled = false
    BuilderConfig.showFillPreview = false

    if previewConnection then
        previewConnection:Disconnect()
        previewConnection = nil
    end

    clearPreviews()
    clearFillPreview()
    lastPreviewPos = nil

    pcall(function()
        Rayfield:Destroy()
    end)

    getgenv().GrieferUnload = nil
end

UnloadTab:CreateButton({
    Name = "Unload Script",
    Callback = function()
        getgenv().GrieferUnload()
    end
})

-- Init
BuilderConfig.fillSize = BuilderConfig.customFillSize
startPreviewSystem()
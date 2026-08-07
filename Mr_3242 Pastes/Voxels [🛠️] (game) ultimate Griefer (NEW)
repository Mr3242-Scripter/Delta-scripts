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
    if getgenv().VoxelsUnloaded then return end
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
local characterConnection

local function setupCharacter(char)
    character = char
    humanoidRootPart = nil
    local hrp = char:WaitForChild("HumanoidRootPart", 10)
    if hrp and hrp.Parent == char then
        humanoidRootPart = hrp
    end
end

if player.Character then
    setupCharacter(player.Character)
end
characterConnection = player.CharacterAdded:Connect(setupCharacter)

-- ====================
-- CONFIGURATION
-- ====================
local BuilderConfig = {
    selectedBlock = "Oak Log",
    blockType = "Oak Log",
    material = Enum.NormalId.Top,
    previewEnabled = true,
    previewTransparency = 0.45,
    isPlacing = false,
    fillSize = 5,
    showFillPreview = false,
    customFillSize = 10,
    currentOperationId = 0
}

-- ====================
-- PREVIEW STATE
-- ====================
local previewParts = {}
local fillPreviewParts = {}
local previewConnection = nil
local lastPreviewPos = nil
local lastFillSize = nil
local lastSelectedBlock = nil

-- ====================
-- AVAILABLE BLOCKS (built once at startup)
-- ====================
local AvailableBlocks = {}
for _, block in ipairs(BlockStorage:GetChildren()) do
    if block:IsA("BasePart") then
        table.insert(AvailableBlocks, block.Name)
    end
end

-- Validate / set default block
do
    local default = BlockStorage:FindFirstChild("Oak Log")
    if default and default:IsA("BasePart") then
        BuilderConfig.selectedBlock = "Oak Log"
        BuilderConfig.blockType = "Oak Log"
    elseif #AvailableBlocks > 0 then
        BuilderConfig.selectedBlock = AvailableBlocks[1]
        BuilderConfig.blockType = AvailableBlocks[1]
    else
        BuilderConfig.selectedBlock = ""
        BuilderConfig.blockType = ""
    end
end

local function updateSelectedBlock(blockName)
    BuilderConfig.selectedBlock = blockName
    BuilderConfig.blockType = blockName
    lastSelectedBlock = blockName
    lastPreviewPos = nil
end

-- ====================
-- SHARED GRID HELPERS
-- ====================
local function getGridCenter(worldPos)
    return Vector3.new(
        math.floor(worldPos.X / 4) * 4 + 2,
        math.floor(worldPos.Y / 4) * 4 + 2,
        math.floor(worldPos.Z / 4) * 4 + 2
    )
end

local function getStartOffset(size)
    return -math.floor((size - 1) / 2)
end

local function calculateFillPositions(center, size)
    local positions = {}
    local startOffset = getStartOffset(size)

    for x = 0, size - 1 do
        for y = 0, size - 1 do
            for z = 0, size - 1 do
                table.insert(positions, Vector3.new(
                    center.X + (startOffset + x) * 4,
                    center.Y + (startOffset + y) * 4,
                    center.Z + (startOffset + z) * 4
                ))
            end
        end
    end

    return positions
end

local function calculatePlatformPositions(center)
    local positions = {}
    local y = center.Y - 8
    local startX = center.X - 18
    local startZ = center.Z - 18

    for x = 0, 9 do
        for z = 0, 9 do
            table.insert(positions, Vector3.new(
                startX + x * 4,
                y,
                startZ + z * 4
            ))
        end
    end

    return positions
end

-- ====================
-- PREVIEW SYSTEM
-- ====================
local function createTexturedPreview(position)
    local source = BlockStorage:FindFirstChild(BuilderConfig.blockType)
    if not source or not source:IsA("BasePart") then
        local part = Instance.new("Part")
        part.Size = Vector3.new(4, 4, 4)
        part.Position = position
        part.Anchored = true
        part.CanCollide = false
        part.Transparency = BuilderConfig.previewTransparency
        part.Material = Enum.Material.Neon
        part.Color = Color3.fromRGB(200, 200, 200)
        part.Parent = workspace
        return part
    end

    local preview = source:Clone()
    preview.Name = "BlockPreview"
    preview.Size = Vector3.new(4, 4, 4)
    preview.Position = position
    preview.Anchored = true
    preview.CanCollide = false
    preview.CanQuery = false
    preview.CanTouch = false
    preview.CastShadow = false
    preview.Transparency = BuilderConfig.previewTransparency

    for _, child in ipairs(preview:GetDescendants()) do
        if child:IsA("Texture") or child:IsA("Decal") then
            child.Transparency = BuilderConfig.previewTransparency
        elseif child:IsA("Script") or child:IsA("LocalScript") then
            child:Destroy()
        end
    end

    preview.Parent = workspace
    return preview
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

local function applyTransparencyToExisting()
    local t = BuilderConfig.previewTransparency
    for _, part in ipairs(previewParts) do
        if part and part.Parent then
            part.Transparency = t
            for _, child in ipairs(part:GetDescendants()) do
                if child:IsA("Texture") or child:IsA("Decal") then
                    child.Transparency = t
                end
            end
        end
    end
end

-- ====================
-- BLOCK PLACEMENT
-- ====================
local function placeBlockFixed(position, operationId, fixedBlock, fixedName)
    if getgenv().VoxelsUnloaded then return false end
    if operationId ~= BuilderConfig.currentOperationId then return false end
    if not fixedBlock or not fixedBlock.Parent or not fixedBlock:IsA("BasePart") then return false end

    local success, err = pcall(function()
        remote:FireServer(fixedBlock, BuilderConfig.material, position, fixedName)
    end)

    if not success then
        warn("[PlaceBlock Error]:", err)
        return false
    end
    return true
end

-- ====================
-- SHARED PLACEMENT WORKER
-- ====================
local function runPlacementOperation(positions, fixedBlock, fixedName, operationName)
    if BuilderConfig.isPlacing then
        Notify("Busy", "An operation is already running")
        return
    end

    if not fixedBlock or not fixedBlock:IsA("BasePart") then
        Notify("Error", "Selected block is missing or invalid")
        return
    end

    local expected = #positions
    if expected == 0 then
        Notify("Error", "No positions calculated")
        return
    end

    BuilderConfig.isPlacing = true
    BuilderConfig.currentOperationId += 1
    local thisOperation = BuilderConfig.currentOperationId

    clearFillPreview()

    task.spawn(function()
        local successCount = 0
        local failCount = 0
        local result = "completed"

        local ok, err = pcall(function()
            for i, pos in ipairs(positions) do
                if getgenv().VoxelsUnloaded then
                    result = "unloaded"
                    return
                end
                if thisOperation ~= BuilderConfig.currentOperationId then
                    result = "cancelled"
                    return
                end
                if not fixedBlock.Parent then
                    result = "aborted"
                    return
                end

                local placed = placeBlockFixed(pos, thisOperation, fixedBlock, fixedName)
                if placed then
                    successCount += 1
                else
                    failCount += 1
                end

                if i % 40 == 0 then
                    if thisOperation ~= BuilderConfig.currentOperationId or getgenv().VoxelsUnloaded then
                        result = "cancelled"
                        return
                    end
                    task.wait()
                end
            end
        end)

        BuilderConfig.isPlacing = false

        if getgenv().VoxelsUnloaded then return end

        if not ok then
            Notify(operationName .. " Error", "Unexpected error")
            warn(err)
            return
        end

        if result == "cancelled" then
            Notify(operationName .. " Cancelled", "Emergency Stop used")
        elseif result == "aborted" then
            Notify(operationName .. " Aborted", "Selected block was removed")
        elseif result == "unloaded" then
            -- silent
        else
            if failCount == 0 then
                Notify(operationName .. " Complete", successCount .. "/" .. expected .. " placed")
            else
                Notify(operationName .. " Finished", successCount .. "/" .. expected .. " placed, " .. failCount .. " failed")
            end
        end
    end)
end

-- ====================
-- FILL SYSTEM
-- ====================
local function showFillPreview(position, size)
    clearFillPreview()
    if not BuilderConfig.previewEnabled or not BuilderConfig.showFillPreview then return end

    local center = getGridCenter(position)
    local positions = calculateFillPositions(center, size)

    if size > 5 then
        local minX, minY, minZ = math.huge, math.huge, math.huge
        local maxX, maxY, maxZ = -math.huge, -math.huge, -math.huge

        for _, pos in ipairs(positions) do
            minX = math.min(minX, pos.X)
            minY = math.min(minY, pos.Y)
            minZ = math.min(minZ, pos.Z)
            maxX = math.max(maxX, pos.X)
            maxY = math.max(maxY, pos.Y)
            maxZ = math.max(maxZ, pos.Z)
        end

        local mid = Vector3.new((minX + maxX)/2, (minY + maxY)/2, (minZ + maxZ)/2)
        local sizeVec = Vector3.new(maxX - minX + 4, maxY - minY + 4, maxZ - minZ + 4)
        local thickness = 0.35
        local col = Color3.fromRGB(0, 220, 255)
        local trans = 0.4

        local function edge(cframe, size)
            local p = Instance.new("Part")
            p.Size = size
            p.CFrame = cframe
            p.Anchored = true
            p.CanCollide = false
            p.Material = Enum.Material.Neon
            p.Color = col
            p.Transparency = trans
            p.CastShadow = false
            p.Parent = workspace
            table.insert(fillPreviewParts, p)
        end

        local hx, hy, hz = sizeVec.X/2, sizeVec.Y/2, sizeVec.Z/2

        edge(CFrame.new(mid + Vector3.new(0, -hy, -hz)), Vector3.new(sizeVec.X, thickness, thickness))
        edge(CFrame.new(mid + Vector3.new(0, -hy,  hz)), Vector3.new(sizeVec.X, thickness, thickness))
        edge(CFrame.new(mid + Vector3.new(-hx, -hy, 0)), Vector3.new(thickness, thickness, sizeVec.Z))
        edge(CFrame.new(mid + Vector3.new( hx, -hy, 0)), Vector3.new(thickness, thickness, sizeVec.Z))

        edge(CFrame.new(mid + Vector3.new(0,  hy, -hz)), Vector3.new(sizeVec.X, thickness, thickness))
        edge(CFrame.new(mid + Vector3.new(0,  hy,  hz)), Vector3.new(sizeVec.X, thickness, thickness))
        edge(CFrame.new(mid + Vector3.new(-hx,  hy, 0)), Vector3.new(thickness, thickness, sizeVec.Z))
        edge(CFrame.new(mid + Vector3.new( hx,  hy, 0)), Vector3.new(thickness, thickness, sizeVec.Z))

        edge(CFrame.new(mid + Vector3.new(-hx, 0, -hz)), Vector3.new(thickness, sizeVec.Y, thickness))
        edge(CFrame.new(mid + Vector3.new( hx, 0, -hz)), Vector3.new(thickness, sizeVec.Y, thickness))
        edge(CFrame.new(mid + Vector3.new(-hx, 0,  hz)), Vector3.new(thickness, sizeVec.Y, thickness))
        edge(CFrame.new(mid + Vector3.new( hx, 0,  hz)), Vector3.new(thickness, sizeVec.Y, thickness))
        return
    end

    local startOffset = getStartOffset(size)
    for i, pos in ipairs(positions) do
        local idx = i - 1
        local x = idx % size
        local y = math.floor(idx / size) % size
        local z = math.floor(idx / (size * size))

        if x == 0 or x == size - 1 or y == 0 or y == size - 1 or z == 0 or z == size - 1 then
            local p = createTexturedPreview(pos)
            p.Transparency = 0.55
            for _, t in ipairs(p:GetDescendants()) do
                if t:IsA("Texture") or t:IsA("Decal") then
                    t.Transparency = 0.55
                end
            end
            table.insert(fillPreviewParts, p)
        end
    end
end

local function fillArea(position, size)
    local fixedName = BuilderConfig.selectedBlock
    local fixedBlock = BlockStorage:FindFirstChild(fixedName)
    if not fixedBlock or not fixedBlock:IsA("BasePart") then
        Notify("Error", "Selected block is missing or invalid")
        return
    end

    local center = getGridCenter(position)
    local positions = calculateFillPositions(center, size)

    local expected = size * size * size
    if #positions ~= expected then
        Notify("Error", "Position calculation mismatch")
        return
    end

    runPlacementOperation(positions, fixedBlock, fixedName, "Fill")
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
        if getgenv().VoxelsUnloaded then return end
        if BuilderConfig.isPlacing or not humanoidRootPart or not humanoidRootPart.Parent then
            return
        end

        local lookVector = humanoidRootPart.CFrame.LookVector
        local previewPos = getGridCenter(humanoidRootPart.Position + (lookVector * 12))

        local sizeChanged = lastFillSize ~= BuilderConfig.fillSize
        local posChanged = not lastPreviewPos or (previewPos - lastPreviewPos).Magnitude > 0.1
        local blockChanged = lastSelectedBlock ~= BuilderConfig.selectedBlock

        if not posChanged and not sizeChanged and not blockChanged then
            return
        end

        lastPreviewPos = previewPos
        lastFillSize = BuilderConfig.fillSize
        lastSelectedBlock = BuilderConfig.selectedBlock

        clearPreviews()

        local preview = createTexturedPreview(previewPos)
        table.insert(previewParts, preview)

        if BuilderConfig.showFillPreview then
            showFillPreview(previewPos, BuilderConfig.fillSize)
        end
    end)
end

-- ====================
-- UI
-- ====================

-- Block Selection
local BlockTab = Window:CreateTab("Block Selection", 4483362458)
BlockTab:CreateSection("Choose Block Type")

for _, block in ipairs(BlockStorage:GetChildren()) do
    if block:IsA("BasePart") then
        BlockTab:CreateButton({
            Name = block.Name,
            Callback = function()
                updateSelectedBlock(block.Name)
                Notify("Block Selected", block.Name)
            end
        })
    end
end

-- Instant Build
local BuildTab = Window:CreateTab("Instant Build", 4483362458)
BuildTab:CreateSection("Building")

BuildTab:CreateButton({
    Name = "Place Block",
    Callback = function()
        if not humanoidRootPart or not humanoidRootPart.Parent then
            Notify("Unavailable", "Character is not ready")
            return
        end

        local placePos = getGridCenter(humanoidRootPart.Position + (humanoidRootPart.CFrame.LookVector * 10))

        local fixedBlock = BlockStorage:FindFirstChild(BuilderConfig.blockType)
        if fixedBlock and fixedBlock:IsA("BasePart") then
            placeBlockFixed(placePos, BuilderConfig.currentOperationId, fixedBlock, BuilderConfig.selectedBlock)
        else
            Notify("Error", "Selected block is missing or invalid")
        end
    end
})

BuildTab:CreateButton({
    Name = "Instant 10x10 Platform",
    Callback = function()
        if not humanoidRootPart or not humanoidRootPart.Parent then
            Notify("Unavailable", "Character is not ready")
            return
        end

        local fixedName = BuilderConfig.selectedBlock
        local fixedBlock = BlockStorage:FindFirstChild(fixedName)
        if not fixedBlock or not fixedBlock:IsA("BasePart") then
            Notify("Error", "Selected block missing or invalid")
            return
        end

        local center = getGridCenter(humanoidRootPart.Position)
        local positions = calculatePlatformPositions(center)

        if #positions ~= 100 then
            Notify("Error", "Platform calculation mismatch")
            return
        end

        runPlacementOperation(positions, fixedBlock, fixedName, "Platform")
    end
})

-- Fill Tool
local FillTab = Window:CreateTab("Fill Tool", 4483362458)
FillTab:CreateSection("Custom Size Filling (Unlimited)")

local function setFillSize(size)
    if type(size) ~= "number" or size ~= size or size == math.huge or size == -math.huge then
        Notify("Invalid", "Enter a valid positive number")
        return
    end
    size = math.floor(size)
    if size < 1 then
        Notify("Invalid", "Size must be at least 1")
        return
    end

    BuilderConfig.fillSize = size
    BuilderConfig.customFillSize = size
    lastFillSize = nil
    lastPreviewPos = nil
    clearFillPreview()
    Notify("Fill Size", size .. " blocks per axis")
end

FillTab:CreateInput({
    Name = "Custom Fill Size",
    PlaceholderText = "Any whole number (unlimited)",
    RemoveTextAfterFocusLost = false,
    Callback = function(txt)
        local size = tonumber(txt)
        if size then
            setFillSize(size)
        else
            Notify("Invalid", "Please enter a number")
        end
    end
})

FillTab:CreateButton({ Name = "Small (3×3×3)", Callback = function() setFillSize(3) end })
FillTab:CreateButton({ Name = "Medium (7×7×7)", Callback = function() setFillSize(7) end })
FillTab:CreateButton({ Name = "Large (15×15×15)", Callback = function() setFillSize(15) end })
FillTab:CreateButton({ Name = "Massive (25×25×25)", Callback = function() setFillSize(25) end })

FillTab:CreateToggle({
    Name = "Show Fill Preview",
    CurrentValue = false,
    Callback = function(state)
        BuilderConfig.showFillPreview = state
        if not state then
            clearFillPreview()
        else
            lastFillSize = nil
            lastPreviewPos = nil
        end
    end
})

FillTab:CreateButton({
    Name = "Fill at Cursor",
    Callback = function()
        if not humanoidRootPart or not humanoidRootPart.Parent then
            Notify("Unavailable", "Character is not ready")
            return
        end
        local fillPos = humanoidRootPart.Position + (humanoidRootPart.CFrame.LookVector * 15)
        fillArea(fillPos, BuilderConfig.fillSize)
    end
})

FillTab:CreateButton({
    Name = "Fill Below",
    Callback = function()
        if not humanoidRootPart or not humanoidRootPart.Parent then
            Notify("Unavailable", "Character is not ready")
            return
        end
        local pos = humanoidRootPart.Position
        fillArea(Vector3.new(pos.X, pos.Y - 8, pos.Z), BuilderConfig.fillSize)
    end
})

FillTab:CreateButton({
    Name = "Fill Around",
    Callback = function()
        if not humanoidRootPart or not humanoidRootPart.Parent then
            Notify("Unavailable", "Character is not ready")
            return
        end
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
            lastFillSize = nil
        end
    end
})

PreviewTab:CreateSlider({
    Name = "Preview Transparency",
    Range = {20, 80},
    Increment = 5,
    Suffix = "%",
    CurrentValue = 45,
    Callback = function(value)
        BuilderConfig.previewTransparency = value / 100
        applyTransparencyToExisting()
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
        if not humanoidRootPart or not humanoidRootPart.Parent then return end
        local placePos = getGridCenter(humanoidRootPart.Position + (humanoidRootPart.CFrame.LookVector * 10))

        local fixedBlock = BlockStorage:FindFirstChild(BuilderConfig.blockType)
        if fixedBlock and fixedBlock:IsA("BasePart") then
            placeBlockFixed(placePos, BuilderConfig.currentOperationId, fixedBlock, BuilderConfig.selectedBlock)
        else
            Notify("Error", "Selected block is missing or invalid")
        end
    end
})

KeyTab:CreateKeybind({
    Name = "INSTANT Fill",
    CurrentKeybind = "F",
    HoldToInteract = false,
    Callback = function()
        if not humanoidRootPart or not humanoidRootPart.Parent then return end
        local fillPos = humanoidRootPart.Position + (humanoidRootPart.CFrame.LookVector * 15)
        fillArea(fillPos, BuilderConfig.customFillSize)
    end
})

KeyTab:CreateKeybind({
    Name = "Toggle UI",
    CurrentKeybind = "RightShift",
    HoldToInteract = false,
    Callback = function()
        pcall(function() Rayfield:Toggle() end)
    end
})

KeyTab:CreateKeybind({
    Name = "Cycle Block",
    CurrentKeybind = "Q",
    HoldToInteract = false,
    Callback = function()
        if #AvailableBlocks == 0 then return end

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
        lastFillSize = nil
        Notify("Previews", "Cleared")
    end
})

UtilTab:CreateButton({
    Name = "Emergency Stop",
    Callback = function()
        if not BuilderConfig.isPlacing then
            Notify("Emergency Stop", "No operation is running")
            return
        end
        BuilderConfig.currentOperationId += 1
        clearPreviews()
        clearFillPreview()
        lastPreviewPos = nil
        lastFillSize = nil
        Notify("Emergency Stop", "Cancelling current operation...")
    end
})

UtilTab:CreateParagraph({
    Title = "Settings Info",
    Content = "Positions pre-calculated before placement\nYielding every ~40 blocks"
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
    getgenv().VoxelsUnloaded = true
    BuilderConfig.currentOperationId += 1
    BuilderConfig.isPlacing = false
    BuilderConfig.previewEnabled = false
    BuilderConfig.showFillPreview = false

    if previewConnection then
        previewConnection:Disconnect()
        previewConnection = nil
    end

    if characterConnection then
        characterConnection:Disconnect()
        characterConnection = nil
    end

    clearPreviews()
    clearFillPreview()
    lastPreviewPos = nil
    lastFillSize = nil

    pcall(function() Rayfield:Destroy() end)
    getgenv().GrieferUnload = nil
end

UnloadTab:CreateButton({
    Name = "Unload Script",
    Callback = function()
        getgenv().GrieferUnload()
    end
})

-- Init
getgenv().VoxelsUnloaded = false
BuilderConfig.fillSize = BuilderConfig.customFillSize
startPreviewSystem()
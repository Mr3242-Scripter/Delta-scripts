-- Create the GUI
local screenGui = Instance.new("ScreenGui")
local frame = Instance.new("Frame")
local teleportButton = Instance.new("TextButton")
local destroyButton = Instance.new("TextButton")
local chairButton = Instance.new("TextButton")
local hideShowButton = Instance.new("TextButton")
local randomDoorButton = Instance.new("TextButton")
local luckyBlockButton = Instance.new("TextButton")

-- Set up the screen GUI
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- iPhone sized frame
frame.Parent = screenGui
frame.Size = UDim2.new(0, 220, 0, 300)
frame.Position = UDim2.new(1, -230, 0.5, -150)
frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
frame.BackgroundTransparency = 1

-- Set up the "Level 40" teleport button
teleportButton.Parent = frame
teleportButton.Size = UDim2.new(0, 200, 0, 38)
teleportButton.Position = UDim2.new(0, 10, 0, 10)
teleportButton.Text = "Teleport to Level 40"
teleportButton.TextColor3 = Color3.fromRGB(255, 255, 255)
teleportButton.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
teleportButton.TextScaled = true

-- Set up the "Enter the Lucky Block" button
luckyBlockButton.Parent = frame
luckyBlockButton.Size = UDim2.new(0, 200, 0, 38)
luckyBlockButton.Position = UDim2.new(0, 10, 0, 55)
luckyBlockButton.Text = "Enter the Lucky Block"
luckyBlockButton.TextColor3 = Color3.fromRGB(255, 255, 255)
luckyBlockButton.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
luckyBlockButton.TextScaled = true

-- Set up the "Random Door" button
randomDoorButton.Parent = frame
randomDoorButton.Size = UDim2.new(0, 200, 0, 38)
randomDoorButton.Position = UDim2.new(0, 10, 0, 100)
randomDoorButton.Text = "Random Door"
randomDoorButton.TextColor3 = Color3.fromRGB(255, 255, 255)
randomDoorButton.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
randomDoorButton.TextScaled = true

-- Set up the "Chair" teleport button
chairButton.Parent = frame
chairButton.Size = UDim2.new(0, 200, 0, 38)
chairButton.Position = UDim2.new(0, 10, 0, 145)
chairButton.Text = "Teleport to Chair"
chairButton.TextColor3 = Color3.fromRGB(255, 255, 255)
chairButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
chairButton.TextScaled = true

-- Set up the Destroy button
destroyButton.Parent = frame
destroyButton.Size = UDim2.new(0, 200, 0, 38)
destroyButton.Position = UDim2.new(0, 10, 0, 190)
destroyButton.Text = "Destroy GUI"
destroyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
destroyButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
destroyButton.TextScaled = true

-- Set up the Hide/Show button
hideShowButton.Parent = frame
hideShowButton.Size = UDim2.new(0, 200, 0, 38)
hideShowButton.Position = UDim2.new(0, 10, 0, 235)
hideShowButton.Text = "Hide/Show Buttons"
hideShowButton.TextColor3 = Color3.fromRGB(255, 255, 255)
hideShowButton.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
hideShowButton.TextScaled = true

-- Function to teleport to "Level 40"
local function teleportToLevel40()
    local targetPosition = Vector3.new(1, 866, -1425)
    game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(targetPosition))
end

-- Function to teleport to the "Lucky Block" position
local function enterLuckyBlock()
    local targetPosition = Vector3.new(3, 869, -1486)
    game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(targetPosition))
end

-- Function to teleport to the "Chair" position
local function teleportToChair()
    local targetPosition = Vector3.new(11, 4131, 384)
    game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(targetPosition))
end

-- Function to teleport to a random door position
local function teleportRandomDoor()
    local randomPositions = {
        Vector3.new(-671, 4092, -400),
        Vector3.new(-658, 4092, -400),
        Vector3.new(-644, 4092, -400),
        Vector3.new(-631, 4092, -400)
    }

    local randomPosition =
        randomPositions[math.random(1, #randomPositions)]

    game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(
        CFrame.new(randomPosition)
    )
end

-- Function to destroy the GUI
local function destroyGui()
    screenGui:Destroy()
end

-- Function to toggle hide/show for buttons
local function toggleHideShow()
    local isVisible = teleportButton.Visible

    teleportButton.Visible = not isVisible
    luckyBlockButton.Visible = not isVisible
    chairButton.Visible = not isVisible
    destroyButton.Visible = not isVisible
    randomDoorButton.Visible = not isVisible
end

-- Connect the buttons to their functions
teleportButton.MouseButton1Click:Connect(teleportToLevel40)
luckyBlockButton.MouseButton1Click:Connect(enterLuckyBlock)
chairButton.MouseButton1Click:Connect(teleportToChair)
randomDoorButton.MouseButton1Click:Connect(teleportRandomDoor)
destroyButton.MouseButton1Click:Connect(destroyGui)
hideShowButton.MouseButton1Click:Connect(toggleHideShow)

-- Make the GUI draggable
local dragging = false
local dragStart = nil
local startPos = nil

frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
    end
end)

frame.InputChanged:Connect(function(input)
    if dragging then
        local delta = input.Position - dragStart

        frame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

frame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)
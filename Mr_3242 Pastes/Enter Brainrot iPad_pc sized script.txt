-- Create the GUI
local screenGui = Instance.new("ScreenGui")
local frame = Instance.new("Frame")
local teleportButton = Instance.new("TextButton")
local destroyButton = Instance.new("TextButton")
local chairButton = Instance.new("TextButton")
local hideShowButton = Instance.new("TextButton")  -- New Hide/Show button
local randomDoorButton = Instance.new("TextButton") -- Random Door button
local luckyBlockButton = Instance.new("TextButton")  -- New "Enter the Lucky Block" button
 
-- Set up the screen GUI
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
frame.Parent = screenGui
frame.Size = UDim2.new(0, 300, 0, 400)  -- Adjusted size (300x400) to fit all buttons
frame.Position = UDim2.new(1, -310, 0.5, -150)  -- Position on the right side of the screen
frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
frame.BackgroundTransparency = 1  -- Hide the black border (make the background transparent)
 
-- Set up the "Level 40" teleport button
teleportButton.Parent = frame
teleportButton.Size = UDim2.new(0, 280, 0, 50)
teleportButton.Position = UDim2.new(0, 10, 0, 10)
teleportButton.Text = "Teleport to Level 40"
teleportButton.TextColor3 = Color3.fromRGB(255, 255, 255)
teleportButton.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
 
-- Set up the "Enter the Lucky Block" button
luckyBlockButton.Parent = frame
luckyBlockButton.Size = UDim2.new(0, 280, 0, 50)
luckyBlockButton.Position = UDim2.new(0, 10, 0, 70)  -- Positioned below "Teleport to Level 40"
luckyBlockButton.Text = "Enter the Lucky Block"
luckyBlockButton.TextColor3 = Color3.fromRGB(255, 255, 255)
luckyBlockButton.BackgroundColor3 = Color3.fromRGB(255, 215, 0)  -- Yellow color for lucky block
 
-- Set up the "Random Door" button
randomDoorButton.Parent = frame
randomDoorButton.Size = UDim2.new(0, 280, 0, 50)
randomDoorButton.Position = UDim2.new(0, 10, 0, 130)
randomDoorButton.Text = "Random Door"
randomDoorButton.TextColor3 = Color3.fromRGB(255, 255, 255)
randomDoorButton.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
 
-- Set up the "Chair" teleport button
chairButton.Parent = frame
chairButton.Size = UDim2.new(0, 280, 0, 50)
chairButton.Position = UDim2.new(0, 10, 0, 190)
chairButton.Text = "Teleport to Chair"
chairButton.TextColor3 = Color3.fromRGB(255, 255, 255)
chairButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
 
-- Set up the Destroy button
destroyButton.Parent = frame
destroyButton.Size = UDim2.new(0, 280, 0, 50)
destroyButton.Position = UDim2.new(0, 10, 0, 250)
destroyButton.Text = "Destroy GUI"
destroyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
destroyButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
 
-- Set up the Hide/Show button
hideShowButton.Parent = frame
hideShowButton.Size = UDim2.new(0, 280, 0, 50)
hideShowButton.Position = UDim2.new(0, 10, 0, 310)
hideShowButton.Text = "Hide/Show Buttons"
hideShowButton.TextColor3 = Color3.fromRGB(255, 255, 255)
hideShowButton.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
 
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
    local randomPosition = randomPositions[math.random(1, #randomPositions)]
    game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(randomPosition))
end
 
-- Function to destroy the GUI
local function destroyGui()
    screenGui:Destroy()
end
 
-- Function to toggle hide/show for buttons
local function toggleHideShow()
    local isVisible = teleportButton.Visible  -- Check if the teleport button is visible
    
    -- Toggle visibility for buttons (except the Hide/Show button itself)
    teleportButton.Visible = not isVisible
    luckyBlockButton.Visible = not isVisible
    chairButton.Visible = not isVisible
    destroyButton.Visible = not isVisible
    randomDoorButton.Visible = not isVisible
end
 
-- Connect the buttons to their functions
teleportButton.MouseButton1Click:Connect(teleportToLevel40)
luckyBlockButton.MouseButton1Click:Connect(enterLuckyBlock)  -- Connect the new Lucky Block button
chairButton.MouseButton1Click:Connect(teleportToChair)
randomDoorButton.MouseButton1Click:Connect(teleportRandomDoor)
destroyButton.MouseButton1Click:Connect(destroyGui)
hideShowButton.MouseButton1Click:Connect(toggleHideShow)
 
-- Make the GUI draggable (only the frame)
local dragging = false
local dragStart = nil
local startPos = nil
 
-- Event to begin dragging the frame
frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
    end
end)
 
-- Event to update the frame's position while dragging
frame.InputChanged:Connect(function(input)
    if dragging then
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
 
-- Event to stop dragging when mouse button is released
frame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local hrp = character:WaitForChild("HumanoidRootPart")
local head = character:FindFirstChild("Head")
local leftArm = character:FindFirstChild("Left Arm") or character:FindFirstChild("LeftHand")
local rightArm = character:FindFirstChild("Right Arm") or character:FindFirstChild("RightHand")

local cam = Workspace.CurrentCamera

-- ====================
-- Hide original character
-- ====================
for _, part in ipairs(character:GetDescendants()) do
	if part:IsA("BasePart") then
		part.Transparency = 1
		part.CanCollide = false
	elseif part:IsA("Accessory") and part:FindFirstChild("Handle") then
		part.Handle.Transparency = 1
		part.Handle.CanCollide = false
	end
end

-- ====================
-- Clone random VR character
-- ====================
local vrCharacters = Workspace:WaitForChild("VrCharacters"):GetChildren()
local randomVR = vrCharacters[math.random(1,#vrCharacters)]
local vrClone = randomVR:Clone()

-- Remove GUI and Screen parts
for _, name in ipairs({"NameGui","HealthGui","DevGui","Screen"}) do
	local obj = vrClone:FindFirstChild(name)
	if obj then obj:Destroy() end
end

-- Disable collisions and anchoring
for _, part in ipairs(vrClone:GetDescendants()) do
	if part:IsA("BasePart") then
		part.Anchored = true
		part.CanCollide = false
	elseif part:IsA("AlignPosition") or part:IsA("AlignOrientation") or part:IsA("Motor6D") then
		part:Destroy()
	end
end

-- Move VR rig to humanoid position and parent
if vrClone.PrimaryPart == nil then
	vrClone.PrimaryPart = vrClone:FindFirstChildWhichIsA("BasePart")
end
vrClone:SetPrimaryPartCFrame(hrp.CFrame)
vrClone.Parent = Workspace

-- Continuous follow of humanoid
RunService.RenderStepped:Connect(function()
	if vrClone.PrimaryPart then
		vrClone:SetPrimaryPartCFrame(hrp.CFrame)
	end
end)

-- Attach Left/Right folders to arms visually
local function attachFolderToArm(folder, arm, offset)
	if folder and arm then
		for _, part in ipairs(folder:GetDescendants()) do
			if part:IsA("BasePart") then
				part.Anchored = false
				part.CanCollide = false
				RunService.RenderStepped:Connect(function()
					part.CFrame = arm.CFrame * CFrame.new(offset)
				end)
			end
		end
	end
end

attachFolderToArm(vrClone:FindFirstChild("Left"), leftArm, Vector3.new(0.5,0,0))
attachFolderToArm(vrClone:FindFirstChild("Right"), rightArm, Vector3.new(-0.5,0,0))

-- Reparent Noodle1 and Noodle2 to Left/Right folders
local leftFolder = vrClone:FindFirstChild("Left")
local rightFolder = vrClone:FindFirstChild("Right")

local noodle1 = vrClone:FindFirstChild("Noodle1", true)
local noodle2 = vrClone:FindFirstChild("Noodle2", true)

if noodle1 and leftFolder then
	noodle1.Parent = leftFolder
end
if noodle2 and rightFolder then
	noodle2.Parent = rightFolder
end

-- Camera follows humanoid
cam.CameraSubject = humanoid
cam.CameraType = Enum.CameraType.Custom

-- ====================
-- FLOAT GUI
-- ====================
local gui = Instance.new("ScreenGui")
gui.Name = "VRFloatGUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Outer purple border
local border = Instance.new("Frame")
border.Size = UDim2.new(0,220,0,120)
border.Position = UDim2.new(0.5,-110,0.5,-60)
border.BackgroundColor3 = Color3.fromRGB(160,0,200)
border.BackgroundTransparency = 0.5
border.BorderSizePixel = 0
border.Parent = gui

-- Inner dark panel
local panel = Instance.new("Frame")
panel.Size = UDim2.new(1,-10,1,-10)
panel.Position = UDim2.new(0,5,0,5)
panel.BackgroundColor3 = Color3.fromRGB(30,30,30)
panel.Parent = border

-- Top bar for dragging
local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1,0,0,25)
topBar.BackgroundColor3 = Color3.fromRGB(120,0,160)
topBar.Parent = panel

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,1,0)
title.BackgroundTransparency = 1
title.Text = "VR Float GUI"
title.TextScaled = true
title.TextColor3 = Color3.new(1,1,1)
title.Parent = topBar

-- Buttons
local floatButton = Instance.new("TextButton")
floatButton.Size = UDim2.new(0,200,0,35)
floatButton.Position = UDim2.new(0,10,0,35)
floatButton.Text = "Float: OFF"
floatButton.TextScaled = true
floatButton.BackgroundColor3 = Color3.fromRGB(255,0,0)
floatButton.TextColor3 = Color3.new(1,1,1)
floatButton.Parent = panel

local destroyButton = Instance.new("TextButton")
destroyButton.Size = UDim2.new(0,200,0,35)
destroyButton.Position = UDim2.new(0,10,0,75)
destroyButton.Text = "Destroy GUI"
destroyButton.TextScaled = true
destroyButton.BackgroundColor3 = Color3.fromRGB(255,70,70)
destroyButton.TextColor3 = Color3.new(1,1,1)
destroyButton.Parent = panel

-- Drag functionality
local dragEnabled = true
local dragging = false
local dragStart, startPos

topBar.InputBegan:Connect(function(input)
	if (input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch) and dragEnabled then
		dragging = true
		dragStart = input.Position
		startPos = border.Position
		input.Changed:Connect(function()
			if input.UserInputState==Enum.UserInputState.End then dragging=false end
		end)
	end
end)

topBar.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch) then
		local delta = input.Position - dragStart
		border.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset+delta.X, startPos.Y.Scale, startPos.Y.Offset+delta.Y)
	end
end)

-- Float functionality
local floating = false
local floatSpeed = 25

floatButton.MouseButton1Click:Connect(function()
	floating = not floating
	if floating then
		floatButton.Text = "Float: ON"
		floatButton.BackgroundColor3 = Color3.fromRGB(0,255,0)
		humanoid.PlatformStand = true
	else
		floatButton.Text = "Float: OFF"
		floatButton.BackgroundColor3 = Color3.fromRGB(255,0,0)
		humanoid.PlatformStand = false
		hrp.Velocity = Vector3.new(0,0,0)
	end
end)

RunService.RenderStepped:Connect(function()
	if floating then
		hrp.Velocity = cam.CFrame.LookVector * floatSpeed
	end
end)

-- Destroy GUI
destroyButton.MouseButton1Click:Connect(function()
	floating = false
	humanoid.PlatformStand = false
	gui:Destroy()
end)

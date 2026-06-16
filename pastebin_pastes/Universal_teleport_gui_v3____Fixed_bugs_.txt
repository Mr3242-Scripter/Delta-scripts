-- TELEPORT GUI V3 FIXED WITH POSITION UPDATE

local player = game.Players.LocalPlayer
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local mouse = player:GetMouse()

-- Variables
local dragEnabled = true
local dragging = false
local dragStart, startPos
local tpMouseEnabled = false

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "TeleportGUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- MAIN FRAME
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0,350,0,500)
frame.Position = UDim2.new(1,-360,0.5,-250)
frame.BackgroundColor3 = Color3.fromRGB(160,0,200)
frame.BorderSizePixel = 0
frame.Parent = gui

-- TOP BAR
local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1,0,0,30)
topBar.BackgroundColor3 = Color3.fromRGB(120,0,160)
topBar.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,1,0)
title.BackgroundTransparency = 1
title.Text = "Teleport GUI"
title.TextScaled = true
title.TextColor3 = Color3.new(1,1,1)
title.Parent = topBar

-- INNER
local inner = Instance.new("Frame")
inner.Size = UDim2.new(1,-10,1,-40)
inner.Position = UDim2.new(0,5,0,35)
inner.BackgroundColor3 = Color3.fromRGB(30,30,30)
inner.Parent = frame

-- POSITION LABEL
local posLabel = Instance.new("TextLabel")
posLabel.Size = UDim2.new(1,-20,0,30)
posLabel.Position = UDim2.new(0,10,0,5)
posLabel.BackgroundTransparency = 1
posLabel.TextScaled = true
posLabel.TextColor3 = Color3.new(1,1,1)
posLabel.Text = "Position: 0,0,0"
posLabel.Parent = inner

-- GOTO POSITION
local gotoPosBox = Instance.new("TextBox")
gotoPosBox.Size = UDim2.new(1,-20,0,35)
gotoPosBox.Position = UDim2.new(0,10,0,40)
gotoPosBox.PlaceholderText = "Goto Position (x,y,z)"
gotoPosBox.TextScaled = true
gotoPosBox.BackgroundColor3 = Color3.fromRGB(70,70,255)
gotoPosBox.TextColor3 = Color3.new(1,1,1)
gotoPosBox.Parent = inner

local gotoPosButton = Instance.new("TextButton")
gotoPosButton.Size = UDim2.new(1,-20,0,35)
gotoPosButton.Position = UDim2.new(0,10,0,80)
gotoPosButton.Text = "Teleport to Position"
gotoPosButton.TextScaled = true
gotoPosButton.BackgroundColor3 = Color3.fromRGB(0,200,100)
gotoPosButton.TextColor3 = Color3.new(1,1,1)
gotoPosButton.Parent = inner

-- GOTO PLAYER
local gotoPlayerBox = Instance.new("TextBox")
gotoPlayerBox.Size = UDim2.new(0.7,0,0,35)
gotoPlayerBox.Position = UDim2.new(0,10,0,120)
gotoPlayerBox.PlaceholderText = "Goto Player"
gotoPlayerBox.TextScaled = true
gotoPlayerBox.BackgroundColor3 = Color3.fromRGB(70,70,255)
gotoPlayerBox.TextColor3 = Color3.new(1,1,1)
gotoPlayerBox.Parent = inner

local gotoPlayerButton = Instance.new("TextButton")
gotoPlayerButton.Size = UDim2.new(0.28,0,0,35)
gotoPlayerButton.Position = UDim2.new(0.72,0,0,120)
gotoPlayerButton.Text = "Teleport"
gotoPlayerButton.TextScaled = true
gotoPlayerButton.BackgroundColor3 = Color3.fromRGB(0,200,100)
gotoPlayerButton.TextColor3 = Color3.new(1,1,1)
gotoPlayerButton.Parent = inner

-- COPY POSITION
local copyButton = Instance.new("TextButton")
copyButton.Size = UDim2.new(1,-20,0,35)
copyButton.Position = UDim2.new(0,10,0,160)
copyButton.Text = "Copy Position"
copyButton.TextScaled = true
copyButton.BackgroundColor3 = Color3.fromRGB(0,150,255)
copyButton.TextColor3 = Color3.new(1,1,1)
copyButton.Parent = inner

-- DRAG TOGGLE
local dragButton = Instance.new("TextButton")
dragButton.Size = UDim2.new(1,-20,0,35)
dragButton.Position = UDim2.new(0,10,0,200)
dragButton.Text = "Drag GUI: ON"
dragButton.TextScaled = true
dragButton.BackgroundColor3 = Color3.fromRGB(0,200,0)
dragButton.TextColor3 = Color3.new(1,1,1)
dragButton.Parent = inner

-- TP TO MOUSE
local mouseButton = Instance.new("TextButton")
mouseButton.Size = UDim2.new(1,-20,0,35)
mouseButton.Position = UDim2.new(0,10,0,240)
mouseButton.Text = "TP To Mouse: OFF"
mouseButton.TextScaled = true
mouseButton.BackgroundColor3 = Color3.fromRGB(255,0,100)
mouseButton.TextColor3 = Color3.new(1,1,1)
mouseButton.Parent = inner

-- RECENT TELEPORTS BUTTON
local recentButton = Instance.new("TextButton")
recentButton.Size = UDim2.new(1,-20,0,35)
recentButton.Position = UDim2.new(0,10,0,280)
recentButton.Text = "Show Recent Teleports"
recentButton.TextScaled = true
recentButton.BackgroundColor3 = Color3.fromRGB(200,0,255)
recentButton.TextColor3 = Color3.new(1,1,1)
recentButton.Parent = inner

-- PLAYER LIST BUTTON
local playerListButton = Instance.new("TextButton")
playerListButton.Size = UDim2.new(1,-20,0,35)
playerListButton.Position = UDim2.new(0,10,0,320)
playerListButton.Text = "Show Player List"
playerListButton.TextScaled = true
playerListButton.BackgroundColor3 = Color3.fromRGB(100,200,255)
playerListButton.TextColor3 = Color3.new(1,1,1)
playerListButton.Parent = inner

-- DESTROY GUI
local destroyButton = Instance.new("TextButton")
destroyButton.Size = UDim2.new(1,-20,0,35)
destroyButton.Position = UDim2.new(0,10,0,360)
destroyButton.Text = "Destroy GUI"
destroyButton.TextScaled = true
destroyButton.BackgroundColor3 = Color3.fromRGB(255,70,70)
destroyButton.TextColor3 = Color3.new(1,1,1)
destroyButton.Parent = inner

-- ====================
-- RECENT TELEPORTS GUI
-- ====================
local recentGui = Instance.new("Frame")
recentGui.Size = UDim2.new(0,500,0,400)
recentGui.Position = UDim2.new(0.5,-250,0.5,-200)
recentGui.BackgroundColor3 = Color3.fromRGB(50,50,50)
recentGui.Visible = false
recentGui.Parent = gui

local recentScroll = Instance.new("ScrollingFrame")
recentScroll.Size = UDim2.new(1,-10,1,-10)
recentScroll.Position = UDim2.new(0,5,0,5)
recentScroll.BackgroundTransparency = 1
recentScroll.ScrollBarThickness = 10
recentScroll.Parent = recentGui

local recentLayout = Instance.new("UIListLayout")
recentLayout.Padding = UDim.new(0,5)
recentLayout.Parent = recentScroll

-- ====================
-- PLAYER LIST GUI
-- ====================
local listGui = Instance.new("Frame")
listGui.Size = UDim2.new(0,500,0,400)
listGui.Position = UDim2.new(0.5,-250,0.5,-200)
listGui.BackgroundColor3 = Color3.fromRGB(70,70,70)
listGui.Visible = false
listGui.Parent = gui

local listScroll = Instance.new("ScrollingFrame")
listScroll.Size = UDim2.new(1,-10,1,-10)
listScroll.Position = UDim2.new(0,5,0,5)
listScroll.BackgroundTransparency = 1
listScroll.ScrollBarThickness = 10
listScroll.Parent = listGui

local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0,5)
listLayout.Parent = listScroll

-- ====================
-- FUNCTIONS
-- ====================

-- Drag toggle
dragButton.MouseButton1Click:Connect(function()
	dragEnabled = not dragEnabled
	dragButton.Text = dragEnabled and "Drag GUI: ON" or "Drag GUI: OFF"
	dragButton.BackgroundColor3 = dragEnabled and Color3.fromRGB(0,200,0) or Color3.fromRGB(200,0,0)
end)

-- Drag logic
topBar.InputBegan:Connect(function(input)
	if (input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch) and dragEnabled then
		dragging = true
		dragStart = input.Position
		startPos = frame.Position
		input.Changed:Connect(function()
			if input.UserInputState==Enum.UserInputState.End then dragging=false end
		end)
	end
end)

topBar.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch) then
		local delta = input.Position - dragStart
		frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset+delta.X, startPos.Y.Scale, startPos.Y.Offset+delta.Y)
	end
end)

-- TP Mouse
mouseButton.MouseButton1Click:Connect(function()
	tpMouseEnabled = not tpMouseEnabled
	mouseButton.Text = tpMouseEnabled and "TP To Mouse: ON" or "TP To Mouse: OFF"
	mouseButton.BackgroundColor3 = tpMouseEnabled and Color3.fromRGB(0,200,0) or Color3.fromRGB(255,0,100)
end)

mouse.Button1Down:Connect(function()
	if tpMouseEnabled and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
		local targetPos = mouse.Hit.Position + Vector3.new(0,5,0)
		player.Character.HumanoidRootPart.CFrame = CFrame.new(targetPos)
	end
end)

-- Copy position
copyButton.MouseButton1Click:Connect(function()
	if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
		local pos = player.Character.HumanoidRootPart.Position
		local text = math.floor(pos.X)..","..math.floor(pos.Y)..","..math.floor(pos.Z)
		gotoPosBox.Text = text
		pcall(function() setclipboard(text) end)
	end
end)

-- Teleport position
gotoPosButton.MouseButton1Click:Connect(function()
	local coords = string.split(gotoPosBox.Text,",")
	if #coords==3 then
		local x,y,z = tonumber(coords[1]),tonumber(coords[2]),tonumber(coords[3])
		if x and y and z and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			local pos = Vector3.new(x,y,z)
			player.Character.HumanoidRootPart.CFrame = CFrame.new(pos)
			
			-- Add recent
			local entry = Instance.new("Frame")
			entry.Size = UDim2.new(1,-10,0,50)
			entry.BackgroundColor3 = Color3.fromRGB(100,100,255)
			entry.Parent = recentScroll

			local label = Instance.new("TextLabel")
			label.Size = UDim2.new(0.75,0,1,0)
			label.Position = UDim2.new(0,5,0,0)
			label.BackgroundTransparency = 1
			label.TextScaled = true
			label.TextColor3 = Color3.new(1,1,1)
			label.Text = math.floor(pos.X)..","..math.floor(pos.Y)..","..math.floor(pos.Z)
			label.Parent = entry

			local tp = Instance.new("TextButton")
			tp.Size = UDim2.new(0.25,-5,1,0)
			tp.Position = UDim2.new(0.75,0,0,0)
			tp.Text = "TP"
			tp.TextScaled = true
			tp.BackgroundColor3 = Color3.fromRGB(0,200,100)
			tp.TextColor3 = Color3.new(1,1,1)
			tp.Parent = entry

			tp.MouseButton1Click:Connect(function()
				if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
					player.Character.HumanoidRootPart.CFrame = CFrame.new(pos)
				end
			end)

			recentScroll.CanvasSize = UDim2.new(0,0,0,recentLayout.AbsoluteContentSize.Y)
		end
	end
end)

-- Show/hide middle GUIs
recentButton.MouseButton1Click:Connect(function()
	recentGui.Visible = not recentGui.Visible
	if recentGui.Visible then listGui.Visible = false end
end)

playerListButton.MouseButton1Click:Connect(function()
	listGui.Visible = not listGui.Visible
	if listGui.Visible then recentGui.Visible = false end
end)

-- Player list update
local function updatePlayerList()
	for _,v in pairs(listScroll:GetChildren()) do
		if v:IsA("Frame") then v:Destroy() end
	end

	for _,p in pairs(Players:GetPlayers()) do
		local entry = Instance.new("Frame")
		entry.Size = UDim2.new(1,-10,0,50)
		entry.BackgroundColor3 = Color3.fromRGB(100,150,200)
		entry.Parent = listScroll

		local label = Instance.new("TextLabel")
		label.Size = UDim2.new(0.75,0,1,0)
		label.Position = UDim2.new(0,5,0,0)
		label.BackgroundTransparency = 1
		label.TextScaled = true
		label.TextColor3 = Color3.new(1,1,1)
		label.Text = p.Name.." | "..p.DisplayName
		label.Parent = entry

		local tp = Instance.new("TextButton")
		tp.Size = UDim2.new(0.25,-5,1,0)
		tp.Position = UDim2.new(0.75,0,0,0)
		tp.Text = "TP"
		tp.TextScaled = true
		tp.BackgroundColor3 = Color3.fromRGB(0,200,100)
		tp.TextColor3 = Color3.new(1,1,1)
		tp.Parent = entry

		tp.MouseButton1Click:Connect(function()
			if p.Character and p.Character:FindFirstChild("HumanoidRootPart") and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
				player.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame
			end
		end)
	end

	listScroll.CanvasSize = UDim2.new(0,0,0,listLayout.AbsoluteContentSize.Y)
end

Players.PlayerAdded:Connect(updatePlayerList)
Players.PlayerRemoving:Connect(updatePlayerList)
updatePlayerList()

-- Teleport to player
gotoPlayerButton.MouseButton1Click:Connect(function()
	local text = gotoPlayerBox.Text:lower()
	for _,p in pairs(Players:GetPlayers()) do
		if (p.Name:lower():sub(1,#text) == text or p.DisplayName:lower():sub(1,#text) == text) and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			player.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame
			break
		end
	end
end)

-- Autocomplete
gotoPlayerBox.FocusLost:Connect(function()
	local input = gotoPlayerBox.Text:lower()
	for _,p in pairs(Players:GetPlayers()) do
		if p.Name:lower():sub(1,#input) == input or p.DisplayName:lower():sub(1,#input) == input then
			gotoPlayerBox.Text = p.Name
			break
		end
	end
end)

-- Destroy GUI
destroyButton.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

-- ====================
-- REAL-TIME POSITION UPDATE
-- ====================
RunService.RenderStepped:Connect(function()
	if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
		local pos = player.Character.HumanoidRootPart.Position
		posLabel.Text = string.format("Position: %d, %d, %d", math.floor(pos.X), math.floor(pos.Y), math.floor(pos.Z))
	end
end)
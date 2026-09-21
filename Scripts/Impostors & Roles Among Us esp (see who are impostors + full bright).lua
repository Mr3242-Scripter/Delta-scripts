local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Camera = workspace.CurrentCamera

local LocalPlayer = Players.LocalPlayer

local espEnabled = false
local brightEnabled = false

local ESP = {}

-- ESP creation
local function createESP(player)
	if player == LocalPlayer then return end

	local box = Drawing.new("Square")
	box.Thickness = 2
	box.Filled = false
	box.Visible = false

	local text = Drawing.new("Text")
	text.Size = 16
	text.Center = true
	text.Outline = true
	text.Visible = false

	ESP[player] = {box = box, text = text}
end

for _,p in pairs(Players:GetPlayers()) do
	createESP(p)
end

Players.PlayerAdded:Connect(createESP)

-- ESP LOOP
RunService.RenderStepped:Connect(function()

	for player,data in pairs(ESP) do

		local box = data.box
		local text = data.text

		if not espEnabled then
			box.Visible = false
			text.Visible = false
			continue
		end

		local char = player.Character
		local root = char and char:FindFirstChild("HumanoidRootPart")
		local hum = char and char:FindFirstChildOfClass("Humanoid")

		local states = player:FindFirstChild("PublicStates")

		local inGame,loaded,alive = false,false,false

		if states then
			local ig = states:FindFirstChild("InGame")
			local ld = states:FindFirstChild("Loaded")
			local al = states:FindFirstChild("Alive")

			if ig then inGame = ig.Value end
			if ld then loaded = ld.Value end
			if al then alive = al.Value end
		end

		if root and hum and inGame and loaded and alive then

			local pos, visible = Camera:WorldToViewportPoint(root.Position)

			if visible then

				local dist = (root.Position - Camera.CFrame.Position).Magnitude
				local scale = math.clamp(120/dist,0.5,3)

				local w = 35 * scale
				local h = 55 * scale

				box.Size = Vector2.new(w,h)
				box.Position = Vector2.new(pos.X - w/2,pos.Y - h/2)
				box.Visible = true

				local role = "Unknown"
				local sub = ""

				if states then
					local r = states:FindFirstChild("Role")
					local s = states:FindFirstChild("SubRole")

					if r then role = tostring(r.Value) end
					if s then sub = tostring(s.Value) end
				end

				text.Text = player.Name.." | "..role.." "..sub
				text.Position = Vector2.new(pos.X,pos.Y - h/2 - 16)
				text.Visible = true

				if string.lower(role):find("impost") then
					box.Color = Color3.fromRGB(255,80,80)
					text.Color = Color3.fromRGB(255,80,80)
				else
					box.Color = Color3.fromRGB(80,200,255)
					text.Color = Color3.fromRGB(80,200,255)
				end

			else
				box.Visible = false
				text.Visible = false
			end

		else
			box.Visible = false
			text.Visible = false
		end

	end
end)

-- FULLBRIGHT
local function updateBright()

	if brightEnabled then
		Lighting.Brightness = 4
		Lighting.ClockTime = 14
		Lighting.FogEnd = 100000
		Lighting.GlobalShadows = false
	else
		Lighting.Brightness = 1
		Lighting.GlobalShadows = true
	end

end

-- GUI
local gui = Instance.new("ScreenGui")
gui.Parent = LocalPlayer:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0,200,0,120)
frame.Position = UDim2.new(0,20,0.5,-60)
frame.BackgroundColor3 = Color3.fromRGB(35,35,50)
frame.Parent = gui
frame.Active = true
frame.Draggable = true
Instance.new("UICorner",frame)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,30)
title.Text = "IMPOSTERS TOOL"
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.new(1,1,1)
title.TextScaled = true
title.Parent = frame

-- ESP BUTTON
local espBtn = Instance.new("TextButton")
espBtn.Size = UDim2.new(0.9,0,0,35)
espBtn.Position = UDim2.new(0.05,0,0.35,0)
espBtn.Text = "ESP OFF"
espBtn.BackgroundColor3 = Color3.fromRGB(255,80,80)
espBtn.TextColor3 = Color3.new(1,1,1)
espBtn.Font = Enum.Font.GothamBold
espBtn.TextScaled = true
espBtn.Parent = frame
Instance.new("UICorner",espBtn)

espBtn.MouseButton1Click:Connect(function()

	espEnabled = not espEnabled

	if espEnabled then
		espBtn.Text = "ESP ON"
		espBtn.BackgroundColor3 = Color3.fromRGB(80,220,120)
	else
		espBtn.Text = "ESP OFF"
		espBtn.BackgroundColor3 = Color3.fromRGB(255,80,80)
	end

end)

-- FULLBRIGHT BUTTON
local brightBtn = Instance.new("TextButton")
brightBtn.Size = UDim2.new(0.9,0,0,35)
brightBtn.Position = UDim2.new(0.05,0,0.7,0)
brightBtn.Text = "FULLBRIGHT"
brightBtn.BackgroundColor3 = Color3.fromRGB(80,150,255)
brightBtn.TextColor3 = Color3.new(1,1,1)
brightBtn.Font = Enum.Font.GothamBold
brightBtn.TextScaled = true
brightBtn.Parent = frame
Instance.new("UICorner",brightBtn)

brightBtn.MouseButton1Click:Connect(function()

	brightEnabled = not brightEnabled
	updateBright()

	if brightEnabled then
		brightBtn.BackgroundColor3 = Color3.fromRGB(80,220,120)
	else
		brightBtn.BackgroundColor3 = Color3.fromRGB(80,150,255)
	end

end)
local p = game:GetService("Players")
local rs = game:GetService("RunService")
local uis = game:GetService("UserInputService")
local ts = game:GetService("TweenService")
local lp = p.LocalPlayer
local mouse = lp:GetMouse()
local cam = workspace.CurrentCamera
local active = false
local conn = nil
local char = lp.Character or lp.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")
local hrp = char:WaitForChild("HumanoidRootPart")
local off_val = Vector3.new(2.2, 0.7, 0)
local transition_info = TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

local g = Instance.new("ScreenGui")
g.Name = "UniversalSystem"
g.ResetOnSpawn = false
g.IgnoreGuiInset = true
g.Parent = lp:WaitForChild("PlayerGui")

local b = Instance.new("ImageButton")
b.Name = "ShiftLockButton"
b.Size = UDim2.new(0, 55, 0, 55)
b.Position = UDim2.new(0.9, -35, 0.5, -27)
b.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
b.BackgroundTransparency = 0.4
b.Image = "rbxasset://textures/ui/mouseLock_off@2x.png"
b.Visible = uis.TouchEnabled
b.ZIndex = 10
b.Parent = g

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(1, 0)
corner.Parent = b

local stroke = Instance.new("UIStroke")
stroke.Thickness = 2.5
stroke.Color = Color3.fromRGB(255, 255, 255)
stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
stroke.Parent = b

local cur = Instance.new("ImageLabel")
cur.Name = "CustomCursor"
cur.Size = UDim2.new(0, 28, 0, 28)
cur.Position = UDim2.new(0.5, 0, 0.5, 0)
cur.AnchorPoint = Vector2.new(0.5, 0.5)
cur.BackgroundTransparency = 1
cur.Image = "rbxasset://textures/MouseLockedCursor.png"
cur.ImageColor3 = Color3.fromRGB(255, 255, 255)
cur.Visible = false
cur.ZIndex = 5
cur.Parent = g

local function sync(state)
	active = state
	char = lp.Character
	if char then 
		hum = char:FindFirstChildOfClass("Humanoid") 
		hrp = char:FindFirstChild("HumanoidRootPart") 
	end

	if active then
		b.Image = "rbxasset://textures/ui/mouseLock_on@2x.png"
		b.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		b.ImageColor3 = Color3.fromRGB(0, 0, 0)
		cur.Visible = true
		if hum then hum.AutoRotate = false end
		
		if conn then conn:Disconnect() end
		conn = rs.RenderStepped:Connect(function()
			if active and char and hrp and hum and hum.Health > 0 then
				local cam_cf = cam.CFrame
				local _, y, _ = cam_cf:ToEulerAnglesYXZ()
				hrp.CFrame = hrp.CFrame:Lerp(CFrame.new(hrp.Position) * CFrame.Angles(0, y, 0), 0.4)
				cam.SocketOffset = cam.SocketOffset:Lerp(off_val, 0.15)
				uis.MouseBehavior = Enum.MouseBehavior.LockCenter
			else
				uis.MouseBehavior = Enum.MouseBehavior.Default
			end
		end)
	else
		b.Image = "rbxasset://textures/ui/mouseLock_off@2x.png"
		b.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		b.ImageColor3 = Color3.fromRGB(255, 255, 255)
		cur.Visible = false
		if conn then conn:Disconnect() conn = nil end
		if hum then hum.AutoRotate = true end
		ts:Create(cam, transition_info, {SocketOffset = Vector3.new(0, 0, 0)}):Play()
		uis.MouseBehavior = Enum.MouseBehavior.Default
	end
end

b.MouseButton1Click:Connect(function()
	sync(not active)
end)

uis.InputBegan:Connect(function(input, processed)
	if not processed then
		if input.KeyCode == Enum.KeyCode.LeftShift or input.KeyCode == Enum.KeyCode.RightShift then
			sync(not active)
		end
	end
end)

lp.CharacterAdded:Connect(function(nc)
	char = nc
	hum = nc:WaitForChild("Humanoid")
	hrp = nc:WaitForChild("HumanoidRootPart")
	task.wait(0.1)
	if active then
		hum.AutoRotate = false
	end
end)

rs.Heartbeat:Connect(function()
	if active then
		if hum and hum.Health <= 0 then
			sync(false)
		end
	end
end)

sync(true)
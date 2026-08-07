local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")
local TweenService = game:GetService("TweenService")
local GuiService = game:GetService("GuiService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

------------------------------------------------
-- STATE
------------------------------------------------
local bootsOn = false
local iceCooldown = 0
local lastHealth = nil
local damageCooldown = 1.5
local lastDamageTime = 0

------------------------------------------------
-- POSITION CORE
------------------------------------------------
local BASE_X = 12
local BASE_Y = 12

local TOPBAR = GuiService:GetGuiInset().Y
local BASE_POS = UDim2.new(0, BASE_X, 0, TOPBAR + BASE_Y)

------------------------------------------------
-- GUI ROOT
------------------------------------------------
local gui = Instance.new("ScreenGui")
gui.Name = "FrostWalkerHUD"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = playerGui

local root = Instance.new("Frame")
root.Size = UDim2.new(0, 240, 0, 50)
root.Position = BASE_POS
root.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
root.BackgroundTransparency = 0.2
root.BorderSizePixel = 0
root.Parent = gui

Instance.new("UICorner", root).CornerRadius = UDim.new(0, 14)

local stroke = Instance.new("UIStroke")
stroke.Thickness = 2
stroke.Color = Color3.fromRGB(120, 200, 255)
stroke.Transparency = 0.35
stroke.Parent = root

local grad = Instance.new("UIGradient")
grad.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(35, 60, 90)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(10, 10, 20)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(90, 140, 220))
})
grad.Parent = root

------------------------------------------------
-- ICON
------------------------------------------------
local icon = Instance.new("TextLabel")
icon.Size = UDim2.new(0, 42, 0, 42)
icon.Position = UDim2.new(0, 6, 0.5, -21)
icon.BackgroundTransparency = 1
icon.Text = "❄"
icon.Font = Enum.Font.GothamBlack
icon.TextSize = 20
icon.TextColor3 = Color3.fromRGB(120, 200, 255)
icon.Parent = root

------------------------------------------------
-- LABEL
------------------------------------------------
local label = Instance.new("TextLabel")
label.Size = UDim2.new(1, -60, 1, 0)
label.Position = UDim2.new(0, 55, 0, 0)
label.BackgroundTransparency = 1
label.Font = Enum.Font.GothamBold
label.TextSize = 14
label.TextXAlignment = Enum.TextXAlignment.Left
label.Text = "FROST WALKER: OFF"
label.TextColor3 = Color3.fromRGB(255, 90, 90)
label.Parent = root

------------------------------------------------
-- ENERGY
------------------------------------------------
local energy = Instance.new("Frame")
energy.Size = UDim2.new(0, 80, 1, 0)
energy.BackgroundColor3 = Color3.fromRGB(180, 240, 255)
energy.BackgroundTransparency = 0.88
energy.BorderSizePixel = 0
energy.Parent = root
Instance.new("UICorner", energy).CornerRadius = UDim.new(0, 14)

------------------------------------------------
-- EFFECT LAYERS
------------------------------------------------
local glow = Instance.new("Frame")
glow.Size = UDim2.new(1, 20, 1, 20)
glow.Position = UDim2.new(0, -10, 0, -10)
glow.BackgroundColor3 = Color3.fromRGB(120, 200, 255)
glow.BackgroundTransparency = 0.95
glow.BorderSizePixel = 0
glow.ZIndex = 0
glow.Parent = root
Instance.new("UICorner", glow).CornerRadius = UDim.new(0, 16)

local flash = Instance.new("Frame")
flash.Size = UDim2.new(1, 0, 1, 0)
flash.BackgroundTransparency = 1
flash.BorderSizePixel = 0
flash.Parent = root
Instance.new("UICorner", flash).CornerRadius = UDim.new(0, 14)

------------------------------------------------
-- POSITION ENGINE
------------------------------------------------
local t = 0
local lastState = nil

RunService.RenderStepped:Connect(function(dt)
	t += dt

	-- ONLY OFFSET SYSTEM (SAFE + STABLE)
	local float = math.sin(t * 2.2) * 2

	root.Position = UDim2.new(
		BASE_POS.X.Scale,
		BASE_POS.X.Offset,
		BASE_POS.Y.Scale,
		BASE_POS.Y.Offset + float
	)

	-- visuals only
	grad.Rotation = (t * 40) % 360
	energy.Position = UDim2.new((t * 0.55) % 1, -80, 0, 0)
	energy.Size = UDim2.new(0, 80 + math.sin(t * 3.2) * 6, 1, 0)

	icon.Rotation = math.sin(t * 2.5) * 4
	icon.TextTransparency = 0.05 + math.abs(math.sin(t * 3.2)) * 0.15

	stroke.Transparency = 0.2 + math.abs(math.sin(t * 3)) * 0.35
	glow.BackgroundTransparency = 0.92 + math.abs(math.sin(t * 2)) * 0.05

	root.Size = UDim2.new(0, 240 + math.sin(t * 2) * 3, 0, 50 + math.sin(t * 2.2) * 1.5)

	if bootsOn ~= lastState then
		lastState = bootsOn
		flash.BackgroundTransparency = 0.4
		TweenService:Create(flash, TweenInfo.new(0.35), {
			BackgroundTransparency = 1
		}):Play()
	end
end)

------------------------------------------------
-- STATUS UPDATE
------------------------------------------------
local function UpdateStatus()
	if bootsOn then
		label.Text = "FROST WALKER: ACTIVE"
		label.TextColor3 = Color3.fromRGB(120, 255, 180)
		TweenService:Create(root, TweenInfo.new(0.2), {
			Size = UDim2.new(0, 255, 0, 52)
		}):Play()
		TweenService:Create(energy, TweenInfo.new(0.2), {
			BackgroundTransparency = 0.8
		}):Play()
	else
		label.Text = "FROST WALKER: OFF"
		label.TextColor3 = Color3.fromRGB(255, 90, 90)
		TweenService:Create(root, TweenInfo.new(0.2), {
			Size = UDim2.new(0, 240, 0, 50)
		}):Play()
		TweenService:Create(energy, TweenInfo.new(0.2), {
			BackgroundTransparency = 0.92
		}):Play()
	end
end

------------------------------------------------
-- TOOL
------------------------------------------------
local tool = Instance.new("Tool")
tool.Name = "FrostWalkerBoots"
tool.TextureId = "rbxassetid://97625418048677"
tool.RequiresHandle = true
tool.CanBeDropped = true
tool.Parent = player.Backpack

local handle = Instance.new("Part")
handle.Name = "Handle"
handle.Size = Vector3.new(1,1,1)
handle.Transparency = 0.5
handle.Material = Enum.Material.Neon
handle.Color = Color3.fromRGB(0,255,255)
handle.Parent = tool

------------------------------------------------
-- BOOTS
------------------------------------------------
local leftBoot, rightBoot, leftGlint, rightGlint

local function createBoots(char)
	local l = char:FindFirstChild("Left Leg")
	local r = char:FindFirstChild("Right Leg")
	if not l or not r then return end
	leftBoot = Instance.new("Part")
	leftBoot.Size = Vector3.new(1.2,1.2,1.2)
	leftBoot.Color = Color3.fromRGB(50,150,255)
	leftBoot.Material = Enum.Material.Plastic
	leftBoot.CanCollide = false
	leftBoot.Parent = char
	rightBoot = leftBoot:Clone()
	rightBoot.Parent = char
	leftGlint = Instance.new("Part")
	leftGlint.Size = leftBoot.Size + Vector3.new(0.01,0.01,0.01)
	leftGlint.Material = Enum.Material.ForceField
	leftGlint.Transparency = 0.3
	leftGlint.Color = Color3.fromRGB(160,0,255)
	leftGlint.CanCollide = false
	leftGlint.Parent = char
	rightGlint = leftGlint:Clone()
	rightGlint.Parent = char
	leftBoot.CFrame = l.CFrame * CFrame.new(0,-0.5,0)
	rightBoot.CFrame = r.CFrame * CFrame.new(0,-0.5,0)
	leftGlint.CFrame = leftBoot.CFrame
	rightGlint.CFrame = rightBoot.CFrame
	local function weld(a,b)
		local w = Instance.new("WeldConstraint")
		w.Part0 = a
		w.Part1 = b
		w.Parent = a
	end
	weld(leftBoot,l)
	weld(rightBoot,r)
	weld(leftGlint,leftBoot)
	weld(rightGlint,rightBoot)
end

local function removeBoots()
	for _,v in ipairs({leftBoot,rightBoot,leftGlint,rightGlint}) do
		if v then v:Destroy() end
	end
	leftBoot,rightBoot,leftGlint,rightGlint = nil,nil,nil,nil
end

------------------------------------------------
-- HEALTH
------------------------------------------------
local function addHealth(h)
	h.MaxHealth += 40
	h.Health += 40
end

local function removeHealth(h)
	h.MaxHealth -= 40
	if h.Health > h.MaxHealth then
		h.Health = h.MaxHealth
	end
end

------------------------------------------------
-- TOGGLE
------------------------------------------------
tool.Activated:Connect(function()
	local char = player.Character
	local hum = char and char:FindFirstChild("Humanoid")
	bootsOn = not bootsOn
	UpdateStatus()
	if bootsOn then
		if char then createBoots(char) end
		if hum then addHealth(hum) end
	else
		if hum then removeHealth(hum) end
		removeBoots()
	end
end)

------------------------------------------------
-- RESET
------------------------------------------------
player.CharacterAdded:Connect(function()
	bootsOn = false
	sneaking = false
	removeBoots()
	UpdateStatus()
	task.defer(function()
		if tool.Parent ~= player.Backpack then
			tool.Parent = player.Backpack
		end
	end)
end)

------------------------------------------------
-- ICE FLOOR
------------------------------------------------
RunService.Heartbeat:Connect(function(dt)
	if not bootsOn then return end
	iceCooldown -= dt
	if iceCooldown > 0 then return end
	local char = player.Character
	local rootPart = char and char:FindFirstChild("HumanoidRootPart")
	if not rootPart then return end
	local origin = rootPart.Position - Vector3.new(0,3,0)
	local params = RaycastParams.new()
	params.FilterDescendantsInstances = {char}
	params.FilterType = Enum.RaycastFilterType.Blacklist
	local ray = workspace:Raycast(origin, Vector3.new(0,-5,0), params)
	if not ray then return end
	local x = math.floor(rootPart.Position.X / 3) * 3
	local z = math.floor(rootPart.Position.Z / 3) * 3
	local ice = Instance.new("Part")
	ice.Size = Vector3.new(3,3,3)
	ice.Anchored = true
	ice.CanCollide = true
	ice.Material = Enum.Material.Plastic
	ice.Color = Color3.fromRGB(160,230,255)
	ice.Reflectance = 0.4
	ice.Position = Vector3.new(x+1.5, ray.Position.Y+1.5, z+1.5)
	ice.Parent = workspace
	Debris:AddItem(ice, 4)
	iceCooldown = 0.2
end)

------------------------------------------------
-- DAMAGE HIGHLIGHT
------------------------------------------------
local function makeHighlight(char)
	local h = char:FindFirstChild("DamageHighlight")
	if h then return h end
	h = Instance.new("Highlight")
	h.FillColor = Color3.fromRGB(255,0,0)
	h.FillTransparency = 0.5
	h.OutlineTransparency = 1
	h.Parent = char
	return h
end

RunService.Heartbeat:Connect(function()
	local char = player.Character
	if not char then return end
	local hum = char:FindFirstChildOfClass("Humanoid")
	if not hum then return end
	if lastHealth == nil then
		lastHealth = hum.Health
		return
	end
	if hum.Health < lastHealth then
		if tick() - lastDamageTime > damageCooldown then
			local h = makeHighlight(char)
			h.Enabled = true
			lastDamageTime = tick()
			task.delay(0.3, function()
				if h then h.Enabled = false end
			end)
		end
	end
	lastHealth = hum.Health
end)
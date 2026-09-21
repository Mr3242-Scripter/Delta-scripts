--[[
    MOLYN INVISIBILITY
    © MOLYN DEVELOPMENT
]]

-- MOLYN Configuration
local CONFIG = {
	TOGGLE_KEY = Enum.KeyCode.X,
	DEFAULT_SPEED = 16,
	BOOSTED_SPEED = 48,
	INVISIBILITY_POSITION = Vector3.new(-25.95, 84, 3537.55),
	-- MOLYN Theme Colors
	BACKGROUND = Color3.fromRGB(10, 10, 10),
	SURFACE = Color3.fromRGB(25, 25, 25),
	PRIMARY = Color3.fromRGB(255, 50, 50),
	ACCENT = Color3.fromRGB(255, 80, 80),
	SUCCESS = Color3.fromRGB(50, 255, 50),
	DANGER = Color3.fromRGB(255, 50, 50),
	TEXT = Color3.fromRGB(255, 255, 255),
	TEXT_SECONDARY = Color3.fromRGB(200, 200, 200),
}

-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

-- Variables
local player = Players.LocalPlayer
local playerState = {
	isInvisible = false,
	isSpeedBoosted = false,
	isNoclip = false,
	isInfJump = false,
	originalSpeed = CONFIG.DEFAULT_SPEED,
}

-- GUI Elements
local screenGui: ScreenGui
local mainFrame: Frame
local toggleButton: TextButton
local speedButton: TextButton
local noclipButton: TextButton
local infJumpButton: TextButton
local closeButton: TextButton
local statusLabel: TextLabel 
local statusCircle: Frame

-- Utility Functions
local function setCharacterTransparency(character: Model, transparency: number): ()
	for _, descendant in character:GetDescendants() do
		if descendant:IsA("BasePart") or descendant:IsA("Decal") then
			descendant.Transparency = transparency
		end
	end
end

local function getHumanoid(): Humanoid?
	local character = player.Character
	return character and character:FindFirstChild("Humanoid") :: Humanoid?
end

local function updateStatusUI()
	if not statusLabel or not statusCircle then return end
	if playerState.isInvisible then
		statusLabel.Text = "STATUS: ACTIVE"
		TweenService:Create(statusCircle, TweenInfo.new(0.3), {BackgroundColor3 = CONFIG.SUCCESS}):Play()
		TweenService:Create(statusCircle:FindFirstChild("UIStroke"), TweenInfo.new(0.3), {Color = CONFIG.SUCCESS, Transparency = 0.3}):Play()
	else
		statusLabel.Text = "STATUS: INACTIVE"
		TweenService:Create(statusCircle, TweenInfo.new(0.3), {BackgroundColor3 = CONFIG.DANGER}):Play()
		TweenService:Create(statusCircle:FindFirstChild("UIStroke"), TweenInfo.new(0.3), {Color = CONFIG.DANGER, Transparency = 0.3}):Play()
	end
end

-- Core Logic Functions
local function toggleInvisibility()
	if not player.Character then return end
	playerState.isInvisible = not playerState.isInvisible
	if playerState.isInvisible then
		local hrp = player.Character:FindFirstChild("HumanoidRootPart") :: BasePart?
		if not hrp then return end
		local savedPosition = hrp.CFrame
		player.Character:MoveTo(CONFIG.INVISIBILITY_POSITION)
		task.wait(0.15)
		local seat = Instance.new("Seat")
		seat.Name = "invischair"
		seat.Anchored = false; seat.CanCollide = false; seat.Transparency = 1
		seat.Position = CONFIG.INVISIBILITY_POSITION
		seat.Parent = workspace
		local weld = Instance.new("Weld")
		weld.Part0 = seat
		weld.Part1 = player.Character:FindFirstChild("Torso") or player.Character:FindFirstChild("UpperTorso")
		weld.Parent = seat
		task.wait()
		seat.CFrame = savedPosition
		setCharacterTransparency(player.Character, 0.5)
		toggleButton.Text = "🔴 VISIBLE"
		TweenService:Create(toggleButton, TweenInfo.new(0.3), {BackgroundColor3 = CONFIG.DANGER}):Play()
	else
		local invisChair = workspace:FindFirstChild("invischair")
		if invisChair then invisChair:Destroy() end
		if player.Character then setCharacterTransparency(player.Character, 0) end
		toggleButton.Text = "👻 INVISIBLE"
		TweenService:Create(toggleButton, TweenInfo.new(0.3), {BackgroundColor3 = CONFIG.SURFACE}):Play()
	end
	updateStatusUI()
end

local function toggleSpeedBoost()
	local humanoid = getHumanoid()
	if not humanoid then return end
	playerState.isSpeedBoosted = not playerState.isSpeedBoosted
	if playerState.isSpeedBoosted then
		humanoid.WalkSpeed = CONFIG.BOOSTED_SPEED
		speedButton.Text = "⚡ SPEED: ON"
		TweenService:Create(speedButton, TweenInfo.new(0.3), {BackgroundColor3 = CONFIG.SUCCESS}):Play()
	else
		humanoid.WalkSpeed = playerState.originalSpeed
		speedButton.Text = "⚡ SPEED BOOST"
		TweenService:Create(speedButton, TweenInfo.new(0.3), {BackgroundColor3 = CONFIG.SURFACE}):Play()
	end
end

local function toggleNoclip()
	playerState.isNoclip = not playerState.isNoclip
	if playerState.isNoclip then
		noclipButton.Text = "🚫 NOCLIP: ON"
		TweenService:Create(noclipButton, TweenInfo.new(0.3), {BackgroundColor3 = CONFIG.SUCCESS}):Play()
	else
		noclipButton.Text = "🚫 NOCLIP"
		TweenService:Create(noclipButton, TweenInfo.new(0.3), {BackgroundColor3 = CONFIG.SURFACE}):Play()
	end
end

local function toggleInfJump()
	playerState.isInfJump = not playerState.isInfJump
	if playerState.isInfJump then
		infJumpButton.Text = "🦘 INF JUMP: ON"
		TweenService:Create(infJumpButton, TweenInfo.new(0.3), {BackgroundColor3 = CONFIG.SUCCESS}):Play()
	else
		infJumpButton.Text = "🦘 INFINITE JUMP"
		TweenService:Create(infJumpButton, TweenInfo.new(0.3), {BackgroundColor3 = CONFIG.SURFACE}):Play()
	end
end

-- GUI Creation
local function createGUI()
	screenGui = Instance.new("ScreenGui")
	screenGui.Name = "MOLYN_FE_Invisibility"
	screenGui.ResetOnSpawn = false
	screenGui.Parent = player:WaitForChild("PlayerGui")

	mainFrame = Instance.new("Frame")
	mainFrame.Size = UDim2.new(0, 220, 0, 320)
	mainFrame.Position = UDim2.new(0.5, -110, 0, -350)
	mainFrame.BackgroundColor3 = CONFIG.BACKGROUND
	mainFrame.BorderSizePixel = 0
	mainFrame.Active = true
	mainFrame.Draggable = true
	mainFrame.Parent = screenGui

	Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 16)
	local mStroke = Instance.new("UIStroke", mainFrame)
	mStroke.Color = CONFIG.PRIMARY
	mStroke.Transparency = 0.5
	mStroke.Thickness = 2

	-- Entrance Animation
	TweenService:Create(mainFrame, TweenInfo.new(0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
		Position = UDim2.new(0.5, -110, 0.5, -160)
	}):Play()

	-- Header with Logo
	local header = Instance.new("Frame")
	header.Size = UDim2.new(1, 0, 0, 60)
	header.BackgroundColor3 = CONFIG.SURFACE
	header.BorderSizePixel = 0
	header.Parent = mainFrame

	local headerCorner = Instance.new("UICorner", header)
	headerCorner.CornerRadius = UDim.new(0, 16)

	local headerFix = Instance.new("Frame")
	headerFix.Size = UDim2.new(1, 0, 0, 20)
	headerFix.Position = UDim2.new(0, 0, 1, -20)
	headerFix.BackgroundColor3 = CONFIG.SURFACE
	headerFix.BorderSizePixel = 0
	headerFix.Parent = header

	-- Logo
	local logo = Instance.new("ImageLabel")
	logo.Size = UDim2.new(0, 40, 0, 40)
	logo.Position = UDim2.new(0, 15, 0.5, -20)
	logo.BackgroundColor3 = CONFIG.SURFACE
	logo.Image = "rbxassetid://109421193232034"
	logo.ScaleType = Enum.ScaleType.Fit
	logo.Parent = header

	local logoCorner = Instance.new("UICorner", logo)
	logoCorner.CornerRadius = UDim.new(0, 8)

	-- Title
	local titleLabel = Instance.new("TextLabel")
	titleLabel.Size = UDim2.new(1, -120, 1, 0)
	titleLabel.Position = UDim2.new(0, 60, 0, 0)
	titleLabel.Text = "MOLYN INVISIBILITY"
	titleLabel.BackgroundTransparency = 1
	titleLabel.TextColor3 = CONFIG.TEXT
	titleLabel.Font = Enum.Font.GothamBold
	titleLabel.TextSize = 18
	titleLabel.TextXAlignment = Enum.TextXAlignment.Left
	titleLabel.Parent = header

	local subtitle = Instance.new("TextLabel")
	subtitle.Size = UDim2.new(1, -120, 0, 15)
	subtitle.Position = UDim2.new(0, 60, 0, 32)
	subtitle.Text = "Invisibility Panel"
	subtitle.BackgroundTransparency = 1
	subtitle.TextColor3 = CONFIG.TEXT_SECONDARY
	subtitle.Font = Enum.Font.Gotham
	subtitle.TextSize = 11
	subtitle.TextXAlignment = Enum.TextXAlignment.Left
	subtitle.Parent = header

	-- Modern Button Styling
	local function style(btn: TextButton)
		Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 12)
		local s = Instance.new("UIStroke", btn)
		s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		s.Color = CONFIG.PRIMARY
		s.Transparency = 0.7
		s.Thickness = 1.5
		
		-- Hover Animation
		btn.MouseEnter:Connect(function()
			TweenService:Create(s, TweenInfo.new(0.2), {Transparency = 0.3}):Play()
			TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = CONFIG.ACCENT}):Play()
		end)
		btn.MouseLeave:Connect(function()
			if not btn.Text:find(":") then
				TweenService:Create(s, TweenInfo.new(0.2), {Transparency = 0.7}):Play()
				TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = CONFIG.SURFACE}):Play()
			end
		end)

		-- Click Animation
		btn.MouseButton1Down:Connect(function()
			TweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {
				Size = UDim2.new(1, -32, 0, 42)
			}):Play()
		end)
		btn.MouseButton1Up:Connect(function()
			TweenService:Create(btn, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
				Size = UDim2.new(1, -28, 0, 45)
			}):Play()
		end)
	end

	-- Buttons
	toggleButton = Instance.new("TextButton")
	toggleButton.Size = UDim2.new(1, -28, 0, 45)
	toggleButton.Position = UDim2.new(0, 14, 0, 75)
	toggleButton.Text = "👻 INVISIBLE"
	toggleButton.BackgroundColor3 = CONFIG.SURFACE
	toggleButton.TextColor3 = CONFIG.TEXT
	toggleButton.Font = Enum.Font.GothamBold
	toggleButton.TextSize = 13
	toggleButton.AutoButtonColor = false
	toggleButton.Parent = mainFrame
	style(toggleButton)

	speedButton = Instance.new("TextButton")
	speedButton.Size = UDim2.new(1, -28, 0, 45)
	speedButton.Position = UDim2.new(0, 14, 0, 128)
	speedButton.Text = "⚡ SPEED BOOST"
	speedButton.BackgroundColor3 = CONFIG.SURFACE
	speedButton.TextColor3 = CONFIG.TEXT
	speedButton.Font = Enum.Font.GothamBold
	speedButton.TextSize = 13
	speedButton.AutoButtonColor = false
	speedButton.Parent = mainFrame
	style(speedButton)

	noclipButton = Instance.new("TextButton")
	noclipButton.Size = UDim2.new(1, -28, 0, 45)
	noclipButton.Position = UDim2.new(0, 14, 0, 181)
	noclipButton.Text = "🚫 NOCLIP"
	noclipButton.BackgroundColor3 = CONFIG.SURFACE
	noclipButton.TextColor3 = CONFIG.TEXT
	noclipButton.Font = Enum.Font.GothamBold
	noclipButton.TextSize = 13
	noclipButton.AutoButtonColor = false
	noclipButton.Parent = mainFrame
	style(noclipButton)

	infJumpButton = Instance.new("TextButton")
	infJumpButton.Size = UDim2.new(1, -28, 0, 45)
	infJumpButton.Position = UDim2.new(0, 14, 0, 234)
	infJumpButton.Text = "🦘 INFINITE JUMP"
	infJumpButton.BackgroundColor3 = CONFIG.SURFACE
	infJumpButton.TextColor3 = CONFIG.TEXT
	infJumpButton.Font = Enum.Font.GothamBold
	infJumpButton.TextSize = 13
	infJumpButton.AutoButtonColor = false
	infJumpButton.Parent = mainFrame
	style(infJumpButton)

	-- Status Indicator
	statusCircle = Instance.new("Frame")
	statusCircle.Size = UDim2.new(0, 8, 0, 8)
	statusCircle.Position = UDim2.new(0, 14, 0, 290)
	statusCircle.BackgroundColor3 = CONFIG.DANGER
	statusCircle.Parent = mainFrame
	
	Instance.new("UICorner", statusCircle).CornerRadius = UDim.new(1, 0)
	local glowCircle = Instance.new("UIStroke", statusCircle)
	glowCircle.Thickness = 3
	glowCircle.Color = CONFIG.DANGER
	glowCircle.Transparency = 0.3

	statusLabel = Instance.new("TextLabel")
	statusLabel.Size = UDim2.new(1, -30, 0, 18)
	statusLabel.Position = UDim2.new(0, 28, 0, 287)
	statusLabel.Text = "STATUS: INACTIVE"
	statusLabel.BackgroundTransparency = 1
	statusLabel.TextColor3 = CONFIG.TEXT_SECONDARY
	statusLabel.Font = Enum.Font.GothamBold
	statusLabel.TextSize = 10
	statusLabel.TextXAlignment = Enum.TextXAlignment.Left
	statusLabel.Parent = mainFrame

	-- Footer
	local footer = Instance.new("TextLabel")
	footer.Size = UDim2.new(1, 0, 0, 20)
	footer.Position = UDim2.new(0, 0, 1, -8)
	footer.Text = "© MOLYN DEVELOPMENT"
	footer.BackgroundTransparency = 1
	footer.TextColor3 = CONFIG.PRIMARY
	footer.Font = Enum.Font.GothamBold
	footer.TextSize = 9
	footer.Parent = mainFrame

	-- Close Button
	closeButton = Instance.new("TextButton")
	closeButton.Size = UDim2.new(0, 30, 0, 30)
	closeButton.Position = UDim2.new(1, -40, 0, 15)
	closeButton.Text = "✕"
	closeButton.BackgroundColor3 = CONFIG.DANGER
	closeButton.TextColor3 = CONFIG.TEXT
	closeButton.Font = Enum.Font.GothamBold
	closeButton.TextSize = 18
	closeButton.Parent = mainFrame
	
	local closeCorner = Instance.new("UICorner", closeButton)
	closeCorner.CornerRadius = UDim.new(0, 8)

	closeButton.MouseButton1Click:Connect(function()
		local exitTween = TweenService:Create(mainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
			Position = UDim2.new(0.5, -110, 0, -350)
		})
		exitTween:Play()
		exitTween.Completed:Connect(function()
			screenGui:Destroy()
		end)
	end)
end

-- Initialization
createGUI()
toggleButton.MouseButton1Click:Connect(toggleInvisibility)
speedButton.MouseButton1Click:Connect(toggleSpeedBoost)
noclipButton.MouseButton1Click:Connect(toggleNoclip)
infJumpButton.MouseButton1Click:Connect(toggleInfJump)

UserInputService.InputBegan:Connect(function(input, processed)
	if not processed and input.KeyCode == CONFIG.TOGGLE_KEY then toggleInvisibility() end
end)

-- Feature Loops
RunService.Stepped:Connect(function()
	if playerState.isNoclip and player.Character then
		for _, part in pairs(player.Character:GetDescendants()) do
			if part:IsA("BasePart") and part.CanCollide then
				part.CanCollide = false
			end
		end
	end
end)

UserInputService.JumpRequest:Connect(function()
	if playerState.isInfJump and player.Character then
		local hum = player.Character:FindFirstChild("Humanoid") :: Humanoid?
		if hum then
			hum:ChangeState(Enum.HumanoidStateType.Jumping)
		end
	end
end)
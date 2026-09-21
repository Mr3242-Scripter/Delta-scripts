local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

-- SETTINGS
local BASE_POS = UDim2.new(0, 12, 0, 12)
local CLIMB_SPEED = 18
local REENTER_WINDOW = 1
local LEVITATE_TIME = 0.5
local RAY_DISTANCE = 3

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "WallClimbGui"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 45)
frame.Position = BASE_POS
frame.BackgroundColor3 = Color3.fromRGB(22, 22, 24)
frame.BorderSizePixel = 0
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = frame

local stroke = Instance.new("UIStroke")
stroke.Thickness = 1
stroke.Color = Color3.fromRGB(80, 80, 90)
stroke.Transparency = 0.5
stroke.Parent = frame

local button = Instance.new("TextButton")
button.Size = UDim2.new(1, -10, 1, -10)
button.Position = UDim2.new(0, 5, 0, 5)
button.BackgroundColor3 = Color3.fromRGB(35, 35, 38)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Text = "Wall Climb: OFF"
button.Font = Enum.Font.GothamSemibold
button.TextSize = 14
button.BorderSizePixel = 0
button.Parent = frame

local enabled = false

button.MouseButton1Click:Connect(function()
	enabled = not enabled
	button.Text = enabled and "Wall Climb: ON" or "Wall Climb: OFF"
	button.BackgroundColor3 = enabled and Color3.fromRGB(45, 80, 45)
		or Color3.fromRGB(35, 35, 38)
end)

local connection

local function setNoclip(char, state)
	for _, v in ipairs(char:GetDescendants()) do
		if v:IsA("BasePart") then
			v.CanCollide = not state
		end
	end
end

local function setup(char)
	if connection then
		connection:Disconnect()
	end

	local humanoid = char:WaitForChild("Humanoid")
	local root = char:WaitForChild("HumanoidRootPart")

	local rayParams = RaycastParams.new()
	rayParams.FilterType = Enum.RaycastFilterType.Exclude
	rayParams.FilterDescendantsInstances = {char}

	-- STATE
	local wasTouching = false
	local lastExitTime = 0
	local reenterCooldown = 0

	local levitating = false
	local levitateEnd = 0

	connection = RunService.Heartbeat:Connect(function(dt)
		if not char.Parent then return end
		if not enabled then
			setNoclip(char, false)
			return
		end

		local state = humanoid:GetState()
		local inAir =
			state == Enum.HumanoidStateType.Freefall
			or state == Enum.HumanoidStateType.Jumping

		if not inAir then
			levitating = false
			setNoclip(char, false)
			return
		end

		-- wall detection
		local hit = workspace:Raycast(root.Position, root.CFrame.LookVector * RAY_DISTANCE, rayParams)
		local touching = hit ~= nil
		local now = os.clock()

		-- EXIT WALL
		if wasTouching and not touching then
			lastExitTime = now
			reenterCooldown = now + 0.15 -- prevents double-wall spam
			setNoclip(char, false)
		end

		-- RE-ENTRY PENALTY
		if touching and not wasTouching then
			if now > reenterCooldown and (now - lastExitTime) < REENTER_WINDOW then
				levitating = true
				levitateEnd = now + LEVITATE_TIME
			end
		end

		wasTouching = touching

		-- LEVITATION MODE
		if levitating then
			setNoclip(char, true)

			if now >= levitateEnd then
				levitating = false
				setNoclip(char, false)
			else
				-- smooth hover (NO CFrame spam)
				root.AssemblyLinearVelocity = Vector3.new(0, 6, 0)
				return
			end
		end

		-- CLIMB MODE
		if touching then
			setNoclip(char, true)

			local vel = root.AssemblyLinearVelocity
			root.AssemblyLinearVelocity = Vector3.new(0, math.max(vel.Y, 0), 0)

			root.CFrame = root.CFrame + Vector3.new(0, CLIMB_SPEED * dt, 0)
		else
			setNoclip(char, false)
		end
	end)
end

if player.Character then
	setup(player.Character)
end

player.CharacterAdded:Connect(setup)
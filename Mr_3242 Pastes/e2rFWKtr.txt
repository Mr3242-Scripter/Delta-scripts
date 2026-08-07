local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

------------------------------------------------
-- STATE GATE
------------------------------------------------
local Allowed = false

------------------------------------------------
-- WARNING GUI
------------------------------------------------
local WarningGui = Instance.new("ScreenGui")
WarningGui.Name = "SafetyWarning"
WarningGui.ResetOnSpawn = false
WarningGui.IgnoreGuiInset = true
WarningGui.Parent = PlayerGui

local Main = Instance.new("TextButton")
Main.Size = UDim2.new(1, 0, 1, 0)
Main.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Main.BorderSizePixel = 0
Main.TextColor3 = Color3.new(1, 1, 1)
Main.TextScaled = true
Main.Font = Enum.Font.GothamBlack
Main.TextWrapped = true
Main.Text = [[
⚠ WARNING ⚠

if you get banned it’s not my fault, it’s your own responsibility.
this game may have active moderators.
avoid obvious exploits like infinite jump, fly, or speed.

CLICK TO CONTINUE
]]
Main.Parent = WarningGui

Main.MouseButton1Click:Connect(function()
	if Allowed then return end

	for i = 3, 1, -1 do
		Main.Text =
			"⚠ WARNING ⚠\n\nContinuing in " .. i .. "..."
		task.wait(1)
	end

	Allowed = true
end)

repeat task.wait() until Allowed
WarningGui:Destroy()

------------------------------------------------
-- MAIN SCRIPT
------------------------------------------------

local UI = loadstring(game:HttpGet(
	"https://pastebin.com/raw/4NHU7v35",
	true
))()

local Window = UI:CreateWindow("Safety NOT Required!")

------------------------------------------------
-- STATE
------------------------------------------------
local AutoFarm = false
local Alive = false

------------------------------------------------
-- CHARACTER TRACKING
------------------------------------------------
local function hookCharacter(char)
	local hum = char:WaitForChild("Humanoid")
	Alive = hum.Health > 0

	hum.Died:Connect(function()
		Alive = false
	end)
end

if LocalPlayer.Character then
	hookCharacter(LocalPlayer.Character)
end

LocalPlayer.CharacterAdded:Connect(function(char)
	task.wait(1)
	hookCharacter(char)
end)

------------------------------------------------
-- TELEPORT
------------------------------------------------
local function tpToModel(model)
	if not Alive then return end

	local char = LocalPlayer.Character
	if not char then return end

	local root = char:FindFirstChild("HumanoidRootPart")
	if not root then return end

	if not model or not model:IsA("Model") then return end

	local part =
		model.PrimaryPart
		or model:FindFirstChildWhichIsA("BasePart", true)

	if part then
		root.CFrame = part.CFrame + Vector3.new(0, 3, 0)
	end
end

------------------------------------------------
-- RANDOM EXIT
------------------------------------------------
local function getRandomExit()
	local entities = workspace:WaitForChild("map"):WaitForChild("entities")

	local exits = {}

	for _, v in ipairs(entities:GetChildren()) do
		if v:IsA("Model") and string.find(string.lower(v.Name), "exit") then
			table.insert(exits, v)
		end
	end

	if #exits > 0 then
		return exits[math.random(1, #exits)]
	end
end

------------------------------------------------
-- TOGGLE
------------------------------------------------
Window:AddToggle({
	text = "Auto Bobux",
	state = false,
	callback = function(v)
		AutoFarm = v
	end
})

------------------------------------------------
-- LOOP
------------------------------------------------
task.spawn(function()
	while true do
		task.wait(0.1)

		if AutoFarm and Alive then
			local entities = workspace:FindFirstChild("map")
				and workspace.map:FindFirstChild("entities")

			if entities then
				local bobux = entities:FindFirstChild("bobux")

				if bobux then
					tpToModel(bobux)

					task.wait(0.1)

					local exit = getRandomExit()
					if exit then
						tpToModel(exit)
					end
				end
			end
		end
	end
end)

------------------------------------------------
-- LABEL
------------------------------------------------
Window:AddLabel({
	text = "TikTok: Mr_3242"
})

UI:Init()
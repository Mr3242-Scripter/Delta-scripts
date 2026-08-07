-- ─── Admin Panel for the glass bridge only https://www.roblox.com/games/8032701413/The-Glass-Bridge ───────────────────────

-- Also i couldn’t figure out how to disable the glass toggle when you unload but don’t worry it resets when the game resets the map



--// SAFE RE-EXECUTE
if getgenv().GlassAdminUnload then
	pcall(getgenv().GlassAdminUnload)
end

--// SERVICES
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer

--// LOAD RAYFIELD
local Rayfield

task.spawn(function()
	while not Rayfield do
		local success, result = pcall(function()
			return loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
		end)

		if success and result then
			Rayfield = result
			print("[Rayfield] Loaded successfully")
		else
			warn("[Rayfield] Failed to load, retrying...")
			task.wait(0.2)
		end
	end
end)

repeat task.wait() until Rayfield

--// FILTER NOTIFICATIONS
local oldNotify = Rayfield.Notify
Rayfield.Notify = function(self, data)
	if data and data.Title then
		local t = tostring(data.Title)
		if t:find("Rayfield") or t:find("Interface") then return end
	end
	return oldNotify(self, data)
end

--// WINDOW
local Window = Rayfield:CreateWindow({
	Name = "The Glass Bridge",
	LoadingTitle = "Admin Panel",
	LoadingSubtitle = "follow me on TikTok Mr_3242",
	ConfigurationSaving = {Enabled = false},
	KeySystem = false
})

--// TABS
local CheatsTab = Window:CreateTab("Cheats", 4483362458)
local CreditsTab = Window:CreateTab("Credits", 4483362458)
local UnloadTab = Window:CreateTab("Unload", 4483362458)

--// REMOTES
local RemoteEvents = ReplicatedStorage:WaitForChild("RemoteEvents", 10)
local AdminOverrideEvent = RemoteEvents and RemoteEvents:WaitForChild("AdminOverrideEvent", 5)

--// STATE
local glassVisible = false

local States = {
	Immune = false,
	Barrier = false,
	BridgeLight = false,
	GameLight = false
}

--// REMOTE FUNCTION
local function fireOverride(arg)
	if AdminOverrideEvent then
		pcall(function()
			AdminOverrideEvent:FireServer(arg)
		end)
	end
end

--// GLASS
local function toggleGlass()
	local gs = workspace:FindFirstChild("GameRunningService")
	local gb = gs and gs:FindFirstChild("GlassBridges")
	local cg = gb and gb:FindFirstChild("CorrectGlass")
	if not cg then return end

	for _, p in pairs(cg:GetChildren()) do
		if p:IsA("BasePart") then
			p.Transparency = glassVisible and 1 or 0.8
		end
	end

	glassVisible = not glassVisible
end

--// CHEATS
CheatsTab:CreateToggle({
	Name = "toggle Glass on/off",
	CurrentValue = false,
	Callback = function()
		toggleGlass()
	end
})

CheatsTab:CreateToggle({
	Name = "become Immune",
	CurrentValue = false,
	Callback = function()
		States.Immune = not States.Immune
		fireOverride("Immunity")
	end
})

CheatsTab:CreateButton({
	Name = "toggle Barrier on/off",
	Callback = function()
		States.Barrier = not States.Barrier
		fireOverride("Barrier")
	end
})

CheatsTab:CreateToggle({
	Name = "toggle Bridge Light on/off",
	CurrentValue = false,
	Callback = function()
		States.BridgeLight = not States.BridgeLight
		fireOverride("BridgeLight")
	end
})

CheatsTab:CreateToggle({
	Name = "toggle Game Light on/off",
	CurrentValue = false,
	Callback = function()
		States.GameLight = not States.GameLight
		fireOverride("GameLight")
	end
})

CheatsTab:CreateButton({
	Name = "Stop Game",
	Callback = function()
		fireOverride("StopGame")
	end
})

--// CREDITS
CreditsTab:CreateParagraph({
	Title = "Credits",
	Content = "Script created by Mr_3242\nThanks for using the script!"
})

CreditsTab:CreateButton({
	Name = "Copy TikTok",
	Callback = function()
		setclipboard("https://www.tiktok.com/@Mr_3242")
	end
})

CreditsTab:CreateButton({
	Name = "Copy YouTube",
	Callback = function()
		setclipboard("https://www.youtube.com/@Mr_3242.")
	end
})

CreditsTab:CreateButton({
	Name = "Copy Twitch",
	Callback = function()
		setclipboard("https://m.twitch.tv/quantumx_42/home")
	end
})

--// UNLOAD
getgenv().GlassAdminUnload = function()

	pcall(function()
		if glassVisible then
			local gs = workspace:FindFirstChild("GameRunningService")
			local gb = gs and gs:FindFirstChild("GlassBridges")
			local cg = gb and gb:FindFirstChild("CorrectGlass")

			if cg then
				for _, p in pairs(cg:GetChildren()) do
					if p:IsA("BasePart") then
						p.Transparency = 0.8
					end
				end
			end

			glassVisible = false
		end
	end)

	pcall(function()
		if States.Immune then fireOverride("Immunity") end
		if States.Barrier then fireOverride("Barrier") end
		if States.BridgeLight then fireOverride("BridgeLight") end
		if States.GameLight then fireOverride("GameLight") end
	end)

	pcall(function()
		if Rayfield then
			Rayfield:Destroy()
		end
	end)

	getgenv().GlassAdminUnload = nil
end

UnloadTab:CreateButton({
	Name = "Unload Script",
	Callback = function()
		if getgenv().GlassAdminUnload then
			getgenv().GlassAdminUnload()
		end
	end
})
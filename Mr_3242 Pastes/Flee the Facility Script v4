local KHLib = loadstring(game:HttpGet("https://pastebin.com/raw/BkRLnxZW"))():GetKSLib("v2.1.x")
local PU = loadstring(game:HttpGet("https://pastebin.com/raw/xAZ4WQRS"))()
local SLoc = game.CoreGui
local HLoc = game.Workspace
local Comp = 0
local Beast = nil
local lpos = nil
local bnhide = false
local clpos = false
local bnhideelapse = 0
local noelepse = 0
local onsurvivorfarm = false


local filesavingname = "FTF_KoalaScripts"

local TempPlayerStatsModule = nil

KHLib:Initialize(nil, false)

function IsThereChar(APlr)
	local plr = APlr or game.Players.LocalPlayer
	if plr.Character and plr.Character:FindFirstChild("Humanoid") then
		return true
	end
	return false
end

function TPPlayerSpawn()
	game.Players.LocalPlayer.Character:PivotTo(game.Workspace.LobbySpawnPad.CFrame * CFrame.new(0, 3, 0))
end

local UI = KHLib.New({
	Location = SLoc,
	Title = "Flee The Facility (Koala Scripts)",
})

local PlrTab = UI:NewTab({
	ID = "PlrTab",
	Name = "⛹ Player"
})

-- Speed Hacks

local SpeedHackEnabled = PlrTab:NewActionToggle({
	ID = "SpeedHackEnabled",
	Description = "Enable Speed Hacks"
})

SpeedHackEnabled:OnInputChanged(function()
	if not SpeedHackEnabled:GetValue() and IsThereChar() then
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
	end
end)

local SpeedHack = PlrTab:NewActionSlider({
	ID = "SpeedHack",
	Description = "Player Speed",
	BypassInputMax = true,
	DefaultValue = 16,
	MaxValue = 48,
	MinValue = 0,
})

-- Jump Hacks

local InfiniteJump = PlrTab:NewActionToggle({
	ID = "InfiniteJump",
	Description = "Infinite Jump"
})

game:GetService("UserInputService").JumpRequest:Connect(function()
	if InfiniteJump:GetValue() and IsThereChar() then
		game.Players.LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
	end
end)

local JumpHackEnabled = PlrTab:NewActionToggle({
	ID = "JumpHackEnabled",
	Description = "Enable Jump Power Hacks"
})

JumpHackEnabled:OnInputChanged(function()
	if not JumpHackEnabled:GetValue() and IsThereChar() then
		game.Players.LocalPlayer.Character.Humanoid.JumpPower = 36
	end
end)

local JumpHack = PlrTab:NewActionSlider({
	ID = "JumpHack",
	Description = "Player Jump Power",
	BypassInputMax = true,
	DefaultValue = 36,
	MaxValue = 108,
	MinValue = 0,
})

local Noclip = PlrTab:NewActionToggle({
	ID = "Noclip",
	Text = "Enable Noclip"
})
Noclip:OnInputChanged(function()
	PU.NoClip = Noclip:GetValue()
end)

-- ESPs

local ESPTab = UI:NewTab({
	ID = "ESPTab",
	Name = "👁️ ESPs"
})

local BeastHighlights = {}
local BeastESP = ESPTab:NewActionToggle({
	ID = "BeastESP",
	Description = "Beast ESP"
})
function UpdateBeastESP()
	for i, v in pairs(BeastHighlights) do
		if not BeastESP:GetValue() then
			table.remove(BeastHighlights, i)
			v:Destroy()
		elseif v.Adornee == nil then
			table.remove(BeastHighlights, i)
			v:Destroy()
		end
	end
	if BeastESP:GetValue() then
		for i, v in pairs(game.Players:GetPlayers()) do
			if v.Character and v.Character:FindFirstChild("BeastPowers") and v ~= game.Players.LocalPlayer and not v:FindFirstChild("KHHighlight") then
				local NewHighlight = Instance.new("Highlight")
				NewHighlight.Name = "KHHighlight"
				NewHighlight.Adornee = v.Character
				NewHighlight.Parent = v.Character
				NewHighlight.FillColor = Color3.fromRGB(200, 50, 50)
				NewHighlight.OutlineColor = Color3.fromRGB(255, 50, 50)
				table.insert(BeastHighlights, NewHighlight)
			end
		end
	else
		for i, v in pairs(BeastHighlights) do
			v:Destroy()
		end
	end
end

BeastESP:OnInputChanged(UpdateBeastESP)

local PlrHighlights = {}
local PlrRagTimeBillboards = {}
local PlrESP = ESPTab:NewActionToggle({
	ID = "PlayerESP",
	Description = "Player ESP"
})
local ShowPlrRagTime = ESPTab:NewActionToggle({
	ID = "ShowPlrRagTime",
	Description = "Show Player Ragdoll Time"
})
function UpdatePlrESP()
	for i = #PlrHighlights, 1, -1 do
		local v = PlrHighlights[i]
		if not v or (v and v.Adornee == nil) or (v and v.Adornee and v.Adornee.Parent and v.Adornee.Parent:FindFirstChild("BeastPowers")) or not PlrESP:GetValue() then
			if v then
				v:Destroy()
			end
			table.remove(PlrHighlights, i)
		end
	end
	if PlrESP:GetValue() then
		for i, v in pairs(game.Players:GetPlayers()) do
			if v.Character and not v.Character:FindFirstChild("BeastPowers") and v ~= game.Players.LocalPlayer and not v:FindFirstChild("KHHighlight") then
				local NewHighlight = Instance.new("Highlight")
				NewHighlight.Name = "KHHighlight"
				NewHighlight.Adornee = v.Character
				NewHighlight.FillColor = Color3.fromRGB(0, 230, 0)
				NewHighlight.OutlineColor = Color3.fromRGB(0, 255, 0)
				NewHighlight.Parent = v.Character
				table.insert(PlrHighlights, NewHighlight)
			end
		end
	else
		for i, v in pairs(PlrHighlights) do
			v:Destroy()
		end
	end
end
function UpdateShowPlrRagTime()
	local function PlrDown(v)
		return v:FindFirstChild("TempPlayerStatsModule")
			and v ~= game.Players.LocalPlayer
			and v.TempPlayerStatsModule:FindFirstChild("Ragdoll")
			and v.TempPlayerStatsModule:FindFirstChild("ActionProgress")
			and v.TempPlayerStatsModule.Ragdoll.Value
	end

	if ShowPlrRagTime:GetValue() then
		for i, v in pairs(game.Players:GetPlayers()) do
			if IsThereChar(v) and PlrDown(v) and not PlrRagTimeBillboards[v] then
				local NewBillboard = Instance.new("BillboardGui")
				NewBillboard.AlwaysOnTop = true
				NewBillboard.ExtentsOffsetWorldSpace = Vector3.new(0, 1.25, 0)
				NewBillboard.Size = UDim2.new(0, 200, 0, 50)

				local NewLabel = Instance.new("TextLabel")
				NewLabel.BackgroundTransparency = 1
				NewLabel.TextStrokeTransparency = 0
				NewLabel.TextColor3 = Color3.new(1, 1, 1)
				NewLabel.TextScaled = true
				NewLabel.Size = UDim2.new(1, 0, 1, 0)
				NewLabel.RichText = true

				NewLabel.Parent = NewBillboard
				NewBillboard.Parent = v.Character
				PlrRagTimeBillboards[v] = NewBillboard
			end
		end
	end

	for i, v in pairs(PlrRagTimeBillboards) do
		if not v or not v.Parent or not i or not i.Parent or not PlrDown(i) or not IsThereChar(i) or not ShowPlrRagTime:GetValue() then
			if v then
				v:Destroy()
			end
			PlrRagTimeBillboards[i] = nil
		else
			v.TextLabel.Text = i.Name .. " | Downed " .. tostring(math.floor(i.TempPlayerStatsModule.ActionProgress.Value * 100)) .. "%"
		end
	end
end
PlrESP:OnInputChanged(UpdatePlrESP)
ShowPlrRagTime:OnInputChanged(UpdateShowPlrRagTime)

local ExitDoorHighlights = {}
local ExitESP = ESPTab:NewActionToggle({
	ID = "ExitESP",
	Description = "Exit doors ESP"
})
function UpdateExitESP()
	for i = #ExitDoorHighlights, 1, -1 do
		local v = ExitDoorHighlights[i]
		if (v and v.Adornee == nil) or not ExitESP:GetValue() or not v then
			if v then
				v:Destroy()
			end
			table.remove(ExitDoorHighlights, i)
		end
	end
	local CurrentMap = game.ReplicatedStorage.CurrentMap.Value
	if ExitESP:GetValue() and CurrentMap then
		for i, v in pairs(CurrentMap:GetChildren()) do
			if v.Name == "ExitDoor" and not v:FindFirstChild("KHHighlight") then
				local NewHighlight = Instance.new("Highlight")
				NewHighlight.Name = "KHHighlight"
				NewHighlight.Adornee = v
				NewHighlight.FillColor = Color3.fromRGB(220, 220, 50)
				NewHighlight.OutlineColor = Color3.fromRGB(255, 255, 100)
				NewHighlight.Parent = v
				table.insert(ExitDoorHighlights, NewHighlight)
			end
		end
	end
end
ExitESP:OnInputChanged(UpdateExitESP)

local PodHighlights = {}
local PodESP = ESPTab:NewActionToggle({
	ID = "PodESP",
	Description = "Freeze Pods ESP"
})
function UpdatePodESP()
	for i = #PodHighlights, 1, -1 do
		local v = PodHighlights[i]
		if (v and v.Adornee == nil) or not PodESP:GetValue() or not v then
			if v then
				v:Destroy()
			end
			table.remove(PodHighlights, i)
		end
	end
	local CurrentMap = game.ReplicatedStorage.CurrentMap.Value
	if PodESP:GetValue() and CurrentMap then
		for i, v in pairs(CurrentMap:GetChildren()) do
			if v.Name == "FreezePod" and not v:FindFirstChild("KHHighlight") then
				local NewHighlight = Instance.new("Highlight")
				NewHighlight.Name = "KHHighlight"
				NewHighlight.Adornee = v
				NewHighlight.FillColor = Color3.fromRGB(0, 150, 255)
				NewHighlight.OutlineColor = Color3.fromRGB(0, 170, 255)
				NewHighlight.Parent = v
				table.insert(PodHighlights, NewHighlight)
			end
		end
	end
end
PodESP:OnInputChanged(UpdatePodESP)

local LockerHighlights = {}
local LockerESP = ESPTab:NewActionToggle({
	ID = "LockerESP",
	Description = "Lockers ESP"
})
function UpdateLockerESP()
	for i = #LockerHighlights, 1, -1 do
		local v = LockerHighlights[i]
		if (v and v.Adornee == nil) or not LockerESP:GetValue() or not v then
			if v then
				v:Destroy()
			end
			table.remove(LockerHighlights, i)
		end
	end
	if LockerESP:GetValue() then
		for i, v in pairs(game:GetService("CollectionService"):GetTagged("LOCKER")) do
			if not v:FindFirstChild("KHHighlight") then
				local NewHighlight = Instance.new("Highlight")
				NewHighlight.Name = "KHHighlight"
				NewHighlight.Adornee = v
				NewHighlight.FillColor = Color3.fromRGB(210, 210, 0)
				NewHighlight.FillTransparency = 0.75
				NewHighlight.OutlineColor = Color3.fromRGB(230, 230, 0)
				NewHighlight.OutlineTransparency = 0.25
				NewHighlight.Parent = v
				table.insert(LockerHighlights, NewHighlight)
			end
		end
	end
end
LockerESP:OnInputChanged(UpdateLockerESP)

local VentHighlights = {}
local VentESP = ESPTab:NewActionToggle({
	ID = "VentESP",
	Description = "Vents ESP"
})
function UpdateVentESP()
	for i = #VentHighlights, 1, -1 do
		local v = VentHighlights[i]
		if not VentESP:GetValue() then
			for i, v in pairs(v:GetChildren()) do
				if v:IsA("SurfaceGui") and v.Name == "KHHighlight" then
					v:Destroy()
				end
			end
			table.remove(VentHighlights, i)
		end
	end
	local Debounce = 0
	if VentESP:GetValue() and game.ReplicatedStorage.CurrentMap.Value then
		for i, v in pairs(game.ReplicatedStorage.CurrentMap.Value:GetDescendants()) do
			Debounce += 1
			if Debounce >= 100 then
				task.wait()
				Debounce = 0
			end
			if not v:FindFirstChild("KHHighlight") and v:IsA("BasePart") and string.find(string.lower(v.Name), "ventblock") then
				local function NewSUI(Face)
					local NewHighlight = Instance.new("SurfaceGui")
					NewHighlight.Name = "KHHighlight"
					NewHighlight.Adornee = v
					NewHighlight.AlwaysOnTop = true
					NewHighlight.Face = Face
					NewHighlight.Parent = v

					local NewFrame = Instance.new("Frame")
					NewFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 200)
					NewFrame.Transparency = 0.6
					NewFrame.Size = UDim2.new(1, 0, 1, 0)
					NewFrame.Parent = NewHighlight
				end

				NewSUI(Enum.NormalId.Front)
				NewSUI(Enum.NormalId.Back)
				NewSUI(Enum.NormalId.Left)
				NewSUI(Enum.NormalId.Right)
				NewSUI(Enum.NormalId.Top)
				NewSUI(Enum.NormalId.Bottom)

				table.insert(VentHighlights, v)
			end
		end
	end
end
VentESP:OnInputChanged(UpdateVentESP)

local PCESP = ESPTab:NewActionToggle({
	ID = "PCESP",
	Description = "Computer ESP"
})
local PCProgESP = ESPTab:NewActionToggle({
	ID = "PCProgESP",
	Description = "Show Computer Progress"
})
PCESP:OnInputChanged(function()
	if not PCESP:GetValue() and PCProgESP:GetValue() then
		PCProgESP:SetValue(false)
		PCProgESP:Update()
	end
end)
PCProgESP:OnInputChanged(function()
	if not PCESP:GetValue() and PCProgESP:GetValue() then
		PCESP:SetValue(true)
		PCESP:Update()
	end
end)
local PCProgESPSlideSize = ESPTab:NewActionSlider({
	ID = "PCProgESPSlideSize",
	Description = "Show Computer Progress Size",
	MaxValue = 2,
	MinValue = 1,
	DefaultValue = 2
})

local UpdateAllESP = ESPTab:NewActionActivate({
	ID = "UpdateAllESP",
	Description = "Update All ESPs"
})
UpdateAllESP:OnActivated(function()
	UpdateLockerESP()
	UpdatePodESP()
	UpdateExitESP()
	UpdatePlrESP()
	UpdateBeastESP()
end)

-- Teleport Tab

local TeleportTab = UI:NewTab({
	ID = "TeleportTab",
	Name = "👾 Teleport Tab"
})

TeleportTab:NewHeader({Text = "To Player Teleportation"})
local ToPlayerTeleportActivate = TeleportTab:NewActionActivate({ID = "ToPlayerTeleportActivate", Text = "Teleport to Selected Player"})
local ToPlayerTeleportSelection = TeleportTab:NewActionDropDown({ID = "ToPlayerTeleportSelection", Text = "Player Selection", Values = {}, DoNotSave = true})
-- To Player Teleport
ToPlayerTeleportActivate:OnInputChanged(function()
	local ToPlayer = game.Players:FindFirstChild(ToPlayerTeleportSelection:GetValue() or "")
	if ToPlayer and IsThereChar(ToPlayer) and IsThereChar() then
		game.Players.LocalPlayer.Character:PivotTo(ToPlayer.Character:GetPivot())
	elseif not ToPlayer or not IsThereChar(ToPlayer) then
		UI:NewNotification({NotifyType = "StatusError", Title = "Cannot Teleport Now", Text	= "Cannot Find Player, Either Dead or Left"})
	else
		UI:NewNotification({NotifyType = "StatusError", Title = "Cannot Teleport Now", Text	= "Cannot Teleport when LocalPlayer has No Character"})
	end
end)

-- Farming

local FarmTab = UI:NewTab({
	ID = "FarmTab",
	Name = "🤖 Survivor Farming"
})

local FarmWarning = FarmTab:NewActionActivate({
	ID = "FarmWarning",
	Icon = "http://www.roblox.com/asset/?id=71870986260398",
	Description = "Be warned! People can report you in the AW Apps Discord Server using Auto Farm we highly suggest using a private server."
})

local FarmTabBeast = UI:NewTab({
	ID = "FarmTabBeast",
	Name = "🤖 Beast Farming"
})
local FarmWarning2 = FarmTabBeast:NewActionActivate({
	ID = "FarmWarning2",
	Icon = "http://www.roblox.com/asset/?id=71870986260398",
	Description = "Be warned! People can report you in the AW Apps Discord Server using Auto Farm we highly suggest using a private server."
})

-- Misc

local MiscTab = UI:NewTab({
	ID = "MiscTab",
	Name = "🔣 Miscellaneous"
})

MiscTab:NewHeader({Text = "Information"})
local BeastPowerInfo = MiscTab:NewActionActivate({
	ID = "BeastPowerInfo",
	Icon = "http://www.roblox.com/asset/?id=71870986260398",
	Description = "Beast Power : "
})
local BeastPowerInfoNotif = MiscTab:NewActionToggle({
	ID = "BeastPowerInfoNotif",
	Description = "Notify beast power once round starts"
})

MiscTab:NewHeader({Text = "Others"})

local HitboxScale = MiscTab:NewActionSlider({
	ID = "HitboxScale",
	Description = "Hitbox Scale of Other Players (Useful when beast)",
	MaxValue = 8,
	MinValue = 1,
	BypassInputMax = true
})

local BeastTieRange = MiscTab:NewActionSlider({
	ID = "BeastTieRange",
	Description = "Auto Tie Range",
	MaxValue = 20,
	MinValue = 0,
	DefaultValue = 0,
	BypassInputMax = true
})

local UnTieMe = MiscTab:NewActionToggle({
	ID = "UnTieMe",
	Description = "Auto Remove Rope (Only Myself)"
})

local Beast3rdPerson = MiscTab:NewActionToggle({
	ID = "Beast3rdPerson",
	Description = "Enable 3rd Person when Beast"
}) 
Beast3rdPerson:OnInputChanged(function()
	if TempPlayerStatsModule and TempPlayerStatsModule.IsBeast.Value and not Beast3rdPerson:GetValue() then
		game.Players.LocalPlayer.CameraMode = Enum.CameraMode.LockFirstPerson
	end
end)

local AntiPCError = MiscTab:NewActionToggle({
	ID = "AntiPCError",
	Description = "Anti PC Error"
})

local FullBright = MiscTab:NewActionToggle({
	ID = "FullBright",
	Description = "Full Bright"
})

local RagdollMovement = MiscTab:NewActionToggle({
	ID = "RagdollMovement",
	Description = "Disable Ragdoll (Buggy)"
})
RagdollMovement:OnInputChanged(function()
	if TempPlayerStatsModule and TempPlayerStatsModule.Ragdoll.Value and RagdollMovement:GetValue() then
		TempPlayerStatsModule.Ragdoll.Value = false
	end
end)

MiscTab:NewHeader({Text = "Hide on Seer Ability"})
local AutoHideFromSeer = MiscTab:NewActionToggle({
	ID = "AutoHideFromSeer",
	Description = "Auto Hide From Seer"
})
local ReturnFromHideSeer = MiscTab:NewActionToggle({
	ID = "ReturnFromHideSeer",
	Description = "Return back to Position after Hiding From Seer"
})

MiscTab:NewHeader({Text = "Speed up Hacking"})
local SpeedHackCrawl = MiscTab:NewActionToggle({
	Description = "Speed up Hacking (via Crawl/Jump/Air)"
})
local HackCrawlWPeople = MiscTab:NewActionToggle({
	ID = "HackCrawlWPeople",
	Text = "Speed up Hacking with People"
})
local HackCrawlType = MiscTab:NewActionDropDown({
	ID = "HackCrawlType",
	Text = "Hacking Speed Up Type",
	Values = {{Name = "Crawl", Value = 0}, {Name = "Jump", Value = 1}, {Name = "Air", Value = 2}}
})
local HackCrawlTime = MiscTab:NewActionSlider({
	ID = "HackCrawlTime",
	Text = "Hack Crawl Time (-1 for auto)",
	MinValue = 1/16,
	MaxValue = 1,
	DefaultValue = 1/3,
	AllowDecimal = true,
	BypassInputMax = true,
	BypassInputMin = -1
})
local HackCrawlDelay = MiscTab:NewActionSlider({
	ID = "HackCrawlDelay",
	Text = "Delay between next crawl/jump/air",
	MaxValue = 8,
	MinValue = 1,
	DefaultValue = -1,
	AllowDecimal = true,
})

MiscTab:NewHeader({Text = "Moderator Joined Alert"})
local AlertModerator = MiscTab:NewActionToggle({ID = "AlertModerator", Text = "Alert when Moderator Joins"})
local KickOnModerator = MiscTab:NewActionToggle({ID = "KickOnModerator", Text = "Leave / Get Kicked when Moderator Joins"})

MiscTab:NewHeader({Text = "Beast Near Hiding"})
local HideBeastNear = MiscTab:NewActionToggle({
	ID = "HideBeastNear",
	Description = "Hide when beast is near & on ragdoll (Only useful for auto farm)"
})
local HideBeastNearDist = MiscTab:NewActionSlider({
	ID = "HideBeastNearDist",
	Description = "Distance from beast to hide (Make this higher if you have high latency or low FPS)",
	MaxValue = 60,
	MinValue = 25,
	BypassInputMax = true,
	BypassInputMin = true
})
HideBeastNear:OnInputChanged(function()
	if not HideBeastNear:GetValue() then
		bnhide = false
	end
end)

MiscTab:NewHeader({Text = "Debugging"})
local EnableDebuggingPrint = MiscTab:NewActionToggle({
	ID = "EnableDebuggingPrint",
	Description = "Enable Debugging Print (Can be detected, only for debugging)"
})
function SafePrint(Message, Warn)
	if EnableDebuggingPrint:GetValue() == false then
		return
	end

	if Warn and EnableDebuggingPrint:GetValue() then
		warn(Message)
	elseif EnableDebuggingPrint:GetValue() then
		print(Message)
	end
end

-- Troll

local TrollTab = UI:NewTab({
	ID = "TrollTab",
	Name = "🤣 Trolling"
})


TrollTab:NewHeader({Text = "Beast Trolling"})
local SlowBeast = TrollTab:NewActionToggle({
	ID = "SlowBeast",
	Description = "Slow down Beast"
})
local UnTieAll = TrollTab:NewActionToggle({
	ID = "UnTieAll",
	Description = "UnTie Everyone"
})

local FlingBeast = TrollTab:NewActionActivate({
	ID = "FlingBeast",
	Text = "Fling Beast (May not Work, Beast can get teleported back)"
})

TrollTab:NewHeader({Text = "Piggyback"})
local PiggyBackToggle = TrollTab:NewActionToggle({ID = "PiggyBackToggle", Text = "Enable PiggyBack Player"})
local PiggyBackSelection = TrollTab:NewActionDropDown({ID = "PiggyBackSelection", Text = "Player Selection", Values = {}, DoNotSave = true})

PiggyBackSelection:OnInputChanged(function()
	if PiggyBackToggle:GetValue() then
		PU.PiggyBack = game.Players:FindFirstChild(PiggyBackSelection:GetValue() or "")
	end
end)
PiggyBackToggle:OnInputChanged(function()
	if PiggyBackToggle:GetValue() then
		PU.PiggyBack = game.Players:FindFirstChild(PiggyBackSelection:GetValue() or "")
	else
		PU.PiggyBack = nil
	end
end)

local OnFling = false
FlingBeast:OnInputChanged(function()
	if OnFling then
		UI:NewNotification({NotifyType = "StatusError", Title = "Cannot Fling Now", Text = "Cannot fling when already flinging someone"})
	end
	OnFling	= true
	for i, v in pairs(game.Players:GetPlayers()) do
		if v:FindFirstChild("TempPlayerStatsModule") and v.TempPlayerStatsModule:FindFirstChild("IsBeast") and v.TempPlayerStatsModule.IsBeast.Value == true and v ~= game.Players.LocalPlayer then
			local Success, Result = pcall(function() return PU:FlingPlayer(v) end)
			if Result == "PlayerNotReady" then
				UI:NewNotification({NotifyType = "StatusError", Title = "Cannot Fling Now", Text = "Cannot fling now either you are dead or the person had left or is dead"})
			elseif Result == "Timedout" then
				UI:NewNotification({NotifyType = "StatusError", Title = "Fling Possibly Failed", Text = "Fling Timedout took too long"})
			end
			if not Success then
				UI:NewNotification({NotifyType = "StatusError", Title = "Internal Error", Text = "Something went wrong internally with the fling system"})
			end
			OnFling = false
			return
		end
	end
	UI:NewNotification({NotifyType = "StatusError", Title = "Cannot Fling Now", Text = "Cannot find Beast"})
	OnFling = false
end)

-- Sound board troll
TrollTab:NewHeader({Text = "Sound Trolling (Play)"})
local STPlaySoundServiceCorrectSound = TrollTab:NewActionActivate({ID = "PlaySoundServiceCorrectSound", Text = "Play (SoundService.CorrectSound)"})
local STPlaySoundServiceWarningSound = TrollTab:NewActionActivate({ID = "PlaySoundServiceWarningSound", Text = "Play (SoundService.WarningSound)"})
local STPlaySoundServiceSafeSound = TrollTab:NewActionActivate({ID = "PlaySoundServiceSafeSound", Text = "Play (SoundService.SafeSound)"})
local STPlaySoundServiceDetectedSound = TrollTab:NewActionActivate({ID = "PlaySoundServiceDetectedSound", Text = "Play (SoundService.DetectedSound)"})
local STPlaySoundServiceSeenSound = TrollTab:NewActionActivate({ID = "PlaySoundServiceSeenSound", Text = "Play (SoundService.SeenSound)"})

local STPlayMapErrorSoundAll = TrollTab:NewActionActivate({ID = "PlayMapErrorSoundAll", Text = "Play (Map.ErrorSound[All])"})
local STPlayMapErrorSoundOne = TrollTab:NewActionActivate({ID = "PlayMapErrorSoundOne", Text = "Play (Map.ErrorSound[One])"})
local STPlayMapSoundExitsUnlock = TrollTab:NewActionActivate({ID = "PlayMapSoundExitsUnlock", Text = "Play (Map.SoundExitsUnlock)"})

TrollTab:NewHeader({Text = "Sound Trolling (Spam)"})
local STSpamPercentage = TrollTab:NewActionSlider({ID = "STSpamPercentage", Text = "Spam Percentage", MinValue = 0, MaxValue = 100, DefaultValue = 50})

local STSpamSoundServiceCorrectSound = TrollTab:NewActionToggle({ID = "STSpamSoundServiceCorrectSound", Text = "Spam (SoundService.CorrectSound"})
local STSpamSoundServiceWarningSound = TrollTab:NewActionToggle({ID = "STSpamSoundServiceWarningSound", Text = "Spam (SoundService.WarningSound"})
local STSpamSoundServiceSafeSound = TrollTab:NewActionToggle({ID = "STSpamSoundServiceSafeSound", Text = "Spam (SoundService.SafeSound"})
local STSpamSoundServiceDetectedSound = TrollTab:NewActionToggle({ID = "STSpamSoundServiceDetectedSound", Text = "Spam (SoundService.DetectedSound"})
local STSpamSoundServiceSeenSound = TrollTab:NewActionToggle({ID = "STSpamSoundServiceSeenSound", Text = "Spam (SoundService.SeenSound"})

local STSpamMapErrorSoundAll = TrollTab:NewActionToggle({ID = "STSpamMapErrorSoundAll", Text = "Spam (Map.ErrorSound[All])"})
local STSpamMapErrorSoundOne = TrollTab:NewActionToggle({ID = "STSpamMapErrorSoundOne", Text = "Spam (Map.ErrorSound[One])"})
local STSpamMapSoundExitsUnlock = TrollTab:NewActionToggle({ID = "SpamMapSoundExitsUnlock", Text = "Spam (Map.SoundExitsUnlock)"})

STPlaySoundServiceCorrectSound:OnInputChanged(function() game:GetService("SoundService").CorrectSound:Play() end)
STPlaySoundServiceWarningSound:OnInputChanged(function() game:GetService("SoundService").WarningSound:Play() end)
STPlaySoundServiceSafeSound:OnInputChanged(function() game:GetService("SoundService").SafeSound:Play() end)
STPlaySoundServiceDetectedSound:OnInputChanged(function() game:GetService("SoundService").DetectedSound:Play() end)
STPlaySoundServiceSeenSound:OnInputChanged(function() game:GetService("SoundService").SeenSound:Play() end)

function STFPMapErrorSound(Single)
	if Single then
		if game.ReplicatedStorage.CurrentMap.Value then
			local v = game.ReplicatedStorage.CurrentMap.Value:FindFirstChild("ComputerTable")
			if v and v:FindFirstChild("Screen") and v.Screen:FindFirstChild("ErrorSound") then
				v.Screen.ErrorSound:Play()
			end
		end
	else
		if game.ReplicatedStorage.CurrentMap.Value then
			for i, v in pairs(game.ReplicatedStorage.CurrentMap.Value:GetChildren()) do
				if v.Name == "ComputerTable" and v:FindFirstChild("Screen") and v.Screen:FindFirstChild("ErrorSound") then
					v.Screen.ErrorSound:Play()
				end
			end
		end
	end
end 
function STFPMapSoundExitsUnlock()
	if game.ReplicatedStorage.CurrentMap.Value and game.ReplicatedStorage.CurrentMap.Value:FindFirstChild("FacilitySiren") and game.ReplicatedStorage.CurrentMap.Value.FacilitySiren:FindFirstChild("SoundExitsUnlock") then
		game.ReplicatedStorage.CurrentMap.Value.FacilitySiren.SoundExitsUnlock:Play()
	end
end

STPlayMapErrorSoundAll:OnInputChanged(function() STFPMapErrorSound(false) end)
STPlayMapErrorSoundOne:OnInputChanged(function() STFPMapErrorSound(true) end)
STPlayMapSoundExitsUnlock:OnInputChanged(STFPMapSoundExitsUnlock)

-- Spam Audio Tick System
coroutine.wrap(function()
	local MapSoundTimes = {
		ErrorSound = 0.967
	}

	local DTs = {
		SScorrectsound = 0,
		SSwarnsound = 0,
		SSsafesound = 0,
		SSdetsound = 0,
		SSseesound = 0,

		SpamErrorSoundAllDT = 0,
		SpamErrorSoundOneDT = 0,
		SpamExitsUnlockDT = 0
	}

	local Spams = {
		{"SScorrectsound", STSpamSoundServiceCorrectSound, game:GetService("SoundService").CorrectSound},
		{"SSwarnsound", STSpamSoundServiceWarningSound, game:GetService("SoundService").WarningSound},
		{"SSsafesound", STSpamSoundServiceSafeSound, game:GetService("SoundService").SafeSound},
		{"SSdetsound", STSpamSoundServiceDetectedSound, game:GetService("SoundService").DetectedSound},
		{"SSseesound", STSpamSoundServiceSeenSound, game:GetService("SoundService").SeenSound}
	}

	while true do
		local DT = task.wait()
		local mul = STSpamPercentage:GetValue() / 100

		for i, v in pairs(DTs) do
			DTs[i] += DT
		end

		for i, v in pairs(Spams) do
			if DTs[v[1]] > v[3].TimeLength * mul and v[2]:GetValue() then
				DTs[v[1]] = 0
				v[3]:Play()
			end
		end

		if STSpamMapErrorSoundOne:GetValue() and DTs.SpamErrorSoundOneDT >= (MapSoundTimes.ErrorSound * mul) then
			DTs.SpamErrorSoundOneDT = 0
			STFPMapErrorSound(true)
		end

		if STSpamMapErrorSoundAll:GetValue() and DTs.SpamErrorSoundAllDT >= (MapSoundTimes.ErrorSound * mul) then
			DTs.SpamErrorSoundAllDT = 0
			STFPMapErrorSound(false)
		end

		if game.ReplicatedStorage.CurrentMap.Value and game.ReplicatedStorage.CurrentMap.Value:FindFirstChild("FacilitySiren") and game.ReplicatedStorage.CurrentMap.Value.FacilitySiren:FindFirstChild("SoundExitsUnlock") then
			if DTs.SpamExitsUnlockDT >= (game.ReplicatedStorage.CurrentMap.Value.FacilitySiren:FindFirstChild("SoundExitsUnlock").TimeLength * mul) and STSpamMapSoundExitsUnlock:GetValue() then
				DTs.SpamExitsUnlockDT = 0
				STFPMapSoundExitsUnlock()
			end
		end
	end
end)()

-- NOTE: Farming
local AntiAFK = FarmTab:NewActionToggle({
	ID = "AntiAFK",
	Description = "Anti AFK"
})
local ManualComputerFarm = FarmTab:NewActionActivate({
	ID = "ManualComputerFarm",
	Description = "Survivor Farm Manual Activation"
})
local ComputerAutoFarm = FarmTab:NewActionToggle({
	ID = "ComputerAutoFarm",
	Description = "Survivor Auto Farm"
})
local KeepComputer = FarmTab:NewActionToggle({
	ID = "KeepComputer",
	Text = "Never switch Computer when already hacking one"
})
local AutoHideHack = FarmTab:NewActionToggle({
	ID = "AutoHideHack",
	Text = "Auto Hide on Hack"
})
local UseMinimalTeleport = FarmTab:NewActionToggle({
	ID = "UseMinimalTeleport",
	Text = "Use the most Minimal Teleport Duration"
})
UseMinimalTeleport:SetValue(true)
UseMinimalTeleport:Update()
local TeleportInsteadTweenPCFarm = FarmTab:NewActionToggle({
	ID = "TeleportInsteadTweenPCFarm",
	Text = "Teleport to Computer instead of tweening"
})
local TeleportToFreezePod = FarmTab:NewActionToggle({
	ID = "TeleportToFreezePod",
	Description = "Teleport to Freeze Pod instead of tweening"
})
local TeleportToExitDoor = FarmTab:NewActionToggle({
	ID = "TeleportToExitDoor",
	Description = "Teleport To Exit Door instead of tweening"
})
local FreezePodOnce = FarmTab:NewActionToggle({
	ID = "FreezePodOnce",
	Description = "Only save players once"
})
FreezePodOnce:SetValue(true)
FreezePodOnce:Update()
local ExitCancel = FarmTab:NewActionToggle({
	ID = "ExitCancel",
	Description = "Do not Exit (Allows the beast to capture you after hacking all pc)"
})
local WaitForSave = FarmTab:NewActionToggle({
	ID = "WaitForSave",
	Description = "Save First instead of Hacking first"
})
local WaitSaveDelay = FarmTab:NewActionSlider({
	ID = "WaitSaveDelay",
	Description = "Save Delay, great for having multiple accounts",
	MinValue = 0,
	MaxValue = 5,
	AllowDecimal = true,
	BypassInputMax = true
})
if WaitForSave:GetValue() then
	WaitSaveDelay.Instance.Visible = true
else
	WaitSaveDelay.Instance.Visible = false
end
WaitForSave:OnInputChanged(function()
	if WaitForSave:GetValue() then
		WaitSaveDelay.Instance.Visible = true
	else
		WaitSaveDelay.Instance.Visible = false
	end
end)
local ForcedTogglesDisabled = FarmTab:NewActionToggle({
	ID = "ForcedTogglesDisabled",
	Description = "Disable Forced Toggles, (Allows you to Disable/Enable Auto Hide, Anti PC Error & Etc) "
})
local FarmTweenSpeed = FarmTab:NewActionSlider({
	ID = "FarmTweenSpeed",
	Description = "Survivor Farm Tween Speed, (Higher Numbers may get you banned/kicked)",
	MaxValue = 20,
	DefaultValue = 16,
	MinValue = 10,
	BypassInputMax = true
})
local WaitTweenFast = FarmTab:NewActionSlider({
	ID = "WaitTweenFast",
	Text = "Pause when Tween is Fast",
	MaxValue = 15,
	MinValue = 5,
	BypassInputMax = true,
	BypassInputMin = true,
})
local MinimumDuration = FarmTab:NewActionSlider({
	ID = "MinimumDuration",
	Text = "Minimum delay of Teleport",
	MaxValue = 15,
	MinValue = 5,
	BypassInputMax = true,
	BypassInputMin = true,
})
local StudsPerDelay = FarmTab:NewActionSlider({
	ID = "StudsPerDelay",
	Text = "Studs per Delay (seconds)",
	MaxValue = 20,
	DefaultValue = 16,
	MinValue = 10,
	BypassInputMax = true,
	BypassInputMin = true,
})
UseMinimalTeleport:OnInputChanged(function()
	if UseMinimalTeleport:GetValue() and TeleportInsteadTweenPCFarm:GetValue()  then
		StudsPerDelay.Instance.Visible = true
		MinimumDuration.Instance.Visible = true
	else
		StudsPerDelay.Instance.Visible = false
		MinimumDuration.Instance.Visible = false
	end
end)
TeleportInsteadTweenPCFarm:OnInputChanged(function()
	if TeleportInsteadTweenPCFarm:GetValue() then
		if UseMinimalTeleport:GetValue() then
			StudsPerDelay.Instance.Visible = true
			MinimumDuration.Instance.Visible = true
		end
		WaitTweenFast.Config.Text = "Delay of Teleport"
		WaitTweenFast:Update()
		if WaitTweenFast:GetValue() < 12 then
			UI:NewNotification({NotifyType = "StatusWarning", Title = "Auto Farm Management", Text = "Delay of Teleport is too fast Anti-Cheat may kick you recommended: 12s"})
		end
	else
		StudsPerDelay.Instance.Visible = false
		MinimumDuration.Instance.Visible = false
		WaitTweenFast.Config.Text = "Pause when Tween is Fast"
		WaitTweenFast:Update()
	end
end)
local TriggerPrioritization = FarmTab:NewActionSlider({
	ID = "TriggerPrioritization",
	Description = "Trigger Prioritization (Useful for multiple accounts in the same server, have different numbers for each)",
	MaxValue = 3,
	MinValue = 1,
})
local TriggerUnCampOut = FarmTab:NewActionSlider({
	ID = "TriggerUnCampOut",
	Description = "Beast Trigger Untrigger Hide Camp Timeout",
	MaxValue = 10,
	MinValue = 1,
	BypassInputMax = true,
})
local CampTweenAnimOut = FarmTab:NewActionSlider({
	ID = "CampTweenAnimOut",
	Description = "Beast Tween Camping Timeout",
	MaxValue = 60,
	MinValue = 20,
	BypassInputMax = true,
	BypassInputMin = true
})
local CampHackOut = FarmTab:NewActionSlider({
	ID = "CampHackOut",
	Description = "Beast PC Hacking Camping Timeout",
	MaxValue = 60,
	MinValue = 20,
	BypassInputMax = true,
	BypassInputMin = true
})
local HackBanUnbanTime = FarmTab:NewActionSlider({
	ID = "HackBanUnbanTime",
	Description = "PC Hacking Unban Time",
	MaxValue = 10,
	MinValue = 1,
	BypassInputMax = true,
	BypassInputMin = true
})
local CampFreezePodOut = FarmTab:NewActionSlider({
	ID = "CampFreezePodOut",
	Description = "Beast Freeze Pod Camping Timeout",
	MaxValue = 60,
	MinValue = 20,
	BypassInputMax = true,
	BypassInputMin = true
})
local CampEscapeOut = FarmTab:NewActionSlider({
	ID = "CampEscapeOut",
	Description = "Beast Escape Camping Timeout",
	MaxValue = 60,
	MinValue = 20,
	BypassInputMax = true,
	BypassInputMin = true
})
local farmtasks = {}

-- NOTE: Survivor Farm Function
function DoSurvivorFarm()
	local DoNotTeleport = false

	local function PlayerReady()
		--[[repeat
			task.wait()
		until (not TempPlayerStatsModule.Ragdoll.Value and not TempPlayerStatsModule.Captured.Value and not UnTieMe:GetValue()) or  not TempPlayerStatsModule or TempPlayerStatsModule.IsBeast.Value or TempPlayerStatsModule.Health.Value <= 0 or not IsThereChar()]]
		if not TempPlayerStatsModule or TempPlayerStatsModule.IsBeast.Value or TempPlayerStatsModule.Health.Value <= 0 or not IsThereChar() then
			return false
		end
		return true
	end

	local function TaskGood()
		if string.find(string.lower(game.ReplicatedStorage.GameStatus.Value), "game over") or string.find(string.lower(game.ReplicatedStorage.GameStatus.Value), "intermission") or not PlayerReady() then
			return false
		end
		return true
	end

	local function GetMapObjects()
		local Result = {}
		Result.Computers = {}
		Result.FreezePods = {}
		Result.ExitDoors = {}

		if game.ReplicatedStorage.CurrentMap.Value then
			for i, v in pairs(game.ReplicatedStorage.CurrentMap.Value:GetChildren()) do
				if v.Name == "ComputerTable" then
					table.insert(Result.Computers, v)
				elseif v.Name == "FreezePod" then
					table.insert(Result.FreezePods, v)
				elseif v.Name == "ExitDoor" then
					table.insert(Result.ExitDoors, v)
				end
			end
		end

		return Result
	end
	local MapObjects = GetMapObjects()

	local IsFreeing = false
	local HadSaved = false
	local GoTween
	local CheckingPods = false

	local function FreeAllPods(ToGo: Part)
		if CheckingPods then return end
		CheckingPods = true
		for i, v in MapObjects.FreezePods do
			if TaskGood() and v:FindFirstChild("PodTrigger") and v.PodTrigger.ActionSign.Value == 31 and ((FreezePodOnce:GetValue() == true and HadSaved == false) or FreezePodOnce:GetValue() == false) then
				SafePrint("freeing")
				IsFreeing = true
				GoTween(v.PodTrigger, true, TeleportToFreezePod:GetValue())
				repeat
					task.wait()
					if not bnhide and v:FindFirstChild("PodTrigger") then
						game.Players.LocalPlayer.Character:PivotTo(v.PodTrigger.CFrame)
						game:GetService("ReplicatedStorage").RemoteEvent:FireServer("Input", "Trigger", true, v.PodTrigger.Event)
						game:GetService("ReplicatedStorage").RemoteEvent:FireServer("Input", "Action", true)
					end
				until not v:FindFirstChild("PodTrigger") or v.PodTrigger.ActionSign.Value ~= 31 or bnhideelapse >= CampFreezePodOut:GetValue()
				if bnhideelapse >= CampFreezePodOut:GetValue() then
					lpos = game.Players.LocalPlayer.Character:GetPivot()
				end
				if v:FindFirstChild("PodTrigger") and v.PodTrigger.ActionSign.Value ~= 31 then
					HadSaved = true
				end
				if ToGo then
					GoTween(ToGo, true, TeleportToFreezePod:GetValue())
				end
				IsFreeing = false
			end
		end
		CheckingPods = false
	end

	GoTween = function(Part: Part, IsPod: boolean, TeleportInstead: boolean, TeleportDelay: number)
		if not TeleportInstead then
			local Distance = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Part.Position).Magnitude
			local NewTween = game:GetService("TweenService"):Create(
				game.Players.LocalPlayer.Character.HumanoidRootPart,
				TweenInfo.new(Distance / FarmTweenSpeed:GetValue(), Enum.EasingStyle.Linear),
				{ CFrame = Part.CFrame }
			)
			NewTween:Play()

			repeat
				task.wait()
				-- Pause if hiding, vice versa
				if bnhide then
					NewTween:Pause()
					lpos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
				elseif NewTween.PlaybackState == Enum.PlaybackState.Paused then
					NewTween:Play()
				end

				-- Cancel tween & teleport instead if timedout or not taskgood cancel too, if there is pod cancel then free person
				if bnhideelapse >= CampTweenAnimOut:GetValue() then
					warn("Tween cancelled because camped timedout", true)
					lpos = Part.CFrame
					bnhideelapse = 0
					NewTween:Cancel()
				elseif not TaskGood() then
					SafePrint("cancelled r: task not good")
					NewTween:Cancel()
				elseif not IsFreeing and not IsPod and not CheckingPods then
					coroutine.wrap(function()
						FreeAllPods(Part)
					end)()
				elseif IsFreeing and not IsPod then
					SafePrint("cancelled r: freeing")
					NewTween:Cancel()
				end
			until NewTween.PlaybackState == Enum.PlaybackState.Completed or NewTween.PlaybackState == Enum.PlaybackState.Cancelled

			SafePrint("tween done")
		end
		if TeleportDelay and TeleportInstead then
			task.wait(TeleportDelay)
		end
		game.Players.LocalPlayer.Character:PivotTo(Part.CFrame)
	end

	local OnComputer = false
	local ChosenComputer = nil
	local ComputerBanList = {}
	local CurrentComputer = nil
	local FirstPC = true
	local LastPC = nil

	local function GetComputer(Computer: Model)
		if TaskGood() and Computer.Screen.BrickColor ~= BrickColor.new("Dark green") and not OnComputer then
			OnComputer = true

			local Prioritize = TriggerPrioritization:GetValue()

			local Triggers = nil

			if Prioritize == 1 then
				Triggers = {
					Computer:FindFirstChild("ComputerTrigger1"),
					Computer:FindFirstChild("ComputerTrigger2"),
					Computer:FindFirstChild("ComputerTrigger3"),
				}
			elseif Prioritize == 2 then
				Triggers = {
					Computer:FindFirstChild("ComputerTrigger2"),
					Computer:FindFirstChild("ComputerTrigger3"),
					Computer:FindFirstChild("ComputerTrigger1"),
				}
			else
				Triggers = {
					Computer:FindFirstChild("ComputerTrigger3"),
					Computer:FindFirstChild("ComputerTrigger1"),
					Computer:FindFirstChild("ComputerTrigger2"),
				}
			end

			local hadteleported = false

			for i, v in pairs(Triggers) do
				if v and TaskGood() and v.ActionSign.Value == 20 and Computer.Screen.BrickColor ~= BrickColor.new("Dark green") and ChosenComputer == Computer then
					local Distance = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Position).Magnitude

					if (Distance / FarmTweenSpeed:GetValue() < WaitTweenFast:GetValue()) and not FirstPC and not TeleportInsteadTweenPCFarm:GetValue() and LastPC ~= Computer then
						SafePrint("Tween < x, unsafe waiting paused", true)
						local Time = Distance / FarmTweenSpeed:GetValue()
						task.wait(WaitTweenFast:GetValue() - Time)
					end

					repeat
						task.wait()
					until not TaskGood() or bnhide == false or bnhideelapse >= CampHackOut:GetValue()
					if bnhideelapse >= CampHackOut:GetValue() then
						lpos = game.Players.LocalPlayer.Character:GetPivot()
					end

					if hadteleported or FirstPC or LastPC == Computer then
						GoTween(v, nil, TeleportInsteadTweenPCFarm:GetValue())
					else
						local GotDelay = WaitTweenFast:GetValue()
						if UseMinimalTeleport:GetValue() then
							local NewDelay = Distance / StudsPerDelay:GetValue()
							GotDelay = math.clamp(NewDelay, math.min(MinimumDuration:GetValue(), WaitTweenFast:GetValue()), WaitTweenFast:GetValue())
						end
						GoTween(v, nil, TeleportInsteadTweenPCFarm:GetValue(), GotDelay)
					end
					SafePrint("going to pc")
					hadteleported = true
					FirstPC = false
					LastPC = Computer

					if Computer.Screen.BrickColor == BrickColor.new("Dark green") then CurrentComputer = nil; OnComputer = false; return "ended: computer finished once there" end
					if not TaskGood() then CurrentComputer = nil; OnComputer = false; return "ended: task not good" end
					if v.ActionSign.Value ~= 20 or (ChosenComputer ~= Computer and ChosenComputer ~= nil) then continue end

					local Tries = 0
					repeat
						task.wait()
						FreeAllPods(v)
						if TaskGood() and not bnhide and not IsFreeing and TempPlayerStatsModule.CurrentAnimation.Value ~= "Typing" then
							Tries += 1
							if game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("KSAttachmentZVel") then
								game.Players.LocalPlayer.Character.HumanoidRootPart.KSAttachmentZVel.LinearVelocity.Enabled = false
							end
							game.Players.LocalPlayer.Character:PivotTo(v.CFrame)
							game:GetService("ReplicatedStorage").RemoteEvent:FireServer("Input", "Trigger", true, v.Event)
							game:GetService("ReplicatedStorage").RemoteEvent:FireServer("Input", "Action", true)
							task.wait(1/2)
							if game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("KSAttachmentZVel") then
								game.Players.LocalPlayer.Character.HumanoidRootPart.KSAttachmentZVel.LinearVelocity.Enabled = true
							end
						elseif TaskGood() and not bnhide and not IsFreeing then
							CurrentComputer = Computer
							Tries = 0
							if AutoHideHack:GetValue() then
								game.Players.LocalPlayer.Character:PivotTo(v.CFrame * CFrame.new(0, 50, 0))
								game:GetService("ReplicatedStorage").RemoteEvent:FireServer("Input", "Trigger", true, v.Event)
								game:GetService("ReplicatedStorage").RemoteEvent:FireServer("Input", "Action", true)
							end
						end
						if bnhideelapse >= CampHackOut:GetValue() and not IsFreeing then
							ComputerBanList[math.floor(DateTime.now().UnixTimestampMillis)] = Computer
							lpos = game.Players.LocalPlayer.Character:GetPivot()
							SafePrint("computer hack cancelled because timedout", true)
							OnComputer = false
							CurrentComputer = nil
							bnhideelapse = 0
							return "ended: beast is computer camp"
						end

						if Tries >= 5 and TaskGood() and not bnhide and not IsFreeing then
							CurrentComputer = nil
							OnComputer = false
							SafePrint("failed probably already occupied", true)
							local TriggerGood = false
							for i2, v2 in pairs(Triggers) do
								if v2 and v2.ActionSign.Value == 20 then
									TriggerGood = true
								end
							end
							if not TriggerGood then
								ComputerBanList[math.floor(DateTime.now().UnixTimestampMillis)] = Computer
							end
							return "ended: already occupied"
						end
					until not TaskGood() or Computer.Screen.BrickColor == BrickColor.new("Dark green") or (ChosenComputer ~= Computer and ChosenComputer ~= nil)
					SafePrint("done hack")
					if TaskGood() and TeleportInsteadTweenPCFarm:GetValue() then
						game:GetService("ReplicatedStorage").RemoteEvent:FireServer("Input", "Trigger", false, v.Event)
						game:GetService("ReplicatedStorage").RemoteEvent:FireServer("Input", "Action", false)
						game.Players.LocalPlayer.Character:PivotTo(v.CFrame * CFrame.new(0, 50, 0))
					end
					if Computer.Screen.BrickColor == BrickColor.new("Dark green") or (ChosenComputer ~= Computer and ChosenComputer ~= nil) then
						CurrentComputer = nil
						OnComputer = false
						return
					end
				end
			end

			CurrentComputer = nil
			OnComputer = false
		end
	end

	local function Run()
		local CancelComputers = false

		local LeastTriggers = 4
		local Closest = math.huge

		local ComputersLeft = 0

		if WaitForSave:GetValue() then
			repeat
				task.wait()
			until game.ReplicatedStorage.IsGameActive.Value
			task.wait(WaitSaveDelay:GetValue())
			repeat
				task.wait(WaitSaveDelay:GetValue())
				FreeAllPods()
			until not TaskGood() or HadSaved
		end

		-- Computer Finding Tick System
		coroutine.wrap(function()
			while TaskGood() do
				task.wait()
				ComputersLeft = 0
				LeastTriggers = 4
				Closest = math.huge

				if ChosenComputer and ChosenComputer.Screen.BrickColor == BrickColor.new("Dark green") then
					ChosenComputer = nil
				end

				for i, v in MapObjects.Computers do
					if v.Screen.BrickColor ~= BrickColor.new("Dark green") then
						ComputersLeft += 1
					end

					if ChosenComputer and KeepComputer:GetValue() then
						continue
					end

					local UseTrigger = v:FindFirstChild("ComputerTrigger3")
					local Beast = nil
					local FoundV = nil
					local FoundI = nil

					for i, v in pairs(game.Players:GetPlayers()) do
						if v:FindFirstChild("TempPlayerStatsModule") and v.TempPlayerStatsModule:WaitForChild("IsBeast").Value == true and IsThereChar(v) then
							Beast = v
						end
					end

					for i2, v2 in ComputerBanList do
						if UseTrigger and Beast and v2 == v and DateTime.now().UnixTimestampMillis - i2 > HackBanUnbanTime:GetValue() and (UseTrigger.Position - Beast.Character.HumanoidRootPart.Position).Magnitude > HideBeastNearDist:GetValue() + 10 then
							ComputerBanList[i2] = nil
						elseif v2 == v then
							FoundV = v2
							FoundI = i2
						end
					end

					if v.Screen.BrickColor ~= BrickColor.new("Dark green") and not FoundV then
						local Triggers = {
							v:FindFirstChild("ComputerTrigger3"),
							v:FindFirstChild("ComputerTrigger2"),
							v:FindFirstChild("ComputerTrigger1"),
						}

						local Distance = (Triggers[1].Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
						local AmtTriggers = 3

						for i2, v2 in pairs(Triggers) do
							if v2 and v2.ActionSign.Value ~= 20 then
								AmtTriggers -= 1
							end
						end

						if v == CurrentComputer and AmtTriggers and AmtTriggers >= 1 then
							AmtTriggers += 1
						elseif AmtTriggers < 1 then
							AmtTriggers = -1
						end

						if ((AmtTriggers >= 1 or AmtTriggers == -1) and AmtTriggers <= LeastTriggers) then
							if AmtTriggers == LeastTriggers and Distance > Closest then
								continue
							end

							ChosenComputer = v
							LeastTriggers = AmtTriggers
							Closest = Distance
						end
					end
				end
			end
		end)()

		-- Get Computers
		repeat
			task.wait(1/2)
			if ChosenComputer and not OnComputer then
				SafePrint("getting computer")
				local Got = GetComputer(ChosenComputer)
				if Got == "ended: beast is computer camp" and ComputersLeft <= 1 then
					CancelComputers = true
				end
			elseif ComputersLeft < 1 then
				CancelComputers = true
			end
		until not TaskGood() or CancelComputers

		if not TaskGood() or ExitCancel:GetValue() then
			return
		end

		-- Try Escape
		repeat
			task.wait()
			for i, v in MapObjects.ExitDoors do
				SafePrint("trying to escape")
				if not TaskGood() then
					continue
				end

				repeat
					task.wait()
				until not TaskGood() or bnhide == false or bnhideelapse >= CampEscapeOut:GetValue()

				if v:FindFirstChild("ExitDoorTrigger") then
					GoTween(v.ExitDoorTrigger, nil, TeleportToExitDoor:GetValue())
					repeat
						task.wait()
						if v:FindFirstChild("ExitDoorTrigger") and v.ExitDoorTrigger.ActionSign.Value ~= 0 and not bnhide then
							SafePrint("action is correct")
							game.Players.LocalPlayer.Character:PivotTo(v.ExitDoorTrigger.CFrame * CFrame.new(0, v.ExitDoorTrigger.Size.Y / 2, 0))
							game:GetService("ReplicatedStorage").RemoteEvent:FireServer("Input", "Trigger", true, v.ExitDoorTrigger.Event)
							game:GetService("ReplicatedStorage").RemoteEvent:FireServer("Input", "Action", true)
							task.wait(1/2)
						end
					until not TaskGood() or not v:FindFirstChild("ExitDoorTrigger") or bnhideelapse >= CampEscapeOut:GetValue()

					if bnhideelapse >= CampEscapeOut:GetValue() then
						lpos = game.Players.LocalPlayer.Character:GetPivot()
						bnhideelapse = 0
						continue
					end
				end

				if TaskGood() then
					task.wait(1/2)
					GoTween(v.ExitArea, nil, TeleportToExitDoor:GetValue())
				end
			end
		until not TaskGood()
	end

	local NewFarmTask = coroutine.create(function()
		if PlayerReady() and not onsurvivorfarm then
			onsurvivorfarm = true
			local NewAttachment
			if IsThereChar() then
				NewAttachment = Instance.new("Attachment")
				NewAttachment.Name = "KSAttachmentZVel"
				NewAttachment.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart

				local NewLinearVelocity = Instance.new("LinearVelocity")
				NewLinearVelocity.Attachment0 = NewAttachment
				NewLinearVelocity.MaxForce = math.huge
				NewLinearVelocity.Parent = NewAttachment

				local NewAngularVelocity = Instance.new("AngularVelocity")
				NewAngularVelocity.Attachment0 = NewAttachment
				NewAngularVelocity.MaxTorque = math.huge
				NewAngularVelocity.Parent = NewAttachment
			end

			local Success, Result = pcall(function()
				Run()
			end)

			if not Success then
				SafePrint(Result, true)
			end

			if not DoNotTeleport then
				SafePrint("donotteleport2")
				task.wait(1)
				TPPlayerSpawn()
			end
			if NewAttachment then
				NewAttachment:Destroy()
			end
			SafePrint("done!")
			onsurvivorfarm = false
		end
	end)
	coroutine.resume(NewFarmTask)
	table.insert(farmtasks, NewFarmTask)
end

ManualComputerFarm:OnActivated(function()
	DoSurvivorFarm()
end)

local OnBeastFarm = false

local ManualBeastFarm = FarmTabBeast:NewActionActivate({
	ID = "ManualBeastFarm",
	Description = "Beast Farm Manual Activation",
})
local AutoBeastFarm = FarmTabBeast:NewActionToggle({
	ID = "AutoBeastFarm",
	Description = "Beast Auto Farm"
})
local WaitForExitBeastFarm = FarmTabBeast:NewActionToggle({
	ID = "WaitForExitBeastFarm",
	Description = "Wait for All PC to be Hacked (Useful for having Multiple Accounts in the Server)"
})
local CaptureForSave = FarmTabBeast:NewActionToggle({
	ID = "CaptureForSave",
	Description = "Capture For Save (At Start)"
})
local BeastInstantTP = FarmTabBeast:NewActionToggle({
	ID = "BeastInstantTP",
	Description = "Teleport instead of Tween"
})
local BeastFarmTweenSpeed = FarmTabBeast:NewActionSlider({
	Description = "Beast Farm Tween Speed, (Higher Numbers may get you banned/kicked)",
	MaxValue = 40,
	MinValue = 20,
	BypassInputMax = true,
	BypassInputMin = true,
	AllowDecimal = true
})
local BeastThreshold = FarmTabBeast:NewActionSlider({
	Description = "Threshold Distance (For Debugging)",
	MaxValue = 5,
	MinValue = 3.5,
	BypassInputMax = true,
	BypassInputMin = true,
	AllowDecimal = true,
})

-- NOTE: Beast Farm Function
function DoBeastFarm()
	local OnRun = true

	local function IsTaskGood()
		if string.find(string.lower(game.ReplicatedStorage.GameStatus.Value), "game over") or string.find(string.lower(game.ReplicatedStorage.GameStatus.Value), "intermission") then
			SafePrint("BEAST TASK - went not good")
			return false
		end
		return OnRun
	end

	local function LerpToPart(Part: Part, Threshold: number, WaitUntilCompletion: boolean)
		if BeastInstantTP:GetValue() then
			game.Players.LocalPlayer.Character:PivotTo(Part.CFrame)
			return
		end

		local LerpCompleted = false
		local Connection

		local EnabledPlrCollisions = {}

		for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
			if v:IsA("BasePart") and v.CanCollide == true then
				table.insert(EnabledPlrCollisions, v)
				v.CanCollide = false
			end
		end

		local NoFallPlatform = Instance.new("Part")
		NoFallPlatform.Name = "KHLibPlatformForMovementNoFall"
		NoFallPlatform.Size = Vector3.new(20, 0.5, 20)
		NoFallPlatform.Anchored = true
		NoFallPlatform.Parent = game.Workspace
		NoFallPlatform.Transparency = 0.5

		local CollisionOffPlatform = Instance.new("Part")
		CollisionOffPlatform.Name = "KHLibPlatformForMovementNoCollision"
		CollisionOffPlatform.Size = Vector3.new(20, 30, 20)
		CollisionOffPlatform.Anchored = true
		CollisionOffPlatform.Transparency = 0.8
		CollisionOffPlatform.CanCollide = false
		CollisionOffPlatform.Parent = game.Workspace

		local ObjectsOnCollided = {}

		Connection = game:GetService("RunService").RenderStepped:Connect(function(dt)
			for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
				if v:IsA("BasePart") and v.CanCollide == true then
					if not table.find(EnabledPlrCollisions, v) then
						table.insert(EnabledPlrCollisions, v)
					end
					v.CanCollide = false
				end
			end

			if not Part or not Part:IsDescendantOf(game) or not IsTaskGood() then
				LerpCompleted = true
				Connection:Disconnect()
				return
			end

			local Distance = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Part.Position).Magnitude

			if LerpCompleted == false then
				local Direction = Part.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position
				local Alpha = Direction.Unit * math.min(BeastFarmTweenSpeed:GetValue() * dt, Distance)

				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame += Alpha

				NoFallPlatform.Position = game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(0, 3, 0)
				CollisionOffPlatform.Position = game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(0, 10, 0)

				local PartsInRange = game.Workspace:GetPartBoundsInBox(CollisionOffPlatform.CFrame, CollisionOffPlatform.Size)

				for i, v in pairs(PartsInRange) do
					if v.CanCollide == true and not v:IsDescendantOf(game.Players.LocalPlayer.Character) and v ~= NoFallPlatform then
						v.CanCollide = false
						if not table.find(ObjectsOnCollided, v) then
							table.insert(ObjectsOnCollided, v)
						end
					end
				end

				for i = #ObjectsOnCollided, 1, -1 do
					local v = ObjectsOnCollided[i]
					if not table.find(PartsInRange, v) then
						v.CanCollide = true
						table.remove(ObjectsOnCollided, i)
					end
				end
			end


			if Distance <= Threshold then
				LerpCompleted = true
				Connection:Disconnect()
				return
			end
		end)

		if WaitUntilCompletion == true then
			repeat
				task.wait()
			until LerpCompleted
			for i, v in pairs(EnabledPlrCollisions) do
				v.CanCollide = true
			end
			NoFallPlatform:Destroy()
			CollisionOffPlatform:Destroy()
			for i, v in pairs(ObjectsOnCollided) do
				v.CanCollide = true
			end
		end

		return {
			["IsLerpCompleted"] = function()
				return LerpCompleted
			end
		}
	end

	local function GetMapObjects()
		local Result = {}
		Result.Computers = {}
		Result.FreezePods = {}
		Result.ExitDoors = {}

		if game.ReplicatedStorage.CurrentMap.Value then
			for i, v in pairs(game.ReplicatedStorage.CurrentMap.Value:GetChildren()) do
				if v.Name == "ComputerTable" then
					table.insert(Result.Computers, v)
				elseif v.Name == "FreezePod" then
					table.insert(Result.FreezePods, v)
				elseif v.Name == "ExitDoor" then
					table.insert(Result.ExitDoors, v)
				end
			end
		end

		return Result
	end

	local function PodCheckUp(Pod)
		if not Pod:FindFirstChild("PodTrigger") or Pod.PodTrigger.ActionSign.Value ~= 30 then
			return false
		end
		return true
	end

	local function GetPlayers(MapObjects: {Computers: {}, FreezePods: {}, ExitDoors: {}}, WaitForSave)
		local Player = game.Players.LocalPlayer

		for i, v in pairs(game.Players:GetPlayers()) do
			local function PlayerCheckUp()
				if not v or not v:IsDescendantOf(game) or not IsThereChar(v) then
					return false
				end
				return true
			end

			if v ~= game.Players.LocalPlayer and v:FindFirstChild("TempPlayerStatsModule") and v.TempPlayerStatsModule.Health.Value > 0 and IsThereChar(v) and v.TempPlayerStatsModule.Captured.Value == false then
				SafePrint("this player " .. v.Name)
				-- Hit Players
				if not PlayerCheckUp() then return end
				LerpToPart(v.Character.Torso, BeastThreshold:GetValue(), true)
				SafePrint("donegoing")
				repeat
					task.wait()
					if PlayerCheckUp() then
						game.Players.LocalPlayer.Character:PivotTo(v.Character.HumanoidRootPart.CFrame)
						Player.Character.Hammer.HammerEvent:FireServer("HammerHit", v.Character.Torso)
					end
				until not PlayerCheckUp() or (v:FindFirstChild("TempPlayerStatsModule") and v.TempPlayerStatsModule.Ragdoll.Value == true)
				SafePrint("hit!>")

				task.wait(0.05)

				-- Tie Players
				if not PlayerCheckUp() then return end
				LerpToPart(v.Character.Torso, BeastThreshold:GetValue(), true)
				SafePrint("donegoing")
				if not PlayerCheckUp() then return end
				local FoundRope = false
				repeat
					task.wait()
					if PlayerCheckUp() then
						game.Players.LocalPlayer.Character:PivotTo(v.Character.HumanoidRootPart.CFrame)
						Player.Character.Hammer.HammerEvent:FireServer("HammerTieUp", v.Character.Torso, v.Character.Torso.Position)
					end
					for i, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
						if v:IsA("RopeConstraint") then
							FoundRope = true
						end
					end
				until not PlayerCheckUp() or FoundRope
				SafePrint("tie!>")

				task.wait(0.05)

				-- Put Players to Freeze Pods
				local DoneFreeze = false
				for i2, v2 in pairs(MapObjects.FreezePods) do
					if PodCheckUp(v2) and PlayerCheckUp(v) and not DoneFreeze then
						LerpToPart(v2.PodTrigger, BeastThreshold:GetValue(), true)
						SafePrint("freezepod go")

						repeat
							task.wait(0.05)
							if PodCheckUp(v2) and PlayerCheckUp() and v:FindFirstChild("TempPlayerStatsModule") and v.TempPlayerStatsModule:WaitForChild("Health").Value > 0 and v.TempPlayerStatsModule:WaitForChild("Captured").Value == false then
								game.Players.LocalPlayer.Character:PivotTo(v2.PodTrigger.CFrame)
								game:GetService("ReplicatedStorage").RemoteEvent:FireServer("Input", "Trigger", true, v2.PodTrigger.Event)
								game:GetService("ReplicatedStorage").RemoteEvent:FireServer("Input", "Action", true)
							end
						until not PodCheckUp(v2) or not PlayerCheckUp()

						task.wait(0.05)

						if WaitForSave then
							repeat
								task.wait()
								if v2:FindFirstChild("PodTrigger") then
									game.Players.LocalPlayer.Character:PivotTo(v2.PodTrigger.CFrame * CFrame.new(0, 50, 0))
								end
							until PodCheckUp(v2) or not v2:FindFirstChild("PodTrigger")
						end

						DoneFreeze = true
						SafePrint("done freeze")
					end
				end
			end
		end
	end

	local function Run()
		local Player = game.Players.LocalPlayer
		local MapObjects = GetMapObjects()

		if CaptureForSave:GetValue() then
			task.wait()
			GetPlayers(MapObjects, true)
			SafePrint("www")
		end

		local Good = false
		repeat
			task.wait(0.5)
			Good = true
			for i, v in pairs(MapObjects.Computers) do
				if v.Screen.BrickColor ~= BrickColor.new("Dark green") then
					Good = false
				end
			end
		until WaitForExitBeastFarm:GetValue() == false or Good
		repeat
			task.wait()
			GetPlayers(MapObjects)
			SafePrint("www")
		until not IsTaskGood()
		SafePrint("domne")
	end

	if IsThereChar() and TempPlayerStatsModule.IsBeast.Value and not OnBeastFarm and game.ReplicatedStorage.CurrentMap.Value then
		local NewFarmTask = coroutine.create(function()
			OnBeastFarm = true
			local NewAttachment
			if IsThereChar() then
				NewAttachment = Instance.new("Attachment")
				NewAttachment.Name = "KSAttachmentZVel"
				NewAttachment.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart

				local NewLinearVelocity = Instance.new("LinearVelocity")
				NewLinearVelocity.Attachment0 = NewAttachment
				NewLinearVelocity.MaxForce = math.huge
				NewLinearVelocity.Parent = NewAttachment

				local NewAngularVelocity = Instance.new("AngularVelocity")
				NewAngularVelocity.Attachment0 = NewAttachment
				NewAngularVelocity.MaxTorque = math.huge
				NewAngularVelocity.Parent = NewAttachment
			end
			SafePrint("running!")
			local Success, Result = pcall(function()
				return Run()
			end)
			if not Success then
				SafePrint(Result, true)
			end
			task.wait(3)
			if NewAttachment then
				NewAttachment:Destroy()
			end
			TPPlayerSpawn()
			OnBeastFarm = false
		end)
		coroutine.resume(NewFarmTask)
		table.insert(farmtasks, NewFarmTask)
	end
end

ManualBeastFarm:OnActivated(function()
	DoBeastFarm()
end)

-- Statistics
local StatsTab = UI:NewTab({ID = "StatsTab", Title = "📊 Statistics"})

StatsTab:NewHeader({Text = "Recording"})
local RecordStats = StatsTab:NewActionActivate({ID = "RecordStats", Text = "Start Recording"})
local RecordElapsed = StatsTab:NewOutputText({ID = "RecordElapsed", Text = "0:00:00"})

StatsTab:NewHeader({Text = "Total Earning"})
local MoneyStats = StatsTab:NewOutputText({ID = "MoneyStats", Text = "Total Credits: 0C"})
local XPStats = StatsTab:NewOutputText({ID = "XPStats", Text = "Total XP: 0XP"})

StatsTab:NewHeader({Text = "Per Hour"})
local MoneyStatsHour = StatsTab:NewOutputText({ID = "MoneyStatsHour", Text = "Credits per Hour: 0C/h"})
local XPStatsHour = StatsTab:NewOutputText({ID = "XPStatsHour", Text = "XP per Hour: 0XP/h"})

local StatsConfig = {
	Recording = false,
	StartMoney = 0,
	StartXP = 0,
	Elapsed = 0
}

RecordStats:OnInputChanged(function()
	if not StatsConfig.Recording then
		RecordStats.Config.Text = "Stop Recording"
		RecordStats:Update()
		StatsConfig.Elapsed = 0
		if game.Players.LocalPlayer:FindFirstChild("SavedPlayerStatsModule") and game.Players.LocalPlayer.SavedPlayerStatsModule:FindFirstChild("Xp") then
			StatsConfig.StartXP = game.Players.LocalPlayer.SavedPlayerStatsModule.Xp.Value
		end
		if game.Players.LocalPlayer:FindFirstChild("SavedPlayerStatsModule") and game.Players.LocalPlayer.SavedPlayerStatsModule:FindFirstChild("Credits") then
			StatsConfig.StartMoney = game.Players.LocalPlayer.SavedPlayerStatsModule.Credits.Value
		end
		StatsConfig.Recording = true
	else
		RecordStats.Config.Text = "Start Recording"
		RecordStats:Update()
		StatsConfig.Recording = false
	end
end)

local PCHighlights = {}

local hadRagdoll = false

-- NOTE: Anti AFK System
coroutine.wrap(function()
	while task.wait(60) do
		if AntiAFK:GetValue() then
			local VirtualUser = game:GetService("VirtualUser")
			VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
			task.wait(1)
			VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
		end
	end
end)()

-- NOTE: Tick system
local PrevGotRound = false
local ElapseSpeedHack = 0

game:GetService("UserInputService").InputBegan:Connect(function(Input, GPE)
	if not GPE and Input.KeyCode == Enum.KeyCode.LeftAlt then
		UI.Instance.Main.Visible = not UI.Instance.Main.Visible
	elseif not GPE and Input.KeyCode == Enum.KeyCode.Two and game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftControl) then
		SpeedHackCrawl:SetUserInput(not SpeedHackCrawl:GetValue())
		SpeedHackCrawl:Update()
		local val = SpeedHackCrawl:GetValue()
		UI:NewNotification({NotifyType = "Status", Title = "Hotkey (Ctrl + 2)", Text = `Changed Speed Hack to {val}`})
	end
end)

-- Dropdown Player Selections
function UpdateDropdownPlayerSelections()
	table.clear(ToPlayerTeleportSelection.Config.Values)
	table.clear(PiggyBackSelection.Config.Values)
	for i, v in pairs(game.Players:GetPlayers()) do
		if v ~= game.Players.LocalPlayer then
			table.insert(ToPlayerTeleportSelection.Config.Values, {Name = `{v.DisplayName} (@{v.Name})`, Value = v.Name})
		end
	end
	PiggyBackSelection.Config.Values = ToPlayerTeleportSelection.Config.Values

	ToPlayerTeleportSelection:UpdateValues()
	PiggyBackSelection:UpdateValues()
end

UpdateDropdownPlayerSelections()
game.Players.PlayerRemoving:Connect(UpdateDropdownPlayerSelections)
game.Players.PlayerAdded:Connect(UpdateDropdownPlayerSelections)

pcall(function()
	loadstring(game:HttpGet("https://pastebin.com/raw/Kwksvwsh"))():SetupInfoTab(UI, "Koala Scripts - Flee the Facility v4")
end)

KHLib:ReadyUp(filesavingname)

local LastBeastPower = 0
local LastSeerHidePos = nil
local HadSeerHide = false
local HadNotifiedMod = false

game.Players.PlayerAdded:Connect(function()
	HadNotifiedMod = false
end)

local onupdate = false

while true do
	-- pcall for anti-crash
	local psucess, presult = pcall(function()

		local dt = task.wait()

		if StatsConfig.Recording then
			local CurrentXP = nil
			local CurrentMoney = nil
			StatsConfig.Elapsed += dt
			if game.Players.LocalPlayer:FindFirstChild("SavedPlayerStatsModule") and game.Players.LocalPlayer.SavedPlayerStatsModule:FindFirstChild("Xp") then
				CurrentXP = game.Players.LocalPlayer.SavedPlayerStatsModule.Xp.Value
			end
			if game.Players.LocalPlayer:FindFirstChild("SavedPlayerStatsModule") and game.Players.LocalPlayer.SavedPlayerStatsModule:FindFirstChild("Credits") then
				CurrentMoney = game.Players.LocalPlayer.SavedPlayerStatsModule.Credits.Value
			end

			local function FormatTime(TotalSeconds)
				local Hours = math.floor(TotalSeconds / 3600)
				local Minutes = math.floor((TotalSeconds % 3600) / 60)
				local Seconds = TotalSeconds % 60

				return string.format("%d:%02d:%02d", Hours, Minutes, Seconds)
			end

			if CurrentXP and CurrentMoney then
				local TotalMoney = CurrentMoney - StatsConfig.StartMoney
				local TotalXP = CurrentXP - StatsConfig.StartXP
				MoneyStats.Config.Text = "Total Credits: " .. tostring(TotalMoney) .. "C"
				XPStats.Config.Text = "Total XP: " .. tostring(TotalXP) .. "XP"
				MoneyStatsHour.Config.Text = "Credits per Hour: " .. tostring(math.ceil(TotalMoney / (StatsConfig.Elapsed / 3600))) .. "C/h"
				XPStatsHour.Config.Text = "XP per Hour: " .. tostring(math.ceil(TotalXP / (StatsConfig.Elapsed / 3600))) .. "XP/h"
				RecordElapsed.Config.Text = FormatTime(math.floor(StatsConfig.Elapsed))

				MoneyStats:Update()
				MoneyStatsHour:Update()
				XPStats:Update()
				XPStatsHour:Update()
				RecordElapsed:Update()
			end
			StatsConfig.Recording = true
		end

		if onsurvivorfarm and not ForcedTogglesDisabled:GetValue() then
			if ExitCancel:GetValue() then
				AntiPCError:SetValue(true)
				AntiPCError:Update()

				HideBeastNear:SetValue(false)
				HideBeastNear:Update()

				UnTieMe:SetValue(false)
				UnTieMe:Update()
			else
				AntiPCError:SetValue(true)
				AntiPCError:Update()

				HideBeastNear:SetValue(true)
				HideBeastNear:Update()

				UnTieMe:SetValue(true)
				UnTieMe:Update()
			end
		end

		if HideBeastNear:GetValue() then
			RagdollMovement:SetValue(false)
			RagdollMovement:Update()
		end

		if UnTieAll:GetValue() or SlowBeast:GetValue() or UnTieMe:GetValue() then
			for i, v in pairs(game.Players:GetPlayers()) do
				if v ~= game.Players.LocalPlayer and v:FindFirstChild("TempPlayerStatsModule") and v.TempPlayerStatsModule:WaitForChild("IsBeast").Value == true and IsThereChar(v) and v.Character:FindFirstChild("Hammer") and v.Character.Hammer:FindFirstChild("HammerEvent") and v.Character:FindFirstChild("BeastPowers") and v.Character.BeastPowers:FindFirstChild("PowersEvent") then
					if UnTieAll:GetValue() then
						v.Character.Hammer.HammerEvent:FireServer("HammerClick", true)
					end
					if UnTieMe:GetValue() and IsThereChar() then
						for i2, v2 in pairs(v.Character:GetDescendants()) do
							if v2:IsA("RopeConstraint") then
								if (v2.Attachment0 and v2.Attachment0:IsDescendantOf(game.Players.LocalPlayer.Character)) or (v2.Attachment1 and v2.Attachment1:IsDescendantOf(game.Players.LocalPlayer.Character)) then
									v.Character.Hammer.HammerEvent:FireServer("HammerClick", true)
								end
							end
						end
					end
					if SlowBeast:GetValue() then
						v.Character.BeastPowers.PowersEvent:FireServer("Jumped")
					end
				end
			end
		end

		if game.ReplicatedStorage:FindFirstChild("CurrentPower") then
			BeastPowerInfo.Config.Text = "Beast Power : " .. game.ReplicatedStorage.CurrentPower.Value
			BeastPowerInfo:Update()
		end

		if IsThereChar() then
			TempPlayerStatsModule = game.Players.LocalPlayer:FindFirstChild("TempPlayerStatsModule")
			if TempPlayerStatsModule then
				if IsThereChar() and TempPlayerStatsModule.Ragdoll.Value and RagdollMovement:GetValue() then
					TempPlayerStatsModule.Ragdoll.Value = false
					if JumpHackEnabled:GetValue() then
						game.Players.LocalPlayer.Character.Humanoid.JumpPower = JumpHack:GetValue()
					else
						game.Players.LocalPlayer.Character.Humanoid.JumpPower = 36
					end
				end
				if TempPlayerStatsModule.IsBeast.Value and Beast3rdPerson:GetValue() then
					game.Players.LocalPlayer.CameraMinZoomDistance = 0.5
					game.Players.LocalPlayer.CameraMode = Enum.CameraMode.Classic
				end
			end
			if SpeedHackEnabled:GetValue() then
				game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = SpeedHack:GetValue()
			end
			if JumpHackEnabled:GetValue() then
				game.Players.LocalPlayer.Character.Humanoid.JumpPower = JumpHack:GetValue()
			end

			if FullBright:GetValue() and not game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("KH_FullBright") then
				local NewLight = Instance.new("PointLight", game.Players.LocalPlayer.Character.HumanoidRootPart)
				NewLight.Name = "KH_FullBright"
				NewLight.Range = math.huge
				NewLight.Brightness = 2.5

				game.Lighting.GlobalShadows = false
			elseif not FullBright:GetValue() and game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("KH_FullBright") then
				game.Players.LocalPlayer.Character.HumanoidRootPart.KH_FullBright:Destroy()
				game.Lighting.GlobalShadows = true
			end
		end

		if AntiPCError:GetValue() then
			game.ReplicatedStorage.RemoteEvent:FireServer("SetPlayerMinigameResult", true)
		end

		-- Computer counter & pc esp
		local GotComputers = 0
		for i = #PCHighlights, 1, -1 do
			local v = PCHighlights[i]
			if (v and v.Adornee == nil) or not PCESP:GetValue() or not v then
				if v then
					v:Destroy()
				end
				table.remove(PCHighlights, i)
			end
		end

		local PlayerWatchlist = {}
		
		local ClosestTieRange = math.huge
		local ClosestTiePlr = nil
		for i,v in pairs(game.Players:GetPlayers()) do
			if IsThereChar(v) and v:FindFirstChild("TempPlayerStatsModule") and v.TempPlayerStatsModule:WaitForChild("CurrentAnimation").Value == "Typing" then
				table.insert(PlayerWatchlist, v)
			end
			
			if BeastTieRange:GetValue() > 0
			and IsThereChar(v)
			and IsThereChar()
			and game.Players.LocalPlayer.Character:FindFirstChild("Hammer")
			and TempPlayerStatsModule.IsBeast.Value
			and v:FindFirstChild("TempPlayerStatsModule")
			and v.TempPlayerStatsModule:FindFirstChild("Ragdoll")
			and v.TempPlayerStatsModule.Ragdoll.Value then
				local Dist = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).Magnitude
				if Dist <= BeastTieRange:GetValue() and BeastTieRange:GetValue() < ClosestTieRange then
					ClosestTieRange = v.Character.HumanoidRootPart.Position
					ClosestTiePlr = v
				end
			end
		end
		
		if ClosestTiePlr then
			game.Players.LocalPlayer.Character.Hammer.HammerEvent:FireServer("HammerTieUp", ClosestTiePlr.Character.Torso, ClosestTiePlr.Character.Torso.Position)
		end

		if (AlertModerator:GetValue() or KickOnModerator:GetValue()) then
			local HasModerator = false
			if game.Players.LocalPlayer.PlayerGui:FindFirstChild("ScreenGui") and game.Players.LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("PlayerNamesFrame") then
				for i, v in pairs(game.Players.LocalPlayer.PlayerGui:WaitForChild("ScreenGui"):WaitForChild("PlayerNamesFrame"):GetChildren()) do
					if v:FindFirstChild("IconLabel") then
						if v.IconLabel.Image ~= "" and v.IconLabel.Image ~= "rbxassetid://1188562340" then
							HasModerator = true
						end
					end
				end
			end
			if HasModerator then
				if KickOnModerator:GetValue() then
					game.Players.LocalPlayer:Kick("A Moderator had joined, so we kicked you for safety.")
				elseif AlertModerator:GetValue() then
					UI:NewNotification({NotifyType = "Warning", Title = "Warning! A Moderator Joined", Text = "Warning! A Moderator had Joined we recommend disabling all of your hacks or join in another server."})
					HadNotifiedMod = true
				end
			end
		end

		if game.ReplicatedStorage.CurrentMap.Value then
			for i, v in pairs(game.ReplicatedStorage.CurrentMap.Value:GetChildren()) do
				if v.Name == "ComputerTable" and v:FindFirstChild("Screen") then
					GotComputers += 1

					if PCProgESP:GetValue() and not v:FindFirstChild("KSBillboard") then
						local BillBoardGui = Instance.new("BillboardGui")
						BillBoardGui.StudsOffsetWorldSpace = Vector3.new(0, 1, 0)
						BillBoardGui.Name = "KSBillboard"
						BillBoardGui.AlwaysOnTop = true
						BillBoardGui.Size = UDim2.new(8, 0, 1.5, 0)
						BillBoardGui.Parent = v
						local TextLabel = Instance.new("TextLabel")
						TextLabel.BackgroundTransparency = 1
						TextLabel.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
						TextLabel.Text = v.Name .. tostring(GotComputers) .. " | 0% ?"
						TextLabel.Size = UDim2.new(1, 0, 1, 0)
						TextLabel.TextScaled = true
						TextLabel.RichText = true
						TextLabel.Parent = BillBoardGui
					end
					if PCProgESP:GetValue() and v:FindFirstChild("KSBillboard") then
						local Progress = nil
						v.KSBillboard.TextLabel.TextColor3 = v.Screen.Color
						if v.Screen.BrickColor == BrickColor.new("Bright blue") then
							v.KSBillboard.TextLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
						end
						if PCProgESPSlideSize:GetValue() == 1 then
							v.KSBillboard.Size = UDim2.new(8, 0, 1.5, 0)
						elseif PCProgESPSlideSize:GetValue() == 2 then
							v.KSBillboard.Size = UDim2.new(0, 250, 0, 25)
						end
						for i2, v2 in pairs(PlayerWatchlist) do
							if Progress == nil and IsThereChar(v2) and v2:FindFirstChild("TempPlayerStatsModule") and v2.TempPlayerStatsModule:WaitForChild("CurrentAnimation").Value == "Typing" then
								local PlrDistance = (v2.Character.HumanoidRootPart.Position - v.Screen.Position).Magnitude
								if PlrDistance < 15 then
									Progress = math.round(v2.TempPlayerStatsModule:WaitForChild("ActionProgress").Value * 100)
								end
							end
						end
						if Progress then
							v.KSBillboard.TextLabel.Text = v.Name .. tostring(GotComputers) .. " | " .. tostring(Progress) .. "%"
						end
					elseif not PCProgESP:GetValue() and v:FindFirstChild("KSBillboard") then
						v.KSBillboard:Destroy()
					end

					if PCESP:GetValue() then
						if v:FindFirstChild("KSHighlight") then
							v.KSHighlight.FillColor = v.Screen.Color
							v.KSHighlight.OutlineColor = v.Screen.Color
							if v.Screen.BrickColor == BrickColor.new("Bright blue") then
								v.KSHighlight.FillColor = Color3.fromRGB(0, 255, 255)
								v.KSHighlight.OutlineColor = Color3.fromRGB(0, 255, 255)
							end
						else
							local NewHighlight = Instance.new("Highlight")
							NewHighlight.Name = "KSHighlight"
							NewHighlight.FillColor = v.Screen.Color
							NewHighlight.OutlineColor = v.Screen.Color
							if v.Screen.BrickColor == BrickColor.new("Bright blue") then
								NewHighlight.FillColor = Color3.fromRGB(0, 255, 255)
								NewHighlight.OutlineColor = Color3.fromRGB(0, 255, 255)
							end
							NewHighlight.Adornee = v
							NewHighlight.Parent = v
							table.insert(PCHighlights, NewHighlight)
						end
					end
				end
			end
		end

		if GotComputers ~= Comp then
			coroutine.wrap(function()
				if GotComputers == 0 then
					task.wait(1)
					UpdateVentESP()
					UpdateLockerESP()
					UpdatePodESP()
					UpdateExitESP()
					UpdatePlrESP()
					UpdateBeastESP()
					Beast = nil
					for i, v in pairs(farmtasks) do
						pcall(function()
							coroutine.close(v)
						end)
					end
					OnBeastFarm = false
					onsurvivorfarm = false
				elseif not onupdate then
					onupdate = true
					task.wait(3)
					UpdateVentESP()
					UpdateLockerESP()
					UpdatePodESP()
					UpdateExitESP()
					UpdatePlrESP()
					if ComputerAutoFarm:GetValue() then
						DoSurvivorFarm()
					end
					repeat
						task.wait()
					until game.ReplicatedStorage.IsGameActive.Value
					task.wait(3)
					UpdateVentESP()
					UpdateLockerESP()
					UpdatePodESP()
					UpdateExitESP()
					UpdatePlrESP()
					UpdateBeastESP()
					if BeastPowerInfoNotif:GetValue() then
						UI:NewNotification({NotifyType = "Status", Title = "Beast Power", Text = "Beast Power is " .. game.ReplicatedStorage.CurrentPower.Value})
					end
					for i, v in pairs(game.Players:GetPlayers()) do
						if v:FindFirstChild("TempPlayerStatsModule") and v.TempPlayerStatsModule.IsBeast.Value then
							Beast = v
						end
					end

					if AutoBeastFarm:GetValue() then
						DoBeastFarm()
					end
					onupdate = false
				end
			end)()
			Comp = GotComputers
		end

		if HideBeastNear:GetValue() and IsThereChar() and Beast ~= nil and IsThereChar(Beast) and TempPlayerStatsModule and TempPlayerStatsModule.IsBeast.Value == false and Beast ~= game.Players.LocalPlayer then
			if lpos and ((Beast.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < HideBeastNearDist:GetValue() or TempPlayerStatsModule.Ragdoll.Value == true or bnhide == true) then
				game.Players.LocalPlayer.Character:PivotTo(Beast.Character:GetPivot() * CFrame.new(0, 25 + HideBeastNearDist:GetValue(), 0))
				bnhide = true
			elseif bnhide == false and clpos == false then
				lpos = game.Players.LocalPlayer.Character:GetPivot()
			end

			if lpos and bnhide == true and (Beast.Character.HumanoidRootPart.Position - lpos.Position).Magnitude > HideBeastNearDist:GetValue() + 10 and TempPlayerStatsModule.Ragdoll.Value == false then
				game.Players.LocalPlayer.Character:PivotTo(lpos)
				bnhide = false
			end
		end

		if bnhide then
			bnhideelapse += dt
			noelepse = 0
		else
			noelepse += dt
			if noelepse > TriggerUnCampOut:GetValue() then
				bnhideelapse = 0
			end
		end

		-- Anti Void Death
		if IsThereChar() and game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Y < -3000 then
			TPPlayerSpawn()
		end

		-- Seer Hide
		if game.Players.LocalPlayer.PlayerGui:WaitForChild("ScreenGui"):WaitForChild("WarningFrame").Visible == true and IsThereChar() then
			if AutoHideFromSeer:GetValue() and TempPlayerStatsModule.Health.Value > 0 and not TempPlayerStatsModule.IsBeast.Value and not HadSeerHide then
				HadSeerHide = true
				if not LastSeerHidePos then
					LastSeerHidePos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
					task.wait(1/4)
				end
				local ClosestLocker = nil
				local ClosestDistance = math.huge
				for i, v in pairs(game:GetService("CollectionService"):GetTagged("LOCKER")) do
					if v:IsA("Model") and (v:GetPivot().Position - game.Players.LocalPlayer.Character:GetPivot().Position).Magnitude < ClosestDistance then
						ClosestLocker = v
						ClosestDistance = (v:GetPivot().Position - game.Players.LocalPlayer.Character:GetPivot().Position).Magnitude
					end
				end
				if ClosestLocker then
					game.Players.LocalPlayer.Character:PivotTo(ClosestLocker:GetPivot())
				end
			end
		elseif LastSeerHidePos and IsThereChar() then
			local ReadySafe = false
			local Elapsed = 0
			repeat
				Elapsed += task.wait()
				ReadySafe = true
				for i, v in pairs(game.Players.LocalPlayer.PlayerGui:WaitForChild("ScreenGui"):WaitForChild("DetectedFrame"):GetChildren()) do
					if v:IsA("Frame") and v.Visible then
						ReadySafe = false
					end
				end
			until ReadySafe or Elapsed >= 3
			HadSeerHide = false
			if ReturnFromHideSeer:GetValue() then
				task.wait(1/4)
				game.Players.LocalPlayer.Character:PivotTo(LastSeerHidePos)
			end
			LastSeerHidePos = nil
		end

		ElapseSpeedHack += dt
		if ElapseSpeedHack >= HackCrawlDelay:GetValue() then
			ElapseSpeedHack = 0
			local Event = TempPlayerStatsModule:WaitForChild("ActionEvent").Value
			if SpeedHackCrawl:GetValue() and not TempPlayerStatsModule:WaitForChild("IsBeast").Value and TempPlayerStatsModule:WaitForChild("ActionEvent").Value and TempPlayerStatsModule.ActionEvent.Value.Parent.Parent.Name == "ComputerTable" and TempPlayerStatsModule:WaitForChild("CurrentAnimation").Value == "Typing" and IsThereChar() then
				local Event = TempPlayerStatsModule:WaitForChild("ActionEvent").Value
				local AmountEvents = 0
				local Events = {
					Event.Parent.Parent:FindFirstChild("ComputerTrigger1"),
					Event.Parent.Parent:FindFirstChild("ComputerTrigger2"),
					Event.Parent.Parent:FindFirstChild("ComputerTrigger3")
				}
				for i, v in pairs(Events) do
					if v ~= nil and v:FindFirstChild("ActionSign") and v.ActionSign.Value ~= 20 then
						AmountEvents += 1
					end
				end

				if HackCrawlType:GetValue() == 0 and (AmountEvents <= 1 or HackCrawlWPeople:GetUserInput()) then
					local CrawlAnim = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(game.ReplicatedStorage:WaitForChild("Animations"):WaitForChild("AnimCrawl"))
					-- Crawl
					game:GetService("ReplicatedStorage").RemoteEvent:FireServer("Input", "Crawl", true)
					game.Players.LocalPlayer.Character.Humanoid.HipHeight = -2
					CrawlAnim:Play(0.100000001, 1, 0)
					game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 8

					local Elapsed = 0
					if HackCrawlTime:GetValue() == -1 then
						repeat
							task.wait()
						until Elapsed >= 2 or TempPlayerStatsModule:WaitForChild("CurrentAnimation").Value ~= "Typing"
					else
						task.wait(HackCrawlTime:GetValue())
					end

					-- UnCrawl
					game:GetService("ReplicatedStorage").RemoteEvent:FireServer("Input", "Crawl", false)
					game.Players.LocalPlayer.Character.Humanoid.HipHeight = 0
					CrawlAnim:Stop()
					game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16

					Elapsed = 0
					repeat
						Elapsed += task.wait()
						game:GetService("ReplicatedStorage").RemoteEvent:FireServer("Input", "Trigger", true, Event)
						game:GetService("ReplicatedStorage").RemoteEvent:FireServer("Input", "Action", true)
					until Elapsed >= 2 or TempPlayerStatsModule:WaitForChild("CurrentAnimation").Value == "Typing"

					task.wait(1/5)
					if Elapsed < 2 and TempPlayerStatsModule:WaitForChild("CurrentAnimation").Value ~= "Typing" then
						Elapsed = 0
						repeat
							Elapsed += task.wait()
							game:GetService("ReplicatedStorage").RemoteEvent:FireServer("Input", "Trigger", true, Event)
							game:GetService("ReplicatedStorage").RemoteEvent:FireServer("Input", "Action", true)
						until Elapsed >= 2 or TempPlayerStatsModule:WaitForChild("CurrentAnimation").Value == "Typing"
					end
				elseif HackCrawlType:GetValue() == 1 and (AmountEvents <= 1 or HackCrawlWPeople:GetUserInput()) then
					game.Players.LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)

					local Elapsed = 0
					local Ready = false
					local Connection = game.Players.LocalPlayer.Character.Humanoid.StateChanged:Connect(function(_, NewState)
						if NewState == Enum.HumanoidStateType.Landed then
							Ready = true
						end
					end)
					repeat
						Elapsed += task.wait()
					until Ready or Elapsed >= 2
					Connection:Disconnect()

					Elapsed = 0
					repeat
						Elapsed += task.wait()
						game:GetService("ReplicatedStorage").RemoteEvent:FireServer("Input", "Trigger", true, Event)
						game:GetService("ReplicatedStorage").RemoteEvent:FireServer("Input", "Action", true)
					until Elapsed >= 2 or TempPlayerStatsModule:WaitForChild("CurrentAnimation").Value == "Typing"

					task.wait(1/5)
					if Elapsed < 2 and TempPlayerStatsModule:WaitForChild("CurrentAnimation").Value ~= "Typing" then
						Elapsed = 0
						repeat
							Elapsed += task.wait()
							game:GetService("ReplicatedStorage").RemoteEvent:FireServer("Input", "Trigger", true, Event)
							game:GetService("ReplicatedStorage").RemoteEvent:FireServer("Input", "Action", true)
						until Elapsed >= 2 or TempPlayerStatsModule:WaitForChild("CurrentAnimation").Value == "Typing"
					end
				elseif HackCrawlType:GetValue() == 2 and (AmountEvents <= 1 or HackCrawlWPeople:GetUserInput()) then
					local Elapsed = 0
					local Ready = false
					repeat
						Elapsed += task.wait()
						game:GetService("ReplicatedStorage").RemoteEvent:FireServer("Input", "Trigger", false, Event)
						game:GetService("ReplicatedStorage").RemoteEvent:FireServer("Input", "Action", false)
					until TempPlayerStatsModule:WaitForChild("CurrentAnimation").Value ~= "Typing" or Elapsed >= 2

					Elapsed = 0
					repeat
						Elapsed += task.wait()
						game:GetService("ReplicatedStorage").RemoteEvent:FireServer("Input", "Trigger", true, Event)
						game:GetService("ReplicatedStorage").RemoteEvent:FireServer("Input", "Action", true)
					until Elapsed >= 2 or TempPlayerStatsModule:WaitForChild("CurrentAnimation").Value == "Typing"

					task.wait(1/5)
					if Elapsed < 2 and TempPlayerStatsModule:WaitForChild("CurrentAnimation").Value ~= "Typing" then
						Elapsed = 0
						repeat
							Elapsed += task.wait()
							game:GetService("ReplicatedStorage").RemoteEvent:FireServer("Input", "Trigger", true, Event)
							game:GetService("ReplicatedStorage").RemoteEvent:FireServer("Input", "Action", true)
						until Elapsed >= 2 or TempPlayerStatsModule:WaitForChild("CurrentAnimation").Value == "Typing"
					end
				end
			end
		end

		UpdateShowPlrRagTime()
		-- end of pcall
	end)

	if not psucess then SafePrint("An error had occured during the Tick System: " .. presult, true) end
end
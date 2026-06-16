local _Players = game:GetService('Players')
local _TeleportService = game:GetService('TeleportService')
local _AssetService = game:GetService('AssetService')

task.wait(0.5)

local v4 = _AssetService:GetGamePlacesAsync()
local v5 = {}
local v40 = {
    CreateWindow = function(_, p6)
        local _ScreenGui = Instance.new('ScreenGui')

        _ScreenGui.Name = 'SubPlacesViewer'
        _ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild('PlayerGui')

        local _Frame = Instance.new('Frame')

        _Frame.Size = UDim2.new(0, 300, 0, 400)
        _Frame.Position = UDim2.new(0.5, -150, 0.5, -200)
        _Frame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
        _Frame.BorderSizePixel = 0
        _Frame.Parent = _ScreenGui

        local _UICorner = Instance.new('UICorner')

        _UICorner.CornerRadius = UDim.new(0, 10)
        _UICorner.Parent = _Frame

        local _Frame2 = Instance.new('Frame')

        _Frame2.Size = UDim2.new(1, 0, 0, 40)
        _Frame2.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
        _Frame2.BorderSizePixel = 0
        _Frame2.Parent = _Frame

        local _UICorner2 = Instance.new('UICorner')

        _UICorner2.CornerRadius = UDim.new(0, 10)
        _UICorner2.Parent = _Frame2

        local _TextLabel = Instance.new('TextLabel')

        _TextLabel.Size = UDim2.new(1, -40, 1, 0)
        _TextLabel.Position = UDim2.new(0, 10, 0, 0)
        _TextLabel.BackgroundTransparency = 1
        _TextLabel.Text = p6
        _TextLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
        _TextLabel.TextSize = 18
        _TextLabel.Font = Enum.Font.GothamBold
        _TextLabel.TextXAlignment = Enum.TextXAlignment.Left
        _TextLabel.Parent = _Frame2

        return {
            ScreenGui = _ScreenGui,
            Frame = _Frame,
            TitleBar = _Frame2,
        }
    end,
    CreateDropdown = function(_, p13, p14, p15, p16)
        local _Frame3 = Instance.new('Frame')

        _Frame3.Size = UDim2.new(1, -20, 0, 40)
        _Frame3.Position = UDim2.new(0, 10, 0, 50)
        _Frame3.BackgroundTransparency = 1
        _Frame3.Parent = p13

        local _TextLabel2 = Instance.new('TextLabel')

        _TextLabel2.Size = UDim2.new(1, 0, 0, 20)
        _TextLabel2.BackgroundTransparency = 1
        _TextLabel2.Text = p14
        _TextLabel2.TextColor3 = Color3.fromRGB(180, 180, 255)
        _TextLabel2.TextSize = 14
        _TextLabel2.Font = Enum.Font.Gotham
        _TextLabel2.TextXAlignment = Enum.TextXAlignment.Left
        _TextLabel2.Parent = _Frame3

        local _TextButton = Instance.new('TextButton')

        _TextButton.Size = UDim2.new(1, 0, 0, 30)
        _TextButton.Position = UDim2.new(0, 0, 0, 20)
        _TextButton.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
        _TextButton.Text = 'Select a place...'
        _TextButton.TextColor3 = Color3.fromRGB(200, 200, 255)
        _TextButton.TextSize = 14
        _TextButton.Font = Enum.Font.Gotham
        _TextButton.Parent = _Frame3

        local _UICorner3 = Instance.new('UICorner')

        _UICorner3.CornerRadius = UDim.new(0, 5)
        _UICorner3.Parent = _TextButton

        local _ScrollingFrame = Instance.new('ScrollingFrame')

        _ScrollingFrame.Size = UDim2.new(1, 0, 0, 150)
        _ScrollingFrame.Position = UDim2.new(0, 0, 0, 55)
        _ScrollingFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        _ScrollingFrame.BorderSizePixel = 0
        _ScrollingFrame.ScrollBarThickness = 4
        _ScrollingFrame.Visible = false
        _ScrollingFrame.ZIndex = 2
        _ScrollingFrame.Parent = _Frame3

        local _UICorner4 = Instance.new('UICorner')

        _UICorner4.CornerRadius = UDim.new(0, 5)
        _UICorner4.Parent = _ScrollingFrame

        local u23 = nil

        local function v33()
            _ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, #p15 * 30)

            local v24 = next
            local v25, v26 = _ScrollingFrame:GetChildren()

            while true do
                local v27

                v26, v27 = v24(v25, v26)

                if v26 == nil then
                    break
                end
                if v27:IsA('TextButton') then
                    v27:Destroy()
                end
            end

            local v28, v29, v30 = pairs(p15)

            while true do
                local u31

                v30, u31 = v28(v29, v30)

                if v30 == nil then
                    break
                end

                local _TextButton2 = Instance.new('TextButton')

                _TextButton2.Size = UDim2.new(1, 0, 0, 30)
                _TextButton2.Position = UDim2.new(0, 0, 0, (v30 - 1) * 30)
                _TextButton2.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
                _TextButton2.Text = '  ' .. u31
                _TextButton2.TextColor3 = Color3.fromRGB(200, 200, 255)
                _TextButton2.TextSize = 14
                _TextButton2.Font = Enum.Font.Gotham
                _TextButton2.TextXAlignment = Enum.TextXAlignment.Left
                _TextButton2.ZIndex = 3
                _TextButton2.Parent = _ScrollingFrame

                _TextButton2.MouseButton1Click:Connect(function()
                    u23 = u31:match('%(ID: (%d+)%)')
                    _TextButton.Text = u31:sub(1, 25) .. (u31:len() > 25 and '...' or '')
                    _ScrollingFrame.Visible = false

                    p16(u23)
                end)
                _TextButton2.MouseEnter:Connect(function()
                    _TextButton2.BackgroundColor3 = Color3.fromRGB(55, 55, 65)
                end)
                _TextButton2.MouseLeave:Connect(function()
                    _TextButton2.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
                end)
            end
        end

        _TextButton.MouseButton1Click:Connect(function()
            _ScrollingFrame.Visible = not _ScrollingFrame.Visible
        end)
        v33()

        return {
            Frame = _Frame3,
            UpdateOptions = v33,
            GetSelected = function()
                return u23
            end,
        }
    end,
    CreateButton = function(_, p34, p35, p36, p37)
        local _TextButton3 = Instance.new('TextButton')

        _TextButton3.Size = UDim2.new(1, -20, 0, 40)
        _TextButton3.Position = p36
        _TextButton3.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
        _TextButton3.Text = p35
        _TextButton3.TextColor3 = Color3.fromRGB(200, 200, 255)
        _TextButton3.TextSize = 16
        _TextButton3.Font = Enum.Font.Gotham
        _TextButton3.Parent = p34

        local _UICorner5 = Instance.new('UICorner')

        _UICorner5.CornerRadius = UDim.new(0, 5)
        _UICorner5.Parent = _TextButton3

        _TextButton3.MouseButton1Click:Connect(p37)
        _TextButton3.MouseEnter:Connect(function()
            _TextButton3.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
        end)
        _TextButton3.MouseLeave:Connect(function()
            _TextButton3.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
        end)

        return _TextButton3
    end,
}

while task.wait() do
    local v41, v42, v43 = pairs(v4:GetCurrentPage())

    while true do
        local v44

        v43, v44 = v41(v42, v43)

        if v43 == nil then
            break
        end

        table.insert(v5, v44.Name .. ' (ID: ' .. tostring(v44.PlaceId) .. ')')
    end

    if v4.IsFinished then
        break
    end

    v4:AdvanceToNextPageAsync()
end

local _SubplaceExplorer = v40:CreateWindow('Subplace Explorer')
local u46 = nil

v40:CreateDropdown(_SubplaceExplorer.Frame, 'Select Place', v5, function(p47)
    u46 = p47
end)
v40:CreateButton(_SubplaceExplorer.Frame, 'Teleport to Place', UDim2.new(0, 10, 0, 220), function()
    if u46 then
        _TeleportService:Teleport(tonumber(u46), _Players.LocalPlayer)
    else
        warn('No place selected!')
    end
end)
v40:CreateButton(_SubplaceExplorer.Frame, 'Copy Place ID', UDim2.new(0, 10, 0, 270), function()
    if u46 then
        setclipboard(u46)
        print('Copied Place ID: ' .. u46)
    else
        print('No Place ID selected to copy.')
    end
end)

--// Professional Window Drag System

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
if not player then return end

local playerGui = player:WaitForChild("PlayerGui")

local processed = setmetatable({}, {__mode = "k"})
local MIN_SIZE = 140
local TOPBAR_HEIGHT = 50

local function isValidFrame(obj)
	if not obj:IsA("Frame") then return false end
	if processed[obj] then return false end
	if not obj.Parent or not obj.Parent:IsA("ScreenGui") then return false end
	if not obj.Visible then return false end
	if obj.AbsoluteSize.X < MIN_SIZE or obj.AbsoluteSize.Y < MIN_SIZE then return false end
	if not obj:IsDescendantOf(playerGui) then return false end
	return true
end

local function isInsideTopBar(frame, position)
	local absPos = frame.AbsolutePosition
	local relativeY = position.Y - absPos.Y
	
	return relativeY >= 0 and relativeY <= TOPBAR_HEIGHT
end

local function makeDraggable(frame)
	if not isValidFrame(frame) then return end
	processed[frame] = true
	
	local dragging = false
	local activeInput = nil
	local startPos
	local startOffset
	
	frame.InputBegan:Connect(function(input)
		if input.UserInputType ~= Enum.UserInputType.Touch
			and input.UserInputType ~= Enum.UserInputType.MouseButton1 then
			return
		end
		
		if input.UserInputState ~= Enum.UserInputState.Begin then
			return
		end
		
		
		if not isInsideTopBar(frame, input.Position) then
			return
		end
		
		dragging = true
		activeInput = input
		startPos = input.Position
		startOffset = frame.Position
	end)
	
	frame.InputChanged:Connect(function(input)
		if not dragging then return end
		if input ~= activeInput then return end
		
		local delta = input.Position - startPos
		
		frame.Position = UDim2.new(
			startOffset.X.Scale,
			startOffset.X.Offset + delta.X,
			startOffset.Y.Scale,
			startOffset.Y.Offset + delta.Y
		)
	end)
	
	frame.InputEnded:Connect(function(input)
		if input == activeInput then
			dragging = false
			activeInput = nil
		end
	end)
end

for _, obj in ipairs(playerGui:GetDescendants()) do
	makeDraggable(obj)
end

playerGui.DescendantAdded:Connect(function(obj)
	makeDraggable(obj)
end)
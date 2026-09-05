local _ = game.Players.LocalPlayer
local _CoreGui = game:GetService('CoreGui')

if not _CoreGui:FindFirstChild('Mr_3242UI') then
    local _ScreenGui = Instance.new('ScreenGui')

    _ScreenGui.Name = 'Mr_3242UI'
    _ScreenGui.ResetOnSpawn = false
    _ScreenGui.IgnoreGuiInset = true
    _ScreenGui.Parent = _CoreGui

    local _ImageLabel = Instance.new('ImageLabel')

    _ImageLabel.Name = 'Shadow'
    _ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    _ImageLabel.Size = UDim2.new(0, 285, 0, 300)
    _ImageLabel.Position = UDim2.new(0.5, 0, 0.5, 5)
    _ImageLabel.BackgroundTransparency = 1
    _ImageLabel.Image = 'rbxassetid://136559706836779'
    _ImageLabel.ScaleType = Enum.ScaleType.Slice
    _ImageLabel.SliceCenter = Rect.new(60, 48, 64, 48)
    _ImageLabel.SliceScale = 1.15
    _ImageLabel.ImageColor3 = Color3.new(0, 0, 0)
    _ImageLabel.ZIndex = 0
    _ImageLabel.Parent = _ScreenGui

    local _Frame = Instance.new('Frame')

    _Frame.Size = UDim2.new(0, 210, 0, 230)
    _Frame.Position = UDim2.new(0.5, -105, 0.5, -110)
    _Frame.BackgroundColor3 = Color3.new(0, 0, 0)
    _Frame.BackgroundTransparency = 0
    _Frame.BorderSizePixel = 0
    _Frame.Active = true
    _Frame.Draggable = false
    _Frame.Name = 'MainFrame'
    _Frame.ZIndex = 1
    _Frame.Parent = _ScreenGui
    Instance.new('UICorner', _Frame).CornerRadius = UDim.new(0, 12)

    local _TextButton = Instance.new('TextButton')

    _TextButton.Size = UDim2.new(0, 120, 0, 35)
    _TextButton.Position = UDim2.new(1, -190, 0, 8)
    _TextButton.Text = 'Hide GUI'
    _TextButton.Font = Enum.Font.Gotham
    _TextButton.TextSize = 22
    _TextButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    _TextButton.TextColor3 = Color3.new(1, 1, 1)
_TextButton.ZIndex = 99999999
    _TextButton.Parent = _ScreenGui
    Instance.new('UICorner', _TextButton).CornerRadius = UDim.new(0, 8)

    local _TextButton2 = Instance.new('TextButton')

    _TextButton2.Size = UDim2.new(0, 25, 0, 25)
    _TextButton2.Position = UDim2.new(1, -30, 0, 5)
_TextButton2.Text = "X"
_TextButton2.Font = Enum.Font.GothamBold
_TextButton2.TextSize = 16
_TextButton2.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
_TextButton2.TextColor3 = Color3.fromRGB(255, 255, 255)
    _TextButton2.Parent = _Frame
    Instance.new('UICorner', _TextButton2).CornerRadius = UDim.new(0, 12)

    _TextButton2.MouseButton1Click:Connect(function()
        _ScreenGui:Destroy()
    end)

    local u7 = false

    _TextButton.MouseButton1Click:Connect(function()
        u7 = not u7
        _Frame.Visible = not u7
        _ImageLabel.Visible = not u7

        if not u7 then
            _Frame.Position = UDim2.new(0.5, -105, 0.5, -110)
            _ImageLabel.Position = UDim2.new(0.5, 0, 0.5, 5)
        end

        _TextButton.Text = u7 and 'Show GUI' or 'Hide GUI'
    end)

    local u8 = nil
    local u9 = nil
    local u10 = nil
    local u11 = nil
    local _UserInputService = game:GetService('UserInputService')

    _Frame.InputBegan:Connect(function(p13)
        if p13.UserInputType == Enum.UserInputType.MouseButton1 or p13.UserInputType == Enum.UserInputType.Touch then
            u8 = true
            u10 = p13.Position
            u11 = _Frame.Position

            p13.Changed:Connect(function()
                if p13.UserInputState == Enum.UserInputState.End then
                    u8 = false
                end
            end)
        end
    end)
    _Frame.InputChanged:Connect(function(p14)
        if p14.UserInputType == Enum.UserInputType.MouseMovement or p14.UserInputType == Enum.UserInputType.Touch then
            u9 = p14
        end
    end)
    _UserInputService.InputChanged:Connect(function(p15)
        if p15 == u9 and u8 then
            local v16 = p15.Position - u10

            _Frame.Position = UDim2.new(u11.X.Scale, u11.X.Offset + v16.X, u11.Y.Scale, u11.Y.Offset + v16.Y)
            _ImageLabel.Position = UDim2.new(0.5, _Frame.Position.X.Offset + 105, 0.5, _Frame.Position.Y.Offset + 115)
        end
    end)

    local _TextButton3 = Instance.new('TextButton')

    _TextButton3.Size = UDim2.new(0, 180, 0, 40)
    _TextButton3.Position = UDim2.new(0.5, -90, 0, 35)
    _TextButton3.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    _TextButton3.TextColor3 = Color3.new(1, 1, 1)
    _TextButton3.Text = 'Get All Tools\n(wait 2 sec)'
    _TextButton3.Font = Enum.Font.Gotham
    _TextButton3.TextSize = 20
    _TextButton3.Parent = _Frame
    Instance.new('UICorner', _TextButton3).CornerRadius = UDim.new(0, 12)

    _TextButton3.MouseButton1Click:Connect(function()
        task.wait(2)

        local _LocalPlayer = game.Players.LocalPlayer

        if _LocalPlayer.Character and _LocalPlayer.Character:FindFirstChildOfClass('Humanoid') then
            _LocalPlayer.Character:FindFirstChildOfClass('Humanoid').Health = 0
        end

        local v19 = getrawmetatable(game)

        setreadonly(v19, false)

        local ___namecall = v19.__namecall

        v19.__namecall = newcclosure(function(p21, ...)
            return getnamecallmethod() == 'UserOwnsGamePassAsync' and true or ___namecall(p21, unpack({...}))
        end)

        local _ReplicatedStorage = game:GetService('ReplicatedStorage')
        local _Tools = _ReplicatedStorage:WaitForChild('ShopAssetsFolder'):WaitForChild('ToolsFolder'):WaitForChild('Tools')
        local _SendTool = _ReplicatedStorage:WaitForChild('ShopAssetsFolder'):WaitForChild('AssetRemotes'):WaitForChild('SendTool')
        local v25, v26, v27 = ipairs(_Tools:GetChildren())

        while true do
            local v28

            v27, v28 = v25(v26, v27)

            if v27 == nil then
                break
            end
            if v28:IsA('Tool') then
                _SendTool:FireServer(v28.Name, true, false)
            end
        end
    end)

    local _TextButton4 = Instance.new('TextButton')

    _TextButton4.Size = UDim2.new(0, 180, 0, 40)
    _TextButton4.Position = UDim2.new(0.5, -90, 0, 85)
    _TextButton4.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    _TextButton4.TextColor3 = Color3.new(1, 1, 1)
    _TextButton4.Text = 'Get All Server Tools (Useless)'
    _TextButton4.Font = Enum.Font.Gotham
    _TextButton4.TextSize = 18
    _TextButton4.TextWrapped = true
    _TextButton4.Parent = _Frame
    Instance.new('UICorner', _TextButton4).CornerRadius = UDim.new(0, 12)

    _TextButton4.MouseButton1Click:Connect(function()
        local _LocalPlayer2 = game.Players.LocalPlayer
        local _Remotes = (_LocalPlayer2.Character or _LocalPlayer2.CharacterAdded:Wait()):WaitForChild('ShopCharacterScripts'):WaitForChild('DPDeathShop'):WaitForChild('Remotes')

        for v32 = 1, 30 do
            local v33 = _Remotes:FindFirstChild('r' .. v32)

            if v33 then
                v33:FireServer()
                task.wait(0.1)
            end
        end
    end)

    local _TextButton5 = Instance.new('TextButton')

    _TextButton5.Size = UDim2.new(0, 180, 0, 40)
    _TextButton5.Position = UDim2.new(0.5, -90, 0, 135)
    _TextButton5.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    _TextButton5.TextColor3 = Color3.new(1, 1, 1)
    _TextButton5.Text = 'Kill All'
    _TextButton5.Font = Enum.Font.Gotham
    _TextButton5.TextSize = 18
    _TextButton5.TextWrapped = true
    _TextButton5.Parent = _Frame
    Instance.new('UICorner', _TextButton5).CornerRadius = UDim.new(0, 12)

    _TextButton5.MouseButton1Click:Connect(function()
        local v35, v36, v37 = ipairs(game.Players:GetPlayers())

        while true do
            local v38

            v37, v38 = v35(v36, v37)

            if v37 == nil then
                break
            end
            if v38.Character and v38.Character:FindFirstChild('HumanoidRootPart') then
                game:GetService('ReplicatedStorage'):WaitForChild('ShopAssetsFolder'):WaitForChild('AssetRemotes'):WaitForChild('BatonRemotes'):WaitForChild('HitRemote'):FireServer('BasicBaton', v38.Character.HumanoidRootPart.Position, {
                    BlockDamage = 9000000000,
                    HasIdleVFX = false,
                    Damage = 9000000000,
                    SwingSound = 'rbxassetid://9113305619',
                    DefaultDamage = 9000000000,
                    Force = 9000000000,
                    ImpactSound = {
                        'rbxassetid://6931263860',
                    },
                    AnimationName = 'WeaponAnimation',
                    PassiveAbility = false,
                    TargetSound = {
                        'rbxassetid://9117969717',
                    },
                    Name = 'BasicBaton',
                    PassiveChance = 5,
                    SpecialBuildup = 12,
                    LoopSound = false,
                }, v38.Character, false, false, false)
            end
        end
    end)

    local _TextLabel = Instance.new('TextLabel')

    _TextLabel.Size = UDim2.new(1, 0, 0, 18)
    _TextLabel.Position = UDim2.new(0, 0, 1, -35)
    _TextLabel.BackgroundTransparency = 1
    _TextLabel.Text = 'TikTok: Mr_3242'
    _TextLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
    _TextLabel.TextTransparency = 0.1
    _TextLabel.TextSize = 21
    _TextLabel.Font = Enum.Font.SourceSans
    _TextLabel.Parent = _Frame
end

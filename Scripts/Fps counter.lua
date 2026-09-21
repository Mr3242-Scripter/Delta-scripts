local coregui=[[local ScreenGui=Instance.new('ScreenGui',game:GetService('CoreGui'))
local Frame1=Instance.new('Frame',ScreenGui)
local Frame2=Instance.new('Frame',Frame1)
local TextLabel=Instance.new('TextLabel',Frame2)
local UICorner=Instance.new('UICorner',Frame2)
ScreenGui.DisplayOrder=6
ScreenGui.ScreenInsets=Enum.ScreenInsets.TopbarSafeInsets
Frame1.Size=UDim2.new(1,0,0,48)
Frame1.Position=UDim2.new(0,0,0,10)
Frame1.BackgroundTransparency=1
Frame2.AnchorPoint=Vector2.new(0,0.5)
Frame2.Position=UDim2.new(0,8,0.5,0)
Frame2.Size=UDim2.new(0,96,0,44)
Frame2.BackgroundColor3=Color3.fromRGB(18,18,21)
Frame2.BackgroundTransparency=0.08*game:GetService('GuiService').PreferredTransparency
TextLabel.Size=UDim2.new(1,0,1,0)
TextLabel.BackgroundTransparency=1
TextLabel.TextColor3=Color3.new(1,1,1)
TextLabel.TextSize=18
TextLabel.Font=Enum.Font.BuilderSansBold
UICorner.CornerRadius=UDim.new(1,0)

game:GetService('GuiService'):GetPropertyChangedSignal('PreferredTransparency'):Connect(function()
    Frame2.BackgroundTransparency=0.08*game:GetService('GuiService').PreferredTransparency
end)

local RunService=game:GetService('RunService')

local frameTimes={}
local totalTime=0
local updateTimer=0
local window=1

RunService.RenderStepped:Connect(function(dt)
    frameTimes[#frameTimes+1]=dt
    totalTime+=dt
    updateTimer+=dt

    if totalTime>window then
        local excess=totalTime-window

        while #frameTimes>0 and excess>=frameTimes[1] do
            excess-=frameTimes[1]
            totalTime-=frameTimes[1]
            table.remove(frameTimes,1)
        end

        if #frameTimes>0 then
            totalTime-=excess
            frameTimes[1]-=excess
        end
    end

    if updateTimer>=0.1 then
        local fps=#frameTimes/totalTime
        TextLabel.Text=string.format('%.1f',fps)..' FPS'
        updateTimer=0
    end
end)]]

local playergui=[[local Frame=Instance.new('Frame',game:GetService('Players').LocalPlayer.PlayerGui.TopbarStandard.Holders.Left)
local UICorner=Instance.new('UICorner',Frame)
local TextLabel=Instance.new('TextLabel',Frame)
Frame.LayoutOrder=-math.huge
Frame.Size=UDim2.new(0,96,0,44)
Frame.BackgroundColor3=Color3.fromRGB(18,18,21)
Frame.BackgroundTransparency=0.08
UICorner.CornerRadius=UDim.new(1,0)
TextLabel.Size=UDim2.new(1,0,1,0)
TextLabel.BackgroundTransparency=1
TextLabel.TextColor3=Color3.new(1,1,1)
TextLabel.Font=Enum.Font.BuilderSansBold
TextLabel.TextSize=18

local RunService=game:GetService('RunService')

local frameTimes={}
local totalTime=0
local updateTimer=0
local window=1

RunService.RenderStepped:Connect(function(dt)
    frameTimes[#frameTimes+1]=dt
    totalTime+=dt
    updateTimer+=dt

    if totalTime>window then
        local excess=totalTime-window

        while #frameTimes>0 and excess>=frameTimes[1] do
            excess-=frameTimes[1]
            totalTime-=frameTimes[1]
            table.remove(frameTimes,1)
        end

        if #frameTimes>0 then
            totalTime-=excess
            frameTimes[1]-=excess
        end
    end

    if updateTimer>=0.1 then
        local fps=#frameTimes/totalTime
        TextLabel.Text=string.format('%.1f',fps)..' FPS'
        updateTimer=0
    end
end)]]

if game:GetService('Players').LocalPlayer:FindFirstChild('PlayerGui'):FindFirstChild('TopbarStandard')then
    loadstring(playergui)()
else
    loadstring(coregui)()
end
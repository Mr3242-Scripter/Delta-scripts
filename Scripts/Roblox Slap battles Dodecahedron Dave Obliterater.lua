if game.PlaceId == 6403373529 or game.PlaceId == 9015014224 or game.PlaceId == 11520107397 then
    local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/0-BaconScripter-0/Mobile-Support-For-UI-Library/refs/heads/main/Unnamed.lua"))()
    local Window = Library:CreateWindow("Slap Battles")
    
    Window:AddButton({text = "Teleport to barzil", callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Lobby.brazil.portal.CFrame
    end})
    
    Window:AddLabel({text = "Credits: Mr_3242"})
    
    Library:Init()
else
    local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/0-BaconScripter-0/Mobile-Support-For-UI-Library/refs/heads/main/Unnamed.lua"))()
    local Window = Library:CreateWindow("Slap Battles")
    
    Window:AddButton({text = "Teleport To Bossfight", callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(4954.66895, 5659.12646, -424.348236, -0.694308102, -4.74649617e-08, 0.719677866, 2.64693628e-10, 1, 6.6208429e-08, -0.719677866, 4.6159542e-08, -0.694308102)
    end})
    
    Window:AddLabel({text = "only one-time click"})
    
    Window:AddButton({text = "Auto Dave", callback = function()
        if not game.Workspace:FindFirstChild("SafeSpot") then
            local safespot = Instance.new("Part", game.Workspace)
            safespot.Name = "SafeSpot"
            safespot.Position = Vector3.new(4890.326171875, 5700.2861328125, -341.87335205078125)
            safespot.Size = Vector3.new(2048, 1, 2048)
            safespot.Anchored = true
            safespot.Transparency = 1
        end
        
        if not game.Workspace:FindFirstChild("antivoid") then
            local antivoid = Instance.new("Part", game.Workspace)
            antivoid.Name = "antivoid"
            antivoid.Position = Vector3.new(4870.43994140625, 5480, -351.97833251953125)
            antivoid.Size = Vector3.new(2048, 1, 2048)
            antivoid.Anchored = true
            antivoid.Transparency = 1
        end
        
        if not game.Workspace:FindFirstChild("notdyingfromdaveshead") then
            local notdyingfromdaveshead = Instance.new("Part", game.Workspace)
            notdyingfromdaveshead.Name = "notdyingfromdaveshead"
            notdyingfromdaveshead.Position = Vector3.new(4868.197265625, 5610, -235.95556640625)
            notdyingfromdaveshead.Size = Vector3.new(50, 1, 50)
            notdyingfromdaveshead.Anchored = true
            notdyingfromdaveshead.Transparency = 1
        end
        
        if not game.Workspace:FindFirstChild("floatingpart") then
            local float = Instance.new("Part", game.Workspace)
            float.Name = "floatingpart"
            float.Position = Vector3.new(0, 0, 0)
            float.Size = Vector3.new(20, 2, 20)
            float.Anchored = true
            float.Transparency = 1
        end
        
        task.spawn(function()
            repeat task.wait() until game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Phase3Loop")
            repeat task.wait() until workspace:FindFirstChild("ExplosiveGhosts")
            local function Bomb()
                if workspace:FindFirstChild("ExplosiveGhosts") then
                    if workspace.ExplosiveGhosts["1"]:FindFirstChild("ProximityPrompt") then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.ExplosiveGhosts["1"].CFrame
                        task.wait(0.2)
                        fireproximityprompt(workspace.ExplosiveGhosts["1"].ProximityPrompt)
                    elseif workspace.ExplosiveGhosts["2"]:FindFirstChild("ProximityPrompt") then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.ExplosiveGhosts["2"].CFrame
                        task.wait(0.2)
                        fireproximityprompt(workspace.ExplosiveGhosts["2"].ProximityPrompt)
                    elseif workspace.ExplosiveGhosts["3"]:FindFirstChild("ProximityPrompt") then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.ExplosiveGhosts["3"].CFrame
                        task.wait(0.2)
                        fireproximityprompt(workspace.ExplosiveGhosts["3"].ProximityPrompt)
                    elseif workspace.ExplosiveGhosts["4"]:FindFirstChild("ProximityPrompt") then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.ExplosiveGhosts["4"].CFrame
                        task.wait(0.2)
                        fireproximityprompt(workspace.ExplosiveGhosts["4"].ProximityPrompt)
                    end
                end
            end
            
            repeat task.wait()
            for _, v in pairs(game.Workspace:GetChildren()) do
                if v.Name == "C4" then
                    if not game.Players.LocalPlayer.Backpack:FindFirstChild("C4") then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
                        task.wait(0.2)
                        fireproximityprompt(v.ProximityPrompt)
                        repeat task.wait() until game.Players.LocalPlayer.Backpack:FindFirstChild("C4")
                        game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack.C4)
                    end
                    task.wait(0.1)
                    Bomb()
                end
            end
            until not workspace.ExplosiveGhosts["1"]:FindFirstChild("ProximityPrompt") and not workspace.ExplosiveGhosts["2"]:FindFirstChild("ProximityPrompt") and not workspace.ExplosiveGhosts["3"]:FindFirstChild("ProximityPrompt") and not workspace.ExplosiveGhosts["4"]:FindFirstChild("ProximityPrompt")
            for i = 1, 5 do
                game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(game.Workspace:FindFirstChild("SafeSpot").CFrame + Vector3.new(0, 4, 0))
                task.wait(0.01)
            end
        end)
        
        task.spawn(function()
            while task.wait() do
                if game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Phase1Loop") then
                    if game.Workspace:FindFirstChild("floatingpart") then
                        game.Workspace:FindFirstChild("floatingpart").CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, -4, 0)
                    end
                elseif game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Phase2Loop") then
                    if game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("rebar") then
                        game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.Space, false, game)
                        task.wait()
                        game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.Space, false, game)
                    end
                end
            end
        end)
        while task.wait() do
            pcall(function()
                if game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Phase1Loop") then
                    if not workspace.bossStorage.leftHand.PointerMimic:FindFirstChild("TouchInterest") then
                        for _, v in pairs(workspace:GetChildren()) do
                            if v.Name == "Part" and v.Color == Color3.fromRGB(255, 0, 0) then
                                local connection
                                
                                connection = v.Touched:Connect(function(hit)
                                    local character = hit.Parent
                                    local hrp = character and character:FindFirstChild("HumanoidRootPart")
                                    
                                    if hrp then
                                        hrp.CFrame = v.CFrame + Vector3.new(0, 40, 0)
                                        connection:Disconnect()
                                    end
                                end)  
                            end  
                        end  
                    else  
                        repeat task.wait()  
                        if not game.Players.LocalPlayer.Character:FindFirstChild("Lantern") then  
                            game.Players.LocalPlayer.Backpack:FindFirstChild("Lantern").Parent = game.Players.LocalPlayer.Character  
                        else  
                            game.Players.LocalPlayer.Character:FindFirstChild("Lantern"):Activate()  
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.bossStorage.leftHand.PointerMimic.CFrame * CFrame.new(0,0,8)  
                        end  
                        until not workspace.bossStorage.leftHand.PointerMimic:FindFirstChild("TouchInterest")  
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(4902.37842, 5548.90527, -384.988007, 0.00307199778, 3.94020176e-08, 0.999995291, 1.56049786e-08, 1, -3.94501427e-08, -0.999995291, 1.5726096e-08, 0.00307199778)  
                    end  
                elseif game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Phase2Loop") then         
                    if not workspace:FindFirstChild("lightningVFX") then  
                        for i, nail in pairs(workspace.bossStorage:GetChildren()) do  
                            if (nail.Name == "nail" or nail.Name == "thiccNail") and nail:FindFirstChild("object") and nail.object.Transparency == 0 then
                                
                                local y = nail.object.Position.Y
                                
                                if y <= 5565 and y >= 5536 then
                                    if not game.Players.LocalPlayer.Character:FindFirstChild("Lantern") then
                                        game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack.Lantern)
                                    else
                                        game.Players.LocalPlayer.Character.Lantern:Activate()
                                        game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(
                                        nail.object.CFrame * CFrame.new(0, -9, 0) * CFrame.Angles(math.rad(90), 0, 0))
                                    end
                                else
                                    game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(workspace.SafeSpot.CFrame + Vector3.new(0, 4, 0))
                                end
                            end
                        end  
                    else  
                        game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(game.Workspace:FindFirstChild("SafeSpot").CFrame + Vector3.new(0, 4, 0))  
                    end  
                elseif game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Phase3Loop") then  
                    if workspace:FindFirstChild("BombGlove") then  
                        if not game.Players.LocalPlayer.Backpack:FindFirstChild("Bomb") and not game.Players.LocalPlayer.Character:FindFirstChild("Bomb") then      
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.BombGlove.Glove.CFrame
                            task.wait(0.2)
                            fireproximityprompt(workspace.BombGlove.Glove.ProximityPrompt)
                        elseif game.Players.LocalPlayer.Backpack:FindFirstChild("Bomb") and not game.Players.LocalPlayer.Character:FindFirstChild("Bomb") then
                            game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack.Bomb)
                        elseif game.Players.LocalPlayer.Character:FindFirstChild("Bomb") then  
                            for _, ability in pairs(game:GetService("Players").LocalPlayer.PlayerGui:GetChildren()) do  
                                if ability.Name == "Component" and ability:FindFirstChild("AbilityCooldown") then  
                                    if ability:FindFirstChild("AbilityCooldown").Visible == false then  
                                        task.spawn(function()  
                                            repeat task.wait()  
                                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(4868.197265625, 5642.74462890625, -236.45556640625) * CFrame.Angles(math.rad(-90),0,0)  
                                            until game.Workspace.Bombs:FindFirstChild(game.Players.LocalPlayer.Name.."_bømb")
                                            task.wait(0.5) 
                                            for i = 1, 5 do  
                                                game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(game.Workspace:FindFirstChild("SafeSpot").CFrame + Vector3.new(0, 4, 0))  
                                                task.wait(0.01)  
                                            end  
                                        end)  
                                        game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.E, false, game)  
                                        task.wait()  
                                        game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.E, false, game)
                                        task.wait(0.8)
                                        game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.E, false, game)  
                                        task.wait()  
                                        game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.E, false, game)                                 
                                    end  
                                else  
                                    game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(game.Workspace:FindFirstChild("SafeSpot").CFrame + Vector3.new(0, 4, 0))  
                                end  
                            end  
                        end  
                    end  
                end  
            end)
        end
    end})
    
    Window:AddLabel({text = "Credits: Mr_3242"})
    
    Library:Init()
end
local function isCharacterOrNPC(obj)
	local model = obj:FindFirstAncestorOfClass("Model")
	return model and model:FindFirstChildOfClass("Humanoid")
end

local function checkPart(obj)
	if obj:IsA("BasePart") and obj.Transparency == 1 and not isCharacterOrNPC(obj) then
		obj:Destroy()
	end
end

for _, obj in ipairs(workspace:GetDescendants()) do
	checkPart(obj)
end

workspace.DescendantAdded:Connect(checkPart)
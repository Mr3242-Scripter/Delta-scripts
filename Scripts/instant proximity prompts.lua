local workspace = game:GetService("Workspace")

for _, v in ipairs(workspace:GetDescendants()) do
    if v:IsA("ProximityPrompt") then
        v.HoldDuration = 0
    end
end

workspace.DescendantAdded:Connect(function(desc)
    if desc:IsA("ProximityPrompt") then
        desc.HoldDuration = 0
    end
end)
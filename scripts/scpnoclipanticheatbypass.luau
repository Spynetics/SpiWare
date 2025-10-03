for _, obj in ipairs(game:GetService("Workspace"):GetDescendants()) do
    if obj:IsA("Model") and obj.Name == "Bounds" then
        for _, child in ipairs(obj:GetChildren()) do
            if child:IsA("BasePart") and child.Name == "Detector" then
                child:Destroy()
            end
        end
    end
end

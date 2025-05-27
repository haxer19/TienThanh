local Players = game:GetService("Players")

local function tp(target)
    local player = Players.LocalPlayer
    local character = player.Character
    local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
    
    if not character or not humanoidRootPart then
        return
    end
    
    if not target or not target:IsA("BasePart") then
        return
    end
    
    humanoidRootPart.CFrame = target.CFrame + Vector3.new(0, 3, 0) 
end

return tp

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

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
local function fly(target)
    local player = Players.LocalPlayer
    local character = player.Character
    local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
    
    if not character or not humanoidRootPart then
        return
    end
    
    if not target or not target:IsA("BasePart") then
        return
    end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.PlatformStand = true
    end
    local targetCFrame = target.CFrame + Vector3.new(0, 3, 0)
    local tweenInfo = TweenInfo.new(2,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut)
    local tween = TweenService:Create(humanoidRootPart, tweenInfo, {CFrame = targetCFrame})
    tween:Play()
    tween.Completed:Connect(function()
        if humanoid then
            humanoid.PlatformStand = false
        end
    end)
end

return {tp = tp, fly = fly}

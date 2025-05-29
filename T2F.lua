local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

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

local function tp_v2(target)
    local player = Players.LocalPlayer
    local character = player.Character
    local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
    
    if not character or not humanoidRootPart then
        return
    end
    
    if not target or not target:IsA("BasePart") then
        return
    end
    local originalCollisions = {}
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            originalCollisions[part] = part.CanCollide
            part.CanCollide = false
        end
    end
    local targetCFrame = target.CFrame + Vector3.new(0, 3, 0)
    local rayOrigin = target.Position + Vector3.new(0, 10, 0)
    local rayDirection = Vector3.new(0, -15, 0) 
    local raycastParams = RaycastParams.new()
    raycastParams.FilterDescendantsInstances = {character} 
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    local raycastResult = workspace:Raycast(rayOrigin, rayDirection, raycastParams)
    if raycastResult and raycastResult.Instance then
        targetCFrame = CFrame.new(raycastResult.Position + Vector3.new(0, 3, 0))
    end
    humanoidRootPart.CFrame = targetCFrame
    for part, canCollide in pairs(originalCollisions) do
        if part.Parent then
            part.CanCollide = canCollide
        end
    end
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
    local originalCollisions = {}
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            originalCollisions[part] = part.CanCollide
            part.CanCollide = false
        end
    end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.PlatformStand = true
    end
    local targetCFrame = target.CFrame + Vector3.new(0, 3, 0)
    
    local tweenInfo = TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
    
    local tween = TweenService:Create(humanoidRootPart, tweenInfo, {CFrame = targetCFrame})
    tween:Play()
    tween.Completed:Connect(function()
        if humanoid then
            humanoid.PlatformStand = false
        end
        for part, canCollide in pairs(originalCollisions) do
            if part.Parent then 
                part.CanCollide = canCollide
            end
        end
    end)
end

-- Pos Saver
local savedPos = {}

local function save(name)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        savedPos[name] = LocalPlayer.Character.HumanoidRootPart.Position
    end
end

local function back(name)
    if savedPos[name] then
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(savedPos[name])
        end
    end
end

local function clear()
    savedPos = {}
end

local function list()
    print("[ location list ]")
    if next(savedPos) == nil then
        print("...")
    else
        for name, pos in pairs(savedPos) do
            print("  " .. name .. ": " .. tostring(pos))
        end
    end
    print("[ end list ]")
end

local function getPos()
    return savedPos
end

-- tp to cf
local function TpCFrame(x, y, z)
    local player = game.Players.LocalPlayer
    if not player then
        return
    end
    local character = player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then
        return
    end
    character:SetPrimaryPartCFrame(CFrame.new(x, y, z))
end

return {tp = tp, fly = fly, tp_v2 = tp_v2, save = save, back = back, clear = clear, list = list, getPos = getPos, TpCFrame = TpCFrame}

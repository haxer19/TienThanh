-- Author: TienThanh
-- Date: 31/05/2025

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local GuiService = game:GetService("GuiService")
local player = Players.LocalPlayer

local existingGui = player.PlayerGui:FindFirstChild("Author: TienThanh")
if existingGui then
    existingGui:Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "Author: TienThanh"
screenGui.IgnoreGuiInset = true
screenGui.Parent = player.PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 100)
frame.Position = UDim2.new(0.5, -100, 0.5, -50)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Visible = false
frame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = frame

local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(1, -10, 0, 60)
textLabel.Position = UDim2.new(0, 5, 0, 5)
textLabel.BackgroundTransparency = 1
textLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
textLabel.Font = Enum.Font.SourceSans
textLabel.TextSize = 14
textLabel.TextWrapped = true
textLabel.TextXAlignment = Enum.TextXAlignment.Left
textLabel.TextYAlignment = Enum.TextYAlignment.Top
textLabel.Parent = frame

local copyButton = Instance.new("TextButton")
copyButton.Size = UDim2.new(0, 60, 0, 25)
copyButton.Position = UDim2.new(0, 5, 1, -30)
copyButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
copyButton.Text = "Copy"
copyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
copyButton.Font = Enum.Font.SourceSans
copyButton.TextSize = 14
copyButton.Parent = frame

local copyCorner = Instance.new("UICorner")
copyCorner.CornerRadius = UDim.new(0, 5)
copyCorner.Parent = copyButton

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 25, 0, 25)
closeButton.Position = UDim2.new(1, -30, 0, 5)
closeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.Font = Enum.Font.SourceSans
closeButton.TextSize = 14
closeButton.Parent = frame

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 5)
closeCorner.Parent = closeButton

local toggleButton = Instance.new("ImageButton")
toggleButton.Size = UDim2.new(0, 40, 0, 40)
toggleButton.Position = UDim2.new(0, 10, 0.5, -20)
toggleButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
toggleButton.Image = "rbxassetid://124959055145335"
toggleButton.Parent = screenGui

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 10)
toggleCorner.Parent = toggleButton

local toggleStroke = Instance.new("UIStroke")
toggleStroke.Color = Color3.fromRGB(100, 100, 100)
toggleStroke.Thickness = 2
toggleStroke.Parent = toggleButton

local dragging, dragStart, startPos

local function dragUI(input, ui)
    if dragging then
        local delta = input.Position - dragStart
        local newPos = UDim2.new(0, startPos.X.Offset + delta.X, 0, startPos.Y.Offset + delta.Y)
        local screenSize = GuiService:GetScreenResolution() or Vector2.new(1280, 720)
        local uiSize = ui.AbsoluteSize
        newPos = UDim2.new(
            0, math.clamp(newPos.X.Offset, 0, screenSize.X - uiSize.X),
            0, math.clamp(newPos.Y.Offset, 0, screenSize.Y - uiSize.Y)
        )
        ui.Position = newPos
    end
end

frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
    end
end)

frame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

toggleButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = toggleButton.Position
    end
end)

toggleButton.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        if frame.Visible then
            dragUI(input, frame)
        end
        dragUI(input, toggleButton)
    end
end)

toggleButton.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
end)

local lastCFrame = nil
local function updCF()
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local cframe = player.Character.HumanoidRootPart.CFrame
        if cframe ~= lastCFrame then
            textLabel.Text = string.format("CFrame: %s", tostring(cframe))
            lastCFrame = cframe
        end
    else
        textLabel.Text = "CFrame: Not available"
    end
end

copyButton.MouseButton1Click:Connect(function()
    if textLabel.Text ~= "CFrame: Not available" then
        pcall(function()
            setclipboard(textLabel.Text:sub(9))
            StarterGui:SetCore("SendNotification", {
                Title = "Copied!",
                Text = "CFrame copied to clipboard",
                Duration = 2
            })
        end)
    end
end)

closeButton.MouseButton1Click:Connect(function()
    frame.Visible = false
    toggleButton.Visible = false
end)

game:GetService("RunService").RenderStepped:Connect(function()
    if frame.Visible then
        updCF()
    end
end)

local function adjScr()
    local screenSize = GuiService:GetScreenResolution() or Vector2.new(1280, 720)
    if screenSize.Y < 600 then
        frame.Size = UDim2.new(0, 180, 0, 90)
        textLabel.TextSize = 12
        copyButton.Size = UDim2.new(0, 50, 0, 20)
        copyButton.TextSize = 12
        closeButton.Size = UDim2.new(0, 20, 0, 20)
        closeButton.TextSize = 12
        toggleButton.Size = UDim2.new(0, 35, 0, 35)
    end
end

adjScr()

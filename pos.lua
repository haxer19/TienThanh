-- Roblox UI Script - Optimized Version
-- Author: TienThanh
-- Date: 31/05/2025

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local GuiService = game:GetService("GuiService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local existingGui = playerGui:FindFirstChild("Author: TienThanh")
if existingGui then existingGui:Destroy() end

local function createUICorner(radius, parent)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius)
    corner.Parent = parent
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "Author: TienThanh"
screenGui.IgnoreGuiInset = true
screenGui.Parent = playerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 100)
frame.Position = UDim2.new(1, -210, 0.5, -50)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Visible = false
frame.Parent = screenGui
createUICorner(8, frame)

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
textLabel.Text = ""
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
createUICorner(5, copyButton)

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 25, 0, 25)
closeButton.Position = UDim2.new(1, -30, 0, 5)
closeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.Font = Enum.Font.SourceSans
closeButton.TextSize = 14
closeButton.Parent = frame
createUICorner(5, closeButton)

local toggleButton = Instance.new("ImageButton")
toggleButton.Size = UDim2.new(0, 40, 0, 40)
toggleButton.Position = UDim2.new(0, 10, 0.5, -20)
toggleButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
toggleButton.Image = "rbxassetid://124959055145335"
toggleButton.Parent = screenGui
createUICorner(10, toggleButton)

local toggleStroke = Instance.new("UIStroke")
toggleStroke.Color = Color3.fromRGB(100, 100, 100)
toggleStroke.Thickness = 2
toggleStroke.Parent = toggleButton

local function makeDraggable(guiObject)
    local dragging = false
    local dragStart, startPos

    guiObject.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = guiObject.Position
        end
    end)

    guiObject.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            local screenSize = GuiService:GetScreenResolution()
            local newX = math.clamp(startPos.X.Offset + delta.X, 0, screenSize.X - guiObject.AbsoluteSize.X)
            local newY = math.clamp(startPos.Y.Offset + delta.Y, 0, screenSize.Y - guiObject.AbsoluteSize.Y)
            guiObject.Position = UDim2.new(0, newX, 0, newY)
        end
    end)
end

makeDraggable(frame)
makeDraggable(toggleButton)

local lastFramePos = frame.Position

toggleButton.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
    if frame.Visible then
        frame.Position = lastFramePos
        updateCFrame()
    else
        lastFramePos = frame.Position
    end
end)

closeButton.MouseButton1Click:Connect(function()
    lastFramePos = frame.Position
    frame.Visible = false
    toggleButton.Visible = false
end)

copyButton.MouseButton1Click:Connect(function()
    if textLabel.Text and textLabel.Text ~= "" then
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

local lastCFrame = nil
function updateCFrame()
    local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if root then
        local cf = root.CFrame
        if not lastCFrame or not cf:equals(lastCFrame) then
            textLabel.Text = "CFrame: " .. tostring(cf)
            lastCFrame = cf
        end
    else
        textLabel.Text = "CFrame: Not available"
    end
end

RunService.Heartbeat:Connect(function()
    if frame.Visible then
        updateCFrame()
    end
end)

local function adjustScreen()
    local screenSize = GuiService:GetScreenResolution()
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

adjustScreen()

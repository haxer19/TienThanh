-- Tien Thanh 
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

if player.PlayerGui:FindFirstChild("PPosGUI") then
    player.PlayerGui.PPosGUI:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "PPosGUI"
gui.ResetOnSpawn = false
gui.Parent = player.PlayerGui

local toggleButton = Instance.new("ImageButton")
toggleButton.Size = UDim2.new(0,50,0,50)
toggleButton.Position = UDim2.new(0, 199, 0.5, -200)
toggleButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
toggleButton.Image = "rbxassetid://124959055145335"
toggleButton.Parent = gui
local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 10)
toggleCorner.Parent = toggleButton
local toggleStroke = Instance.new("UIStroke")
toggleStroke.Color = Color3.fromRGB(0,196,255)
toggleStroke.Thickness = 2
toggleStroke.Parent = toggleButton

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 350, 0, 200)
mainFrame.Position = UDim2.new(0.5, -175, 0.5, -100)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false
mainFrame.Parent = gui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 10)
mainCorner.Parent = mainFrame

local sideFrame = Instance.new("Frame")
sideFrame.Size = UDim2.new(0, 100, 1, 0)
sideFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
sideFrame.BorderSizePixel = 0
sideFrame.Parent = mainFrame

local sideCorner = Instance.new("UICorner")
sideCorner.CornerRadius = UDim.new(0, 10)
sideCorner.Parent = sideFrame

local TienThanh = Instance.new("TextButton")
TienThanh.Size = UDim2.new(0.8, 0, 0, 40)
TienThanh.Position = UDim2.new(0.1,0,0.1,0)
TienThanh.BackgroundColor3 = Color3.fromRGB(0,0,0)
TienThanh.Text = "Tien Thanh"
TienThanh.TextColor3 = Color3.fromRGB(0,255,162)
TienThanh.Font = Enum.Font.SourceSans
TienThanh.TextSize = 16
TienThanh.Parent = sideFrame
local tienThanhCorner = Instance.new("UICorner")
tienThanhCorner.CornerRadius = UDim.new(0, 5)
tienThanhCorner.Parent = TienThanh

local copyButton = Instance.new("TextButton")
copyButton.Size = UDim2.new(0.8, 0, 0, 40)
copyButton.Position = UDim2.new(0.1,0,0.4,0)
copyButton.BackgroundColor3 = Color3.fromRGB(0,0,0)
copyButton.Text = "Copy"
copyButton.TextColor3 = Color3.fromRGB(0,255,162)
copyButton.Font = Enum.Font.SourceSans
copyButton.TextSize = 16
copyButton.Parent = sideFrame
local copyCorner = Instance.new("UICorner")
copyCorner.CornerRadius = UDim.new(0, 5)
copyCorner.Parent = copyButton

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0.8, 0, 0, 40)
closeButton.Position = UDim2.new(0.1,0,0.7,0)
closeButton.BackgroundColor3 = Color3.fromRGB(0,0,0)
closeButton.Text = "Close"
closeButton.TextColor3 = Color3.fromRGB(0,255,162)
closeButton.Font = Enum.Font.SourceSans
closeButton.TextSize = 16
closeButton.Parent = sideFrame
local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 5)
closeCorner.Parent = closeButton

local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(0, 240, 1, 0)
contentFrame.Position = UDim2.new(0, 110, 0, 0)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, -10, 1, -40)
scrollFrame.Position = UDim2.new(0, 5, 0, 35)
scrollFrame.BackgroundTransparency = 1
scrollFrame.ScrollBarThickness = 5
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollFrame.Parent = contentFrame

local positionLabel = Instance.new("TextLabel")
positionLabel.Size = UDim2.new(1, -10, 0, 100)
positionLabel.BackgroundTransparency = 1
positionLabel.TextColor3 = Color3.fromRGB(0,230,255)
positionLabel.Font = Enum.Font.SourceSans
positionLabel.TextSize = 14
positionLabel.TextXAlignment = Enum.TextXAlignment.Left
positionLabel.TextYAlignment = Enum.TextYAlignment.Top
positionLabel.TextWrapped = true
positionLabel.Text = "Make by TienThanh ᶻ 𝗓 𐰁"
positionLabel.RichText = true
positionLabel.Parent = scrollFrame

local function formatCFrame(cframe)
    local pos = cframe.Position
    local roundedPos = Vector3.new(
        math.round(pos.X * 100) / 100,
        math.round(pos.Y * 100) / 100,
        math.round(pos.Z * 100) / 100
    )
    local components = {}
    for i, v in ipairs({cframe:GetComponents()}) do
        components[i] = string.format("%.2f", v)
    end
    local formattedCFrame = table.concat(components, ", ")
    local text = string.format(
        '<font color="rgb(0,145,255)">• </font><font color="rgb(0,255,94)">Position:</font> <font color="rgb(0,230,255)">(%0.2f, %0.2f, %0.2f)</font>\n\n<font color="rgb(0,145,255)">• </font><font color="rgb(0,255,94)">CFrame:</font> <font color="rgb(255,0,0)">%s</font>', 
        roundedPos.X, roundedPos.Y, roundedPos.Z, formattedCFrame)
    positionLabel.Text = text
    local lineCount = select(2, text:gsub("\n", "")) + 1
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, lineCount * 16)
end

local function updatePosition()
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local cframe = player.Character.HumanoidRootPart.CFrame
        formatCFrame(cframe)
    end
end

TienThanh.MouseButton1Click:Connect(function()
    setclipboard("Author: Tien Thanh | Date: 31/05/25")
end)

copyButton.MouseButton1Click:Connect(function()
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local cframe = player.Character.HumanoidRootPart.CFrame
        local components = {}
        for i, v in ipairs({cframe:GetComponents()}) do
            components[i] = string.format("%.2f", v)
        end
        local cframeStr = table.concat(components, ", ")
        setclipboard(cframeStr)
    end
end)

closeButton.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

toggleButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)

local isDraggingMain = false
local dragStartMain = nil
local startPosMain = nil

mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isDraggingMain = true
        dragStartMain = input.Position
        startPosMain = mainFrame.Position
    end
end)

mainFrame.InputChanged:Connect(function(input)
    if isDraggingMain and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStartMain
        local newPos = UDim2.new(
            startPosMain.X.Scale, startPosMain.X.Offset + delta.X,
            startPosMain.Y.Scale, startPosMain.Y.Offset + delta.Y
        )
        mainFrame.Position = newPos
    end
end)

mainFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isDraggingMain = false
    end
end)

local isDraggingToggle = false
local dragStartToggle = nil
local startPosToggle = nil

toggleButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isDraggingToggle = true
        dragStartToggle = input.Position
        startPosToggle = toggleButton.Position
    end
end)

toggleButton.InputChanged:Connect(function(input)
    if isDraggingToggle and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStartToggle
        local newPos = UDim2.new(
            startPosToggle.X.Scale, startPosToggle.X.Offset + delta.X,
            startPosToggle.Y.Scale, startPosToggle.Y.Offset + delta.Y
        )
        toggleButton.Position = newPos
    end
end)

toggleButton.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isDraggingToggle = false
    end
end)

game:GetService("RunService").RenderStepped:Connect(updatePosition)

local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name="TPGui"; gui.Parent=player:WaitForChild("PlayerGui")

local Toggle = Instance.new("TextButton"); Toggle.Name="Toggle"
Toggle.Size=UDim2.new(0,77,0,19); Toggle.Position=UDim2.new(0.508,0,0.023,0)
Toggle.BackgroundColor3=Color3.new(0,0,0); Toggle.Text="Menu"
Toggle.Font=Enum.Font.Kalam; Toggle.TextColor3=Color3.new(1,1,1)
Toggle.TextScaled=true; Toggle.Parent=gui
Instance.new("UICorner", Toggle).CornerRadius=UDim.new(0,8)

local Menu = Instance.new("Frame"); Menu.Name="Menu"
Menu.Size=UDim2.new(0,171,0,87); Menu.Position=UDim2.new(0.111,0,0.41,0)
Menu.BackgroundColor3=Color3.new(0,0,0); Menu.BackgroundTransparency=0.2
Menu.Visible=false; Menu.Parent=gui
Instance.new("UICorner", Menu).CornerRadius=UDim.new(0,8)

local Title = Instance.new("Frame"); Title.Name="Title"
Title.Size=UDim2.new(0,108,0,13); Title.Position=UDim2.new(0.113,0,0.039,0)
Title.BackgroundColor3=Color3.new(0,0,0); Title.Parent=Menu
Instance.new("UICorner", Title).CornerRadius=UDim.new(0,8)

local TitleText = Instance.new("TextLabel"); TitleText.Name="TitleText"
TitleText.Size=UDim2.new(0,108,0,13); TitleText.Position=UDim2.new(0,0,0,0)
TitleText.BackgroundTransparency=1; TitleText.Text="Settings"
TitleText.TextColor3=Color3.new(1,1,1); TitleText.Font=Enum.Font.Kalam
TitleText.TextSize=11; TitleText.Parent=Title

local Button1 = Instance.new("TextButton"); Button1.Name="Button1"
Button1.Size=UDim2.new(0,108,0,22); Button1.BackgroundColor3=Color3.new(0,0,0)
Button1.Text="Di chuyển vị trí nút bấm"
Button1.Font=Enum.Font.Kalam; Button1.TextColor3=Color3.new(1,1,1)
Button1.TextScaled=true; Button1.Parent=Menu
Instance.new("UICorner", Button1).CornerRadius=UDim.new(0,8)

local Button2 = Instance.new("TextButton"); Button2.Name="Button2"
Button2.Size=UDim2.new(0,108,0,22); Button2.BackgroundColor3=Color3.new(0,0,0)
Button2.Text="Khoá vị trí nút bấm"
Button2.Font=Enum.Font.Kalam; Button2.TextColor3=Color3.new(1,1,1)
Button2.TextScaled=true; Button2.Parent=Menu
Instance.new("UICorner", Button2).CornerRadius=UDim.new(0,8)

local Button3 = Instance.new("TextButton"); Button3.Name="Button3"
Button3.Size=UDim2.new(0,108,0,22); Button3.BackgroundColor3=Color3.new(0,0,0)
Button3.Text="Thay đổi kích cỡ nút bấm"
Button3.Font=Enum.Font.Kalam; Button3.TextColor3=Color3.new(1,1,1)
Button3.TextScaled=true; Button3.Parent=Menu
Instance.new("UICorner", Button3).CornerRadius=UDim.new(0,8)

local BTP = Instance.new("TextButton"); BTP.Name="BTP"
BTP.Size=UDim2.new(0,40,0,40); BTP.Position=UDim2.new(0.642,0,0.504,0)
BTP.BackgroundColor3=Color3.new(0,0,0); BTP.Text="Teleport"
BTP.Font=Enum.Font.Kalam; BTP.TextColor3=Color3.new(1,1,1)
BTP.TextScaled=true; BTP.Parent=gui
Instance.new("UICorner", BTP).CornerRadius=UDim.new(1,0)

Toggle.MouseButton1Click:Connect(function()
    Menu.Visible = not Menu.Visible
end)

local dragEnabled, dragging = false, false
local dragStart, startPos
BTP.InputBegan:Connect(function(input)
    if dragEnabled and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
        dragging = true
        dragStart = input.Position
        startPos = BTP.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)
BTP.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        BTP.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                               startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

Button1.MouseButton1Click:Connect(function()
    dragEnabled = true
end)
Button2.MouseButton1Click:Connect(function()
    dragEnabled = false
end)
Button3.MouseButton1Click:Connect(function()
    if BTP.Size == UDim2.new(0,40,0,40) then
        BTP.Size = UDim2.new(0,50,0,50)
    elseif BTP.Size == UDim2.new(0,50,0,50) then
        BTP.Size = UDim2.new(0,38,0,38)
    else
        BTP.Size = UDim2.new(0,40,0,40)
    end
end)

local settings = {pos = BTP.Position, size = BTP.Size}

local part = workspace:FindFirstChild("Part") or workspace.Part 
local teleported = false
local lastCFrame
BTP.MouseButton1Click:Connect(function()
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso")
    if hrp then
        if not teleported then
            lastCFrame = hrp.CFrame
            if part then
                player.Character:MoveTo(part.Position) 
            end
            teleported = true
        else
            hrp.CFrame = lastCFrame 
            teleported = false
        end
    end
end)

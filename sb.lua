local player=game.Players.LocalPlayer
local mouse=player:GetMouse()
local char=player.Character or player.CharacterAdded:Wait()
local hrp=char:WaitForChild("HumanoidRootPart")

local part=Instance.new("Part")
part.Name="TP_Part"
part.Parent=workspace
part.Transparency=0.7
part.Size=Vector3.new(900,1,900)
part.Anchored=true
part.CFrame=CFrame.new(9000,900,0)

local gui=Instance.new("ScreenGui")
gui.Name="TPGui"
gui.Parent=player:WaitForChild("PlayerGui")

local Toggle=Instance.new("TextButton")
Toggle.Name="Toggle"
Toggle.Size=UDim2.new(0,77,0,19)
Toggle.Position=UDim2.new(0.508,0,0.023,0)
Toggle.BackgroundColor3=Color3.new(0,0,0)
Toggle.Text="Menu"
Toggle.Font=Enum.Font.Kalam
Toggle.TextColor3=Color3.new(1,1,1)
Toggle.TextScaled=true
Toggle.Parent=gui

local c1=Instance.new("UICorner")
c1.CornerRadius=UDim.new(0,8)
c1.Parent=Toggle

local Menu=Instance.new("Frame")
Menu.Name="Menu"
Menu.Size=UDim2.new(0,171,0,87)
Menu.Position=UDim2.new(0.111,0,0.41,0)
Menu.BackgroundColor3=Color3.new(0,0,0)
Menu.BackgroundTransparency=0.2
Menu.Visible=false
Menu.Parent=gui

local c2=Instance.new("UICorner")
c2.CornerRadius=UDim.new(0,8)
c2.Parent=Menu

local Title=Instance.new("Frame")
Title.Name="Title"
Title.Size=UDim2.new(0,108,0,13)
Title.Position=UDim2.new(0.113,0,0.039,0)
Title.BackgroundColor3=Color3.new(0,0,0)
Title.Parent=Menu

local c3=Instance.new("UICorner")
c3.CornerRadius=UDim.new(0,8)
c3.Parent=Title

local TitleText=Instance.new("TextLabel")
TitleText.BackgroundTransparency=1
TitleText.Size=UDim2.new(1,0,1,0)
TitleText.Text="Settings"
TitleText.TextColor3=Color3.new(1,1,1)
TitleText.Font=Enum.Font.Kalam
TitleText.TextScaled=true
TitleText.Parent=Title

local function createButton(name,text,pos)
	local b=Instance.new("TextButton")
	b.Name=name
	b.Size=UDim2.new(0,108,0,22)
	b.BackgroundColor3=Color3.new(0,0,0)
	b.Text=text
	b.Position=pos
	b.Font=Enum.Font.Kalam
	b.TextColor3=Color3.new(1,1,1)
	b.TextScaled=true
	b.Parent=Menu
	local c=Instance.new("UICorner")
	c.CornerRadius=UDim.new(0,8)
	c.Parent=b
	return b
end

local Button1=createButton("Button1","Di chuyển vị trí nút bấm", UDim2.new(0, 31, 0, 20))
local Button2=createButton("Button2","Khoá vị trí nút bấm",       UDim2.new(0, 31, 0, 45))
local Button3=createButton("Button3","Thay đổi kích cỡ nút bấm", UDim2.new(0, 31, 0, 70))

local BTP=Instance.new("TextButton")
BTP.Name="BTP"
BTP.Size=UDim2.new(0,40,0,40)
BTP.Position=UDim2.new(0.642,0,0.504,0)
BTP.BackgroundColor3=Color3.new(0,0,0)
BTP.Text="Teleport"
BTP.Font=Enum.Font.Kalam
BTP.TextColor3=Color3.new(1,1,1)
BTP.TextScaled=true
BTP.Parent=gui

local c4=Instance.new("UICorner")
c4.CornerRadius=UDim.new(1,0)
c4.Parent=BTP

local dragging=false
local dragInput,dragStart,startPos
local stateSize=player:GetAttribute("TP_Size") or "default"
local savedPos=player:GetAttribute("TP_Pos")
local backPos=nil

if savedPos then
	BTP.Position=savedPos
end

local function applySize()
	if stateSize=="min" then
		BTP.Size=UDim2.new(0,38,0,38)
	elseif stateSize=="max" then
		BTP.Size=UDim2.new(0,50,0,50)
	else
		BTP.Size=UDim2.new(0,40,0,40)
	end
end

applySize()

Toggle.MouseButton1Click:Connect(function()
	Menu.Visible=not Menu.Visible
end)

Button1.MouseButton1Click:Connect(function()
	dragging=true
end)

Button2.MouseButton1Click:Connect(function()
	dragging=false
	player:SetAttribute("TP_Pos",BTP.Position)
end)

Button3.MouseButton1Click:Connect(function()
	if stateSize=="default" then
		stateSize="min"
	elseif stateSize=="min" then
		stateSize="max"
	else
		stateSize="default"
	end
	player:SetAttribute("TP_Size",stateSize)
	applySize()
end)

local function updateDrag(input)
	local delta=input.Position-dragStart
	BTP.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+delta.X,startPos.Y.Scale,startPos.Y.Offset+delta.Y)
end

BTP.InputBegan:Connect(function(input)
	if input.UserInputType==Enum.UserInputType.MouseButton1 and dragging then
		dragStart=input.Position
		startPos=BTP.Position
		dragInput=input
	end
end)

BTP.InputChanged:Connect(function(input)
	if input==dragInput and dragging then
		updateDrag(input)
	end
end)

BTP.MouseButton1Click:Connect(function()
	if backPos then
		hrp.CFrame=backPos
		backPos=nil
		return
	end
	backPos=hrp.CFrame
	hrp.CFrame=part.CFrame+Vector3.new(0,3,0)
end)

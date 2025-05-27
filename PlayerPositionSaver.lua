local Players = game:GetService("Players")
local ServerStorage = game:GetService("ServerStorage")
local positionStorage = Instance.new("Folder")
positionStorage.Name = "SavedPositions"
positionStorage.Parent = ServerStorage

local function savePosition(player, positionName)
    if not player then return end
    local character = player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    local currentPosition = character.HumanoidRootPart.Position
    local playerFolder = positionStorage:FindFirstChild(player.UserId) or Instance.new("Folder")
    playerFolder.Name = tostring(player.UserId)
    playerFolder.Parent = positionStorage
    local positionValue = Instance.new("Vector3Value")
    positionValue.Name = positionName
    positionValue.Value = currentPosition
    positionValue.Parent = playerFolder
    
    player:SendNotification({
        Title = "Vị trí đã lưu",
        Text = "Đã lưu vị trí với tên: " .. positionName,
        Duration = 3
    })
end

local function returnToPosition(player, positionName)
    if not player then return end
    
    local character = player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    
    local playerFolder = positionStorage:FindFirstChild(player.UserId)
    if not playerFolder then
        player:SendNotification({
            Title = "Lỗi",
            Text = "Không tìm thấy vị trí nào đã lưu!",
            Duration = 3
        })
        return
    end
    
    local positionValue = playerFolder:FindFirstChild(positionName)
    if not positionValue then
        player:SendNotification({
            Title = "Lỗi",
            Text = "Không tìm thấy vị trí: " .. positionName,
            Duration = 3
        })
        return
    end
    character.HumanoidRootPart.CFrame = CFrame.new(positionValue.Value)
    
    player:SendNotification({
        Title = "Đã dịch chuyển",
        Text = "Đã quay lại vị trí: " .. positionName,
        Duration = 3
    })
end
local function clearAllPositions(player)
    if not player then return end
    local playerFolder = positionStorage:FindFirstChild(player.UserId)
    if playerFolder then
        playerFolder:Destroy()
        player:SendNotification({
            Title = "Xóa thành công",
            Text = "Đã xóa tất cả vị trí đã lưu!",
            Duration = 3
        })
    else
        player:SendNotification({
            Title = "Thông báo",
            Text = "Không có vị trí nào để xóa!",
            Duration = 3
        })
    end
end

Players.PlayerAdded:Connect(function(player)
    player.Chatted:Connect(function(message)
        local args = message:split(" ")
        local command = args[1]
        if command == "/save" and args[2] then
            savePosition(player, args[2])
        end
        if command == "/return" and args[2] then
            returnToPosition(player, args[2])
        end
        if command == "/clearpositions" then
            clearAllPositions(player)
        end
    end)
end)

Players.PlayerRemoving:Connect(function(player)
    local playerFolder = positionStorage:FindFirstChild(player.UserId)
    if playerFolder then
        playerFolder:Destroy()
    end
end)


--[[
Cách sử dụng trong game:
- nhập /save [tên_vị_trí] trong chat (ví dụ: /save home). Tên vị trí không được chứa khoảng trắng.
- quay lại vị trí: /return [tên_vị_trí] trong chat (ví dụ: /return home).
- xóa tất cả vị trí: /clearpositions trong chat để xóa tất cả vị trí đã lưu của bạn.
]]

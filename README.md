## T2F
```lua
local T2F = loadstring(game:HttpGet("https://raw.githubusercontent.com/haxer19/TienThanh/main/tp.lua"))()
local Tp = T2F.tp
-- local Tp2 = T2F.tp_v2
local Fly = T2F.fly
local pos = {
    getPos = T2F.getPos,
    save = T2F.save,
    back = T2F.back,
    list = T2F.list
}

--[[
teleport: Tp(path) 
fly: Fly(path)


Position Save :

pos.save("vt1")
pos.back("vt1")
pos.list()
]] 
-- 

```

---

### gui
```lua
Tabs.MainTab:TextBox({
    Title = "Tên vị trí",
    Placeholder = "Nhập tên vị trí (VD: vt1)",
    Callback = function(value)
        _G.positionName = value
    end
})

Tabs.MainTab:Button({
    Title = "Lưu Vị Trí",
    Callback = function()
        if _G.positionName and _G.positionName ~= "" then
            pos.save(_G.positionName)
        else
            warn("Vui lòng nhập tên vị trí!")
        end
    end
})

Tabs.MainTab:Dropdown({
    Title = "Chọn Vị Trí để Quay Lại",
    Values = {},
    Callback = function(option)
        pos.back(option)
    end
})

Tabs.MainTab:Button({
    Title = "Cập Nhật Danh Sách",
    Callback = function()
        local positionNames = {}
        for name, _ in pairs(pos.getPos or {}) do
            table.insert(positionNames, name)
        end
        Tabs.MainTab:UpdateDropdown("Chọn Vị Trí để Quay Lại", positionNames)
        pos.list()
    end
})

Tabs.MainTab:Button({
    Title = "Xóa Tất Cả Vị Trí",
    Callback = function()
        pos.clear()
        Tabs.MainTab:UpdateDropdown("Chọn Vị Trí để Quay Lại", {})
    end
})
```

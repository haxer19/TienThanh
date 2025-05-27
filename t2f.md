## T2F
```lua
local T2F = loadstring(game:HttpGet("https://raw.githubusercontent.com/haxer19/TienThanh/main/T2F.lua"))()
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

### location
```lua
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local T2F = loadstring(game:HttpGet("https://raw.githubusercontent.com/haxer19/TienThanh/main/T2F.lua"))()

local Window = WindUI:CreateWindow({
    Title = "PosSaver",
    Icon = "",
    Author = "Tien Thanh",
    Folder = "ABC",
    Size = UDim2.fromOffset(540, 340),
    Transparent = true,
    Theme = "Dark",
    SideBarWidth = 200,
    HasOutline = true,
})

local Tabs = {
    Main = Window:Tab({ Title = "Main", Icon = "user" }),
}

local currentName = ""

Tabs.Main:Input({
    Title = "Name",
    Value = "",
    Placeholder = "Enter Name",
    Callback = function(input)
        currentName = input
    end
})

local posDropdown

Tabs.Main:Button({
    Title = "Name Save",
    Callback = function()
        if currentName ~= "" then
            T2F.save(currentName)
            local positions = T2F.getPos()
            local posNames = {}
            for name, _ in pairs(positions) do
                table.insert(posNames, name)
            end
            posDropdown:Refresh(posNames)
        end
    end
})

posDropdown = Tabs.Main:Dropdown({
    Title = "List",
    Values = {},
    Value = "",
    Callback = function(option)
        if option ~= "" then
            T2F.back(option)
        end
    end
})

Tabs.Main:Button({
    Title = "Del All",
    Callback = function()
        T2F.clear()
        posDropdown:Refresh({""})
    end
})

local function updateDropdown()
    local positions = T2F.getPos()
    local posNames = {}
    for name, _ in pairs(positions) do
        table.insert(posNames, name)
    end
    posDropdown:Refresh(posNames)
end

updateDropdown()
```

package.path = package.path .. ";../?.lua"
require("unit_scoped_functions")

function GetScriptDirectory()
    return ".."
end

function GetItemCost(item)
    local itemsCost = {
        ["item_tango"] = 150,
        ["item_flask"] = 110
    };

    return itemsCost[item]
end

local TestBot = Bot:new()

function GetBot()
    return TestBot
end

local TestUnit = Unit:new()

function GetTower(team, tower)
    return TestUnit
end

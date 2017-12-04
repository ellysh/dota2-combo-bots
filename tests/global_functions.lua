package.path = package.path .. ";../?.lua"
require("unit_scoped_functions")

function GetScriptDirectory()
    return ".."
end

function GetItemCost(item)
    local ItemsCost = {
        ["item_tango"] = 150,
        ["item_flask"] = 110
    };

    return ItemsCost[item]
end

function GetBot()
    return TestBot
end

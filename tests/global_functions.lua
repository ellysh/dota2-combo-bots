package.path = package.path .. ";../?.lua"
require("unit_scoped_functions")

function GetItemCost(item)
    local ItemsCost = {
        ["item_tango"] = 150
    };

    return ItemsCost[item]
end

function GetBot()
    return TestBot
end

local item_purchase_utility = require(
    GetScriptDirectory() .."/utility/item_purchase_utility")

local itemsToBuy = {
    -- Starting items
    "item_courier",
    "item_tango",
    "item_clarity",
    "item_branches",
    "item_branches",

    -- Core items
    -- Arcane boots
    "item_boots",
    "item_energy_booster",

    -- Magic wand
    "item_magic_stick",
    "item_enchanted_mango",

    -- Force Stuff
    "item_staff_of_wizardry",
    "item_ring_of_health",
    "item_recipe_force_staff",

    -- Aghanim Scepter
    "item_point_booster",
    "item_staff_of_wizardry",
    "item_ogre_axe",
    "item_blade_of_alacrity",

    -- Extension Items
    -- Refresher Orb
    "item_ring_of_health",
    "item_void_stone",
    "item_ring_of_health",
    "item_void_stone",
    "item_recipe_refresher",

    -- Eul scepter
    "item_staff_of_wizardry",
    "item_void_stone",
    "item_wind_lace",
    "item_recipe_cyclone"
}

function ItemPurchaseThink()
    item_purchase_utility.PurchaseItem(itemsToBuy)
end

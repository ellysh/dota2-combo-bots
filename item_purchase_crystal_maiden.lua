local item_purchase_utility = require(
    GetScriptDirectory() .."/utility/item_purchase_utility")

local itemsToBuy = {
    -- Starting items
    "item_tango",
    "item_clarity",
    "item_branches",
    "item_branches",

    -- Core items
    -- Tranquil boots
    "item_wind_lace",
    "item_boots",
    "item_ring_of_regen",

    "item_ward_observer",

    -- Magic wand
    "item_magic_stick",
    "item_enchanted_mango",

    -- Glimmer cape
    "item_cloak",
    "item_shadow_amulet",

    "item_ward_observer",

    -- Extension Items
    -- Force Stuff
    "item_staff_of_wizardry",
    "item_ring_of_health",
    "item_recipe_force_staff",

    -- Blink Dagger
    "item_blink",

    -- Lotus Orb
    --"item_ring_of_health",
    --"item_void_stone",
    --"item_platemail",
    --"item_energy_booster"

    -- Aghanim Scepter
    "item_point_booster",
    "item_staff_of_wizardry",
    "item_ogre_axe",
    "item_blade_of_alacrity"
};

function ItemPurchaseThink()
    item_purchase_utility.PurchaseItem(itemsToBuy)
end

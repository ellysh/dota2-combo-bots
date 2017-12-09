local item_purchase_utility = require(
    GetScriptDirectory() .."/utility/item_purchase_utility")

local itemsToBuy = {
    -- Starting items
    "item_tango",
    "item_null_talisman",

    -- Core items
    -- Arcane boots
    "item_boots",
    "item_energy_booster",

    -- Hand of Midas
    "item_gloves",
    "item_recipe_hand_of_midas",

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

    -- Octarine core
    "item_mystic_staff",
    "item_recipe_soul_booster",

    -- Force Stuff
    "item_staff_of_wizardry",
    "item_ring_of_health",
    "item_recipe_force_staff",

    -- Guardian Greaves
    "item_headdress",
    "item_buckler",
    "item_recipe_mekansm",
    "item_recipe_guardian_greaves"
};

function ItemPurchaseThink()
    item_purchase_utility.PurchaseItem(itemsToBuy)
end

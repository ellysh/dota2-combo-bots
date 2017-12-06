local item_purchase_utility = require(
    GetScriptDirectory() .."/utility/item_purchase_utility")

local itemsToBuy = {
    "item_tango",
    "item_clarity",
    "item_branches",
    "item_branches",
    "item_boots",
    "item_magic_stick",
    "item_enchanted_mango",
    "item_energy_booster",
    "item_void_stone",
    "item_energy_booster",
    "item_recipe_aether_lens",
    "item_blink",
    "item_staff_of_wizardry",
    "item_void_stone",
    "item_recipe_cyclone",
    "item_wind_lace",
    "item_point_booster",
    "item_staff_of_wizardry",
    "item_ogre_axe",
    "item_blade_of_alacrity",
    "item_ring_of_health",
    "item_void_stone",
    "item_ring_of_health",
    "item_void_stone",
    "item_recipe_refresher",
};

function ItemPurchaseThink()
    item_purchase_utility.PurchaseItem(itemsToBuy)
end

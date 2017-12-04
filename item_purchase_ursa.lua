package.path = package.path .. ";../?.lua"
local item_purchase_utility = require("item_purchase_utility")

local itemsToBuy = {
    "item_tango",
    "item_flask",
    "item_stout_shield",
    "item_branches",
    "item_branches",
    "item_boots",
    "item_orb_of_venom",
    "item_blades_of_attack",
    "item_blades_of_attack",
    "item_magic_stick",
    "item_enchanted_mango",

    "item_ring_of_protection",
    "item_sobi_mask",
    "item_lifesteal",
    "item_ring_of_regen",
    "item_recipe_headdress",
    "item_branches",

    "item_blink",

    "item_javelin",
    "item_belt_of_strength",
    "item_recipe_basher",

    "item_point_booster",
    "item_staff_of_wizardry",
    "item_ogre_axe",
    "item_blade_of_alacrity",

    "item_mithril_hammer",
    "item_ogre_axe",
    "item_recipe_black_king_bar",

    "item_ring_of_health",
    "item_vitality_booster",
    "item_stout_shield",
    "item_recipe_abyssal_blade",
};

function ItemPurchaseThink()
    item_purchase_utility.PurchaseItem(itemsToBuy)
end

local item_purchase_utility = require(
    GetScriptDirectory() .."/utility/item_purchase_utility")

local itemsToBuy = {
    "item_flask",
    "item_tango",
    "item_branches",
    "item_branches",
    "item_stout_shield",
    "item_orb_of_venom",

    "item_magic_stick",
    "item_enchanted_mango",

    "item_boots",
    "item_blades_of_attack",
    "item_blades_of_attack",

    "item_slippers",
    "item_circlet",
    "item_recipe_wraith_band",
    "item_ring_of_protection",
    "item_sobi_mask",

    "item_blade_of_alacrity",
    "item_boots_of_elves",
    "item_recipe_yasha",

    "item_ultimate_orb",
    "item_recipe_manta",

    "item_blade_of_alacrity",
    "item_blade_of_alacrity",
    "item_robe",
    "item_recipe_diffusal_blade",

    "item_point_booster",
    "item_staff_of_wizardry",
    "item_ogre_axe",
    "item_blade_of_alacrity",

    "item_javelin",
    "item_belt_of_strength",
    "item_recipe_basher",

    "item_ring_of_health",
    "item_vitality_booster",
    "item_stout_shield",

    "item_recipe_abyssal_blade",

    "item_quarterstaff",
    "item_eagle",
    "item_talisman_of_evasion",
};

function ItemPurchaseThink()
    item_purchase_utility.PurchaseItem(itemsToBuy)
end

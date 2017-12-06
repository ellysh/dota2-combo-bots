local item_purchase_utility = require(
    GetScriptDirectory() .."/utility/item_purchase_utility")

local itemsToBuy = {
    "item_tango",
    "item_stout_shield",
    "item_branches",
    "item_branches",
    "item_boots",
    "item_magic_stick",
    "item_enchanted_mango",
    "item_belt_of_strength",
    "item_gloves",

    "item_broadsword",
    "item_robe",
    "item_chainmail",

    "item_belt_of_strength",
    "item_ogre_axe",
    "item_recipe_sange",
    "item_talisman_of_evasion",

    "item_platemail",
    "item_chainmail",
    "item_hyperstone",
    "item_recipe_assault",

    "item_point_booster",
    "item_staff_of_wizardry",
    "item_ogre_axe",
    "item_blade_of_alacrity",

    "item_vitality_booster",
    "item_vitality_booster",
    "item_reaver",
};

function ItemPurchaseThink()
    item_purchase_utility.PurchaseItem(itemsToBuy)
end

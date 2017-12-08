local item_purchase_utility = require(
    GetScriptDirectory() .."/utility/item_purchase_utility")

local itemsToBuy = {
    -- Starting items
    "item_flask",
    "item_tango",
    "item_branches",
    "item_branches",
    "item_stout_shield",
    "item_clarity",

    -- Early game
    "item_boots",
    "item_wraith_band",
    "item_ring_of_basilius",

    -- Core items
    -- Phase boots
    "item_blades_of_attack",
    "item_blades_of_attack",

    -- Magic wand
    "item_magic_stick",
    "item_enchanted_mango",

    -- Manta Style
    "item_blade_of_alacrity",
    "item_boots_of_elves",
    "item_recipe_yasha",
    "item_ultimate_orb",
    "item_recipe_manta",

    -- Diffusial Blade
    "item_blade_of_alacrity",
    "item_blade_of_alacrity",
    "item_robe",
    "item_recipe_diffusal_blade",

    -- Extension Items
    -- Butterfly
    "item_quarterstaff",
    "item_eagle",
    "item_talisman_of_evasion",

    -- Abyssal Blade
    "item_javelin",
    "item_belt_of_strength",
    "item_recipe_basher",

    "item_ring_of_health",
    "item_vitality_booster",
    "item_stout_shield",

    "item_recipe_abyssal_blade"
};

function ItemPurchaseThink()
    item_purchase_utility.PurchaseItem(itemsToBuy)
end

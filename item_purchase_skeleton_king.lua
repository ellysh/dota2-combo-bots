local item_purchase_utility = require(
    GetScriptDirectory() .."/utility/item_purchase_utility")

local itemsToBuy = {
    -- Starting items
    "item_tango",
    "item_flask",
    "item_stout_shield",
    "item_branches",
    "item_enchanted_mango",

    -- Early game
    "item_boots",

    -- Magic wand
    "item_magic_stick",
    "item_branches",

    -- Core
    -- Power Treads
    "item_belt_of_strength",
    "item_gloves",

    -- Amulet of Mordiggian
    "item_helm_of_iron_will",
    "item_gloves",
    "item_blades_of_attack",
    "item_recipe_armlet",

    -- Blink Dagger
    "item_blink",

    -- Radiance
    "item_relic",
    "item_recipe_radiance",

    -- Extension Items
    -- Assault Cuirass
    "item_platemail",
    "item_hyperstone",
    "item_chainmail",
    "item_recipe_assault",

    -- Mjollnir
    "item_mithril_hammer",
    "item_gloves",
    "item_recipe_maelstrom",

    "item_hyperstone",

    "item_recipe_mjollnir"
};

function ItemPurchaseThink()
    item_purchase_utility.PurchaseItem(itemsToBuy)
end

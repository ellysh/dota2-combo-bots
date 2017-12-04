local tableItemsToBuy = {
    "item_tango",
    "item_clarity",
    "item_branches",
    "item_branches",
    "item_wind_lace",
    "item_boots",
    "item_magic_stick",
    "item_enchanted_mango",
    "item_wind_lace",
    "item_ring_of_regen",
    "item_cloak",
    "item_shadow_amulet",
    "item_staff_of_wizardry",
    "item_void_stone",
    "item_recipe_cyclone",
    "item_point_booster",
    "item_staff_of_wizardry",
    "item_ogre_axe",
    "item_blade_of_alacrity",
    "item_mithril_hammer",
    "item_ogre_axe",
    "item_recipe_black_king_bar",
    "item_mystic_staff",
    "item_ultimate_orb",
    "item_void_stone",
};


----------------------------------------------------------------------------------------------------

function ItemPurchaseThink()

    local npcBot = GetBot();

    if ( #tableItemsToBuy == 0 )
    then
        npcBot:SetNextItemPurchaseValue( 0 );
        return;
    end

    local sNextItem = tableItemsToBuy[1];

    npcBot:SetNextItemPurchaseValue( GetItemCost( sNextItem ) );

    if ( npcBot:GetGold() >= GetItemCost( sNextItem ) )
    then
        npcBot:ActionImmediate_PurchaseItem( sNextItem );
        table.remove( tableItemsToBuy, 1 );
    end

end

----------------------------------------------------------------------------------------------------

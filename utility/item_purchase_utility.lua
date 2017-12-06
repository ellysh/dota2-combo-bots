local M = {}

function M.PurchaseItem(itemsToBuy)
  local npcBot = GetBot();

  if ( #itemsToBuy == 0 )
  then
    npcBot:SetNextItemPurchaseValue( 0 );
    return;
  end

  local sNextItem = itemsToBuy[1];

  npcBot:SetNextItemPurchaseValue( GetItemCost( sNextItem ) );

  if ( npcBot:GetGold() >= GetItemCost( sNextItem ) )
  then
    npcBot:ActionImmediate_PurchaseItem( sNextItem );
    table.remove( itemsToBuy, 1 );
  end
end

return M

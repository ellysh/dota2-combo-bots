local logger = require(
    GetScriptDirectory() .."/utility/logger")

local M = {}

local function IsTpScrollPresent(npcBot)
  local tpScroll = npcBot:FindItemSlot("item_tpscroll");

  return tpScroll ~= -1;
end

local function PurchaseTpScroll(npcBot)
  if IsTpScrollPresent(npcBot) then return end

  if (npcBot:GetGold() >= GetItemCost("item_tpscroll")) then
    npcBot:ActionImmediate_PurchaseItem("item_tpscroll");
  end
end

function M.PurchaseItem(itemsToBuy)
  local npcBot = GetBot();

  PurchaseTpScroll(npcBot)

  if (#itemsToBuy == 0) then
    return;
  end

  local nextItem = itemsToBuy[1];

  if (npcBot:GetGold() >= GetItemCost(nextItem)) then
    logger.Print(npcBot:GetUnitName() .. " bought " .. nextItem);
    npcBot:ActionImmediate_PurchaseItem(nextItem);
    table.remove(itemsToBuy, 1);
  end
end

return M

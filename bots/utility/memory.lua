local M = {}

-- Format of this list:
-- { hero_name = {ITEM_TO_BUY = "item_name", ITEM_TO_SELL = item_handle},
-- ...
-- }

PURCHASE_LIST = {}

function M.GetItemToSell(bot)
  if PURCHASE_LIST == nil or PURCHASE_LIST[bot:GetUnitName()] == nil then
    return nil
  end

  return PURCHASE_LIST[bot:GetUnitName()].ITEM_TO_SELL
end

function M.GetItemToBuy(bot)
  if PURCHASE_LIST == nil or PURCHASE_LIST[bot:GetUnitName()] == nil then
    return nil
  end

  return PURCHASE_LIST[bot:GetUnitName()].ITEM_TO_BUY
end

function M.SetItemToSell(bot, item)
  if PURCHASE_LIST == nil or PURCHASE_LIST[bot:GetUnitName()] == nil then
    PURCHASE_LIST[bot:GetUnitName()] = {}
  end

  PURCHASE_LIST[bot:GetUnitName()]["ITEM_TO_SELL"] = item
end

function M.SetItemToBuy(bot, item)
  if PURCHASE_LIST == nil or PURCHASE_LIST[bot:GetUnitName()] == nil then
    PURCHASE_LIST[bot:GetUnitName()] = {}
  end

  PURCHASE_LIST[bot:GetUnitName()]["ITEM_TO_BUY"] = item
end

return M

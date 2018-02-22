local constants = require(
  GetScriptDirectory() .."/utility/constants")

local M = {}

function M.PickUpItem()
  local items = GetDroppedItemList()

  if items == nil or #items == 0 then
    return end

  local bot = GetBot()

  for _, item in pairs(items) do
    if constants.MIN_HERO_DISTANCE_FROM_ITEM
       < GetUnitToLocationDistance(bot, item.location) then

      bot:Action_MoveToLocation(item.location)
    else
      bot:Action_PickUpItem(item.item)
    end
  end
end

return M

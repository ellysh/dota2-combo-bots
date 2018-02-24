local constants = require(
  GetScriptDirectory() .."/utility/constants")

local functions = require(
  GetScriptDirectory() .."/utility/functions")

local M = {}

function M.PickUpItem()
  local bot = GetBot()

  if functions.IsBotInFightingMode(bot)
     or functions.IsBotCasting(bot)
     or functions.IsInventoryFull(bot) then
    return end

  local items = GetDroppedItemList()

  if items == nil or #items == 0 then
    return end

  for _, item in pairs(items) do
    local distance = GetUnitToLocationDistance(bot, item.location)

    if constants.MAX_HERO_DISTANCE_FROM_ITEM < distance then
      do goto continue end
    end

    if constants.MIN_HERO_DISTANCE_FROM_ITEM < distance then
      bot:Action_MoveToLocation(item.location)
    else
      bot:Action_PickUpItem(item.item)
    end
    ::continue::
  end
end

return M

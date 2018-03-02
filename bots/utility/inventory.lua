local constants = require(
  GetScriptDirectory() .."/utility/constants")

local functions = require(
  GetScriptDirectory() .."/utility/functions")

local M = {}

local function IsRoshanMode(bot)
  return bot:GetActiveMode() == BOT_MODE_ROSHAN
end

local function FreeInventorySlot(bot)
  if functions.GetItemSlotsCount(bot, 0, 5) < 6 then
    return end

  local empty_index = -1
  for i = 6, 8, 1 do
    local item = bot:GetItemInSlot(i)
    if item == nil or item:GetName() == "nil" then
      empty_index = i
      break
    end
  end

  if empty_index ~= -1 then
    -- TODO: We always swap an item in the slot 0 to backpack. We should
    -- find the cehapest item instead.
    bot:ActionImmediate_SwapItems(0, empty_index)
  end
end

local function IsItemOfAlly(item)
  local owner = item.owner

  if owner == nil or owner:GetTeam() ~= GetTeam() then
    return false end

  return owner:IsAlive()
         and GetUnitToLocationDistance(owner, item.location)
             <= constants.MIN_HERO_DISTANCE_FROM_ITEM
end

function M.PickUpItem()
  local bot = GetBot()

  if (not functions.IsUnitInRoshpit(bot)
      and functions.IsBotInFightingMode(bot))
     or functions.IsBotCasting(bot)
     or functions.IsInventoryFull(bot) then
    return end

  local items = GetDroppedItemList()

  if items == nil or #items == 0 then
    return end

  for _, item in pairs(items) do
    local distance = GetUnitToLocationDistance(bot, item.location)

    if constants.MAX_HERO_DISTANCE_FROM_ITEM < distance
       or IsItemOfAlly(item) then
      do goto continue end
    end

    if constants.MIN_HERO_DISTANCE_FROM_ITEM < distance then
      bot:Action_MoveToLocation(item.location)
    else
      -- We cannot pickup the aegis into backpack
      if item.item:GetName() == "item_aegis" then
        FreeInventorySlot(bot)
      end
      bot:Action_PickUpItem(item.item)
    end
    ::continue::
  end
end

-- Provide an access to local functions for unit tests only
M.test_FreeInventorySlot = FreeInventorySlot

return M

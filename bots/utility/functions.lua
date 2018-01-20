local constants = require(
  GetScriptDirectory() .."/utility/constants")

local M = {}

-- This function iterates over the table in a sorted order.
-- It was taken from here:
-- https://stackoverflow.com/questions/15706270/sort-a-table-in-lua

function M.spairs(t, order)
    -- collect the keys
    local keys = {}
    for k in pairs(t) do keys[#keys+1] = k end

    -- if order function given, sort by it by passing the table
    -- and keys a, b, otherwise just sort the keys
    if order then
        table.sort(keys, function(a,b) return order(t, a, b) end)
    else
        table.sort(keys)
    end

    -- return the iterator function
    local i = 0
    return function()
        i = i + 1
        if keys[i] then
            return keys[i], t[keys[i]]
        end
    end
end

-- Indexes in resulting array do not match to slot indexes.
-- You should shift them -1 to match the slot indexes.
function M.GetItems(unit, slot_numbers)
  local item_list = {}
  local items_number = 0

  for i = 0, slot_numbers, 1 do
    local item = unit:GetItemInSlot(i)
    if item ~= nil and item:GetName() ~= "nil" then
      items_number = items_number + 1
      table.insert(item_list, item:GetName())
    else
      table.insert(item_list, "nil")
    end
  end

  return items_number, item_list
end

local function GetItemSlotsCount(bot)
  local result, _ = M.GetItems(bot, constants.INVENTORY_MAX_INDEX)
  return result
end

function M.IsInventoryFull(bot)
  return constants.INVENTORY_SIZE <= GetItemSlotsCount(bot)
end

function M.GetElementIndexInList(list, element)
  if list == nil then
    return nil end

  -- We should sort by keys. Otherwise, elements have a random order.

  for i, e in M.spairs(list) do
    if e == element then
      return i end
  end
  return -1
end

function M.IsElementInList(list, index)
  return M.GetElementIndexInList(list, index) ~= -1
end

function M.IsIntersectionOfLists(list1, list2)
  for _, e in pairs(list1) do
    if M.IsElementInList(list2, e) then
      return true end
  end
  return false
end

function M.IsBotBusy(bot)
  return bot:IsChanneling()
        or bot:IsUsingAbility()
        or bot:IsCastingAbility()
end

-- This function was taken from the Ranked Matchmaking AI project:
-- https://github.com/adamqqqplay/dota2ai

local function IsFlagSet(mask, flag)
  if flag == 0 or mask == 0 then
    return false end

  return ((mask / flag)) % 2 >= 1
end

function M.GetAbilityTargetType(ability)
  -- This function returns the type of target itself:
  -- ABILITY_NO_TARGET, ABILITY_UNIT_TARGET or ABILITY_LOCATION_TARGET.
  -- The API GetTargetType funtion returns the type of a target unit.

  if ability == nil then
    return nil end

  local behavior = ability:GetBehavior()

  if IsFlagSet(behavior, ABILITY_BEHAVIOR_NO_TARGET) then
    return constants.ABILITY_NO_TARGET
  end

  if IsFlagSet(behavior, ABILITY_BEHAVIOR_POINT) then
    return constants.ABILITY_LOCATION_TARGET
  end

  return constants.ABILITY_UNIT_TARGET
end

function M.ternary(condition, a, b)
  if condition then
    return a
  else
    return b
  end
end

function M.GetRandomTrue(probability)
  return RandomFloat(0.0, 1.0) < probability
end

function M.GetInventoryItems(bot)
  local _, result = M.GetItems(
    bot,
    constants.INVENTORY_MAX_INDEX)

  return result
end

function M.GetElementWith(list, compare_function, validate_function)

  for _, element in M.spairs(list, compare_function) do
    if validate_function == nil or validate_function(element) then
      return element
    end
  end

  return nil
end

function M.GetNumberOfElementsWith(list, check_function)
  local result = 0

  for _, element in pairs(list) do
    if check_function(element) then
      result = result + 1
    end
  end

  return result
end

function M.GetKeyWith(list, compare_function, validate_function)

  for key, element in M.spairs(list, compare_function) do
    if validate_function == nil or validate_function(key, element) then
      return key
    end
  end

  return nil
end

function M.GetUnitHealthLevel(unit)
  return unit:GetHealth() / unit:GetMaxHealth()
end

function M.IsUnitHaveItems(unit, items)
  local inventory = M.GetInventoryItems(unit)

  return M.IsIntersectionOfLists(inventory, items)
end


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

-- Provide an access to local functions for unit tests only
M.test_GetItemSlotsCount = GetItemSlotsCount
M.test_IsFlagSet = IsFlagSet

return M
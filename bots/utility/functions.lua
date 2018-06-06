local constants = require(
  GetScriptDirectory() .."/utility/constants")

local heroes = require(
  GetScriptDirectory() .."/database/heroes")

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
    if order ~= nil then
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

-- You should use this function for any table without numeric indexes

function M.GetTableSize(table)
  local count = 0

  for _ in pairs(table) do count = count + 1 end
  return count
end

function M.GetItem(unit, item_name, slot_type)
  local slot = unit:FindItemSlot(item_name)

  if slot_type ~= nil
     and unit:GetItemSlotType(slot) ~= slot_type then
     return nil end

  return unit:GetItemInSlot(slot)
end

-- Indexes in resulting array do not match to slot indexes.
-- You should shift them -1 to match the slot indexes.

function M.GetItems(unit, start_index, end_index, get_function)
  local item_list = {}
  local items_number = 0

  for i = start_index, end_index, 1 do
    local item = unit:GetItemInSlot(i)
    if item ~= nil and item:GetName() ~= "nil" then
      items_number = items_number + 1
      table.insert(item_list, get_function(item))
    else
      table.insert(item_list, "nil")
    end
  end

  return items_number, item_list
end

function M.GetItemSlotsCount(unit, start_index, end_index)
  local result, _ = M.GetItems(
    unit,
    start_index,
    end_index,
    function(item) return item:GetName() end)

  return result
end

function M.IsInventoryFull(unit)
  return constants.INVENTORY_SIZE <=
           M.GetItemSlotsCount(
             unit,
             constants.INVENTORY_START_INDEX,
             constants.INVENTORY_END_INDEX)
end

function M.IsStashFull(unit)
  return constants.STASH_SIZE <=
           M.GetItemSlotsCount(
             unit,
             constants.STASH_START_INDEX,
             constants.STASH_END_INDEX)
end

-- This function compares two Lua table objects. It was taken from here:
-- https://web.archive.org/web/20131225070434/http://snippets.luacode.org/snippets/Deep_Comparison_of_Two_Values_3

local function deepcompare(t1, t2, ignore_mt)
  local ty1 = type(t1)
  local ty2 = type(t2)
  if ty1 ~= ty2 then return false end
  -- non-table types can be directly compared
  if ty1 ~= 'table' and ty2 ~= 'table' then return t1 == t2 end
  -- as well as tables which have the metamethod __eq
  local mt = getmetatable(t1)
  if not ignore_mt and mt and mt.__eq then return t1 == t2 end
  for k1,v1 in pairs(t1) do
    local v2 = t2[k1]
    if v2 == nil or not deepcompare(v1,v2) then return false end
  end
  for k2,v2 in pairs(t2) do
    local v1 = t1[k2]
    if v1 == nil or not deepcompare(v1,v2) then return false end
  end
  return true
end

function M.GetElementIndexInList(list, element, is_deep)
  if list == nil then
    return -1 end

  -- We should sort by keys. Otherwise, elements have a random order.

  for i, e in M.spairs(list) do
    if (not is_deep and e == element)
       or (is_deep and deepcompare(e, element, true)) then
      return i end
  end
  return -1
end

function M.IsElementInList(list, element, is_deep)
  return M.GetElementIndexInList(list, element, is_deep) ~= -1
end

function M.IsIntersectionOfLists(list1, list2, is_deep)
  for _, e in pairs(list1) do
    if e ~= "nil" and M.IsElementInList(list2, e, is_deep) then
      return true end
  end
  return false
end

function M.ComplementOfLists(list1, list2, is_deep)
  local result = {}

  for key, element in pairs(list1) do
    if not M.IsElementInList(list2, element, is_deep) then
      table.insert(result, element)
    end
  end
  return result
end

function M.IsBotCasting(bot)
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

function M.PercentToDesire(percent)
  return percent / 100
end

function M.GetInventoryItems(bot)
  local _, result = M.GetItems(
    bot,
    constants.INVENTORY_START_INDEX,
    constants.INVENTORY_END_INDEX,
    function(item) return item:GetName() end)

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

function M.GetKeyAndElementWith(list, compare_function, validate_function)

  for key, element in M.spairs(list, compare_function) do
    if validate_function == nil or validate_function(key, element) then
      return key, element
    end
  end

  return nil, nil
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

function M.DoWithKeysAndElements(list, do_function)
  for key, element in pairs(list) do
    do_function(key, element)
  end
end

function M.GetRate(a, b)
  return a / b
end

function M.IsUnitHaveItems(unit, items)
  local inventory = M.GetInventoryItems(unit)

  return M.IsIntersectionOfLists(inventory, items)
end

function M.GetHeroPositions(hero)
  if heroes.HEROES[hero] ~= nil then
    return heroes.HEROES[hero].positions
  else
    -- TODO: We choose the positions 1 and 2 for unknown player's hero
    return {1, 2}
  end
end

function M.IsBotModeMatch(bot, bot_mode)
  if bot_mode == "any_mode" or bot_mode == "team_fight" then
    return true
  end

  local active_mode = bot:GetActiveMode()

  -- Actual bot modes are the constant digits but the
  -- shortcuted modes are strings.

  if bot_mode == "BOT_MODE_PUSH_TOWER" then
    return active_mode == BOT_MODE_PUSH_TOWER_TOP
           or active_mode == BOT_MODE_PUSH_TOWER_MID
           or active_mode == BOT_MODE_PUSH_TOWER_BOT
  end

  if bot_mode == "BOT_MODE_DEFEND_TOWER" then
    return active_mode == BOT_MODE_DEFEND_TOWER_TOP
           or active_mode == BOT_MODE_DEFEND_TOWER_MID
           or active_mode == BOT_MODE_DEFEND_TOWER_BOT
  end

  return active_mode == constants.BOT_MODES[bot_mode]
end

function M.IsBotInFightingMode(bot)
  local mode = bot:GetActiveMode()

  return mode == BOT_MODE_ATTACK
         or mode == BOT_MODE_PUSH_TOWER_TOP
         or mode == BOT_MODE_PUSH_TOWER_MID
         or mode == BOT_MODE_PUSH_TOWER_BOT
         or mode == BOT_MODE_DEFEND_ALLY
         or mode == BOT_MODE_RETREAT
         or mode == BOT_MODE_ROSHAN
         or mode == BOT_MODE_DEFEND_TOWER_TOP
         or mode == BOT_MODE_DEFEND_TOWER_MID
         or mode == BOT_MODE_DEFEND_TOWER_BOT
         or mode == BOT_MODE_EVASIVE_MANEUVERS
         or bot:WasRecentlyDamagedByAnyHero(3.0)
end

function M.DistanceToDesire(distance, max_distance, base_desire)
  return (1 - (distance / max_distance)) + base_desire
end

function M.GetNearestLocation(bot, locations_list)
  return M.GetElementWith(
    locations_list,
    function(t, a, b)
      return GetUnitToLocationDistance(bot, t[a])
             < GetUnitToLocationDistance(bot, t[b])
    end)
end

function M.GetNormalizedDesire(desire, max_desire)
  return M.ternary(max_desire < desire, max_desire, desire)
end

-- This function is taken from here:
-- https://stackoverflow.com/a/15278426
-- Result will be stored in the t1 table. The return value is
-- requried for tests.

function M.TableConcat(t1, t2)
  for i = 1, #t2 do
    t1[#t1+1] = t2[i]
  end
  return t1
end

function M.IsUnitInRoshpit(unit)
  return GetUnitToLocationDistance(unit, constants.ROSHAN_PIT_LOCATION)
         <= constants.ROSHAN_PIT_RADIUS
end

function M.IsEnemy(unit)
  return unit:GetTeam() ~= GetTeam()
end

function M.GetMinutes(minute)
  return minute * 60
end

-- Provide an access to local functions for unit tests only
M.test_IsFlagSet = IsFlagSet
M.test_GetNormalizedDesire = GetNormalizedDesire

return M

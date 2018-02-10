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

-- Indexes in resulting array do not match to slot indexes.
-- You should shift them -1 to match the slot indexes.

function M.GetItems(unit, slot_numbers, get_function)
  local item_list = {}
  local items_number = 0

  for i = 0, slot_numbers, 1 do
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

function M.GetItem(unit, item_name, slot_type)
  local slot = unit:FindItemSlot(item_name)

  if slot_type ~= nil
     and unit:GetItemSlotType(slot) ~= slot_type then
     return nil end

  return unit:GetItemInSlot(slot)
end

local function GetItemSlotsCount(bot)
  local result, _ = M.GetItems(
    bot,
    constants.INVENTORY_MAX_INDEX,
    function(item) return item:GetName() end)

  return result
end

function M.IsInventoryFull(bot)
  return constants.INVENTORY_SIZE <= GetItemSlotsCount(bot)
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

function M.IsElementInList(list, index, is_deep)
  return M.GetElementIndexInList(list, index, is_deep) ~= -1
end

function M.IsIntersectionOfLists(list1, list2, is_deep)
  for _, e in pairs(list1) do
    if M.IsElementInList(list2, e, is_deep) then
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

function M.PercentToDesire(percent)
  return percent / 100
end

function M.GetInventoryItems(bot)
  local _, result = M.GetItems(
    bot,
    constants.INVENTORY_MAX_INDEX,
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

function M.GetHeroPositions(hero)
  if heroes.HEROES[hero] ~= nil then
    return heroes.HEROES[hero].position
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

local function GetNormalizedRadius(radius)
  if radius == nil or radius == 0 then
    return constants.DEFAULT_ABILITY_USAGE_RADIUS
  end

  -- TODO: Trick with MAX_ABILITY_USAGE_RADIUS breaks Sniper's ult.
  -- But the GetNearbyHeroes function has the maximum radius 1600.

  return M.ternary(
    constants.MAX_ABILITY_USAGE_RADIUS < radius,
    constants.MAX_ABILITY_USAGE_RADIUS,
    radius)
end

function M.GetEnemyHeroes(bot, radius)
  return bot:GetNearbyHeroes(
    GetNormalizedRadius(radius),
    true,
    BOT_MODE_NONE)
end

function M.GetAllyHeroes(bot, radius)
  return bot:GetNearbyHeroes(
    GetNormalizedRadius(radius),
    false,
    BOT_MODE_NONE)
end

function M.GetEnemyCreeps(bot, radius)
  local enemy_creeps = bot:GetNearbyCreeps(
    GetNormalizedRadius(radius),
    true)

  local neutral_creeps = bot:GetNearbyNeutralCreeps(
    GetNormalizedRadius(radius))

  return M.ComplementOfLists(enemy_creeps, neutral_creeps, true)
end

function M.GetNeutralCreeps(bot, radius)
  return bot:GetNearbyNeutralCreeps(GetNormalizedRadius(radius))
end

function M.GetAllyCreeps(bot, radius)
  return bot:GetNearbyCreeps(GetNormalizedRadius(radius), false)
end

function M.GetEnemyBuildings(bot, radius)
  local towers = bot:GetNearbyTowers(GetNormalizedRadius(radius), true)

  if #towers ~= 0 then
    return towers end

  return bot:GetNearbyBarracks(GetNormalizedRadius(radius), true)
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

function M.IsEnemyNear(bot)
  local radius = constants.MAX_GET_UNITS_RADIUS

  return 0 < #M.GetEnemyHeroes(bot, radius)
         or 0 < #M.GetEnemyCreeps(bot, radius)
         or 0 < #M.GetEnemyBuildings(bot, radius)
end

function M.GetNearestLocation(bot, locations_list)
  return M.GetElementWith(
    locations_list,
    function(t, a, b)
      return GetUnitToLocationDistance(bot, t[a])
             < GetUnitToLocationDistance(bot, t[b])
    end)
end

function M.IsUnitLowHp(unit)
  return unit:GetHealth() <= constants.UNIT_LOW_HEALTH
         or M.GetUnitHealthLevel(unit)
            <= constants.UNIT_LOW_HEALTH_LEVEL
end

function M.GetNormalizedDesire(desire, max_desire)
  return M.ternary(max_desire < desire, max_desire, desire)
end

function M.IsEnemyHeroOnTheWay(bot, location)
  local enemies = M.GetEnemyHeroes(bot, constants.MAX_GET_UNITS_RADIUS)
  local bot_distance = GetUnitToLocationDistance(bot, location)

  return nil ~= M.GetElementWith(
    enemies,
    nil,
    function(unit)
      return GetUnitToLocationDistance(unit, location) < bot_distance
    end)
end

local function CompareMaxHeroKills(t, a, b)
  return GetHeroKills(t[b]) < GetHeroKills(t[a])
end

function M.GetMaxKillsPlayer(team, validate_function)
  local players = GetTeamPlayers(team)
  local player = M.GetElementWith(
    players,
    CompareMaxHeroKills,
    validate_function)

  return player
end

function M.GetLastPlayerLocation(player)
  if player == nil then
    return nil end

  local seen_info = GetHeroLastSeenInfo(player)

  if seen_info == nil
     or #seen_info == 0
     or seen_info[1] == nil
     or 10 < seen_info[1].time_since_seen then
    return nil end

  return seen_info[1].location
end

-- Provide an access to local functions for unit tests only
M.test_GetNormalizedRadius = GetNormalizedRadius
M.test_GetItemSlotsCount = GetItemSlotsCount
M.test_IsFlagSet = IsFlagSet
M.test_GetNormalizedDesire = GetNormalizedDesire

return M

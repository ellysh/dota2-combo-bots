local M = {}

local INVENTORY_SIZE = 8

local function GetItemSlotsCount()
  local result = 0

  for i = 0, INVENTORY_SIZE, 1 do
    local item = npc_bot:GetItemInSlot(i)
    if item ~= nil then
      result = result + 1
    end
  end

  return result
end

function M.IsItemSlotsFull(npc_bot)
  return INVENTORY_SIZE <= GetItemSlotsCount()
end

return M

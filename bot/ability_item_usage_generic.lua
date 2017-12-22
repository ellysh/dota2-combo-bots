local M = {}

local function IsCourierFree(state)
  return state ~= COURIER_STATE_MOVING
         and state ~= COURIER_STATE_DELIVERING_ITEMS
end

function CourierUsageThink()
  local npc_bot = GetBot()
  local courier = GetCourier(0)

  if not npc_bot:IsAlive() or courier == nil then
    return
  end

  local courier_state = GetCourierState(courier)

  if state == COURIER_STATE_DEAD then return end

  if IsCourierFree(courier_state) and npc_bot:GetCourierValue() > 0
    and not IsItemSlotsFull() then

    npc_bot:ActionImmediate_Courier(
      courier,
      COURIER_ACTION_TRANSFER_ITEMS)
  end
end

return M

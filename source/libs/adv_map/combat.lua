---@class _ArmySlot
---@field creature Creature
---@field amount number
---@field IsEmpty function(): 1|nil

---@alias ArmySlot _ArmySlot|DefaultClassBody

---@param id CreatureID
---@param amount number
---@return ArmySlot
function ArmySlot(id, amount)
    ---@type ArmySlot
    local _army_slot = Class {
        typename = "ArmySlot",
    }

    _army_slot.creature = CREATURES_DATA[id]
    _army_slot.amount = amount

    function _army_slot:IsEmpty()
        local result = self.amount == 0
        return result
    end

    return _army_slot
end

__end_import()
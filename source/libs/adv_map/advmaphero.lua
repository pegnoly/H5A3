---@class AdvMapHeroBase: Object
---@field data Hero
---@field IsAlive fun(self): 1|nil|boolean
---@field EngageCombat fun(self, enemy: string|nil, army: ArmySlot[], is_quick?: string|nil, arena?: string|nil): 1|nil|boolean

---@alias AdvMapHero AdvMapHeroBase | IMovable | IInteractable | IArmyContainer

---@param internal_name string
---@return AdvMapHero
function AdvMapHero(internal_name)
    ---@type AdvMapHero
    local _adv_map_hero = Class {
        typename = "AdvMapHero"
    }

    _adv_map_hero.name = internal_name
    _adv_map_hero.data = HEROES_DATA[internal_name]

    --- Object impl

    ---@return Position
    function _adv_map_hero:GetPosition()
        local x, y, f = GetObjectPosition(self.name)
        ---@type Position
        local result = { x = x , y = y, floor = f}
        return result
    end

    function _adv_map_hero:Remove()
        RemoveObject(self.name)
    end

    ---@return 1|nil|boolean
    function _adv_map_hero:Exists()
        local result = IsObjectExists(self.name)
        return result
    end


    -- IInteractable impl

    function _adv_map_hero:Disable()
        SetObjectEnabled(self.name, nil)
    end

    function _adv_map_hero:Enable()
        SetObjectEnabled(self.name, 1)
    end

    ---@return 1|nil|boolean
    function _adv_map_hero:IsEnabled()
        local result = IsObjectEnabled(self.name)
        return result
    end

    -- IArmyContainer impl

    ---@return ArmySlot[]
    function _adv_map_hero:GetArmySlots()
        ---@type ArmySlot[]
        local result = {}
        for slot = 0, 6 do
            local creature, count = GetObjectArmySlotCreature(self.name, slot)
            if not (creature == 0 or count == 0) then
                table.push(result, ArmySlot(creature, count))
            end
        end
        return result
    end

    ---@param slot number
    ---@return ArmySlot|nil
    function _adv_map_hero:GetArmySlot(slot)
        local creature, count = GetObjectArmySlotCreature(self.name, slot)
        local result
        if not (creature == 0 or count == 0) then
            result = ArmySlot(creature, count)
        end
        return result
    end

    ---@param creature CreatureID
    ---@return number
    function _adv_map_hero:GetCreaturesCount(creature)
        local result = GetHeroCreatures(self.name, creature)
        return result
    end

    function _adv_map_hero:RemoveCreaturesOfCount(creature, count)
        RemoveHeroCreatures(self.name, creature, count)
    end

    ---@param slot ArmySlot
    function _adv_map_hero:AddCreatures(slot)
        AddHeroCreatures(self.name, slot.creature.id, slot.amount)
    end

    -- Self impl

    ---@return 1|nil|boolean
    function _adv_map_hero:IsAlive()
        local result = IsHeroAlive(self.name)
        return result
    end

    ---@param enemy string|nil
    ---@param army ArmySlot[]
    ---@param is_quick? string|nil
    ---@param arena? string|nil
    ---@return 1|nil|boolean
    function _adv_map_hero:EngageCombat(enemy, army, is_quick, arena)
        is_quick = is_quick or nil
        arena = arena or nil

        local p = {}
        ---@param slot ArmySlot
        for _, slot in army do
            table.push(p, slot.creature.id)
            table.push(p, slot.amount)
        end
        table.push(p, nil)
        table.push(p, nil)
        table.push(p, arena)
        table.push(p, is_quick)
        local fight_id = GetLastSavedCombatIndex()
        StartCombat(self.name, enemy, length(army), table.unpack(p))
        while GetLastSavedCombatIndex() == fight_id do
            sleep()
        end
        
        return IsHeroAlive(self.name)
    end

    return _adv_map_hero
end

__end_import()
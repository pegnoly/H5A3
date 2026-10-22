---@class Position
---@field x number
---@field y number
---@field floor MapLevel

---@class Object: DefaultClassBody
---@field name string
---@field GetPosition fun(self): Position
---@field Exists fun(self): 1|nil|boolean
---@field Remove fun(self)

---@class IMovable
---@field SetPosition fun(self, pos: Position)

---@class IInteractable
---@field IsEnabled fun(self): 1|nil|boolean
---@field Enable fun(self)
---@field Disable fun(self)


---@class IVisitable: IInteractable
---@field MarkAsVisited fun(self, hero: AdvMapHero)

---@class IArmyContainer
---@field GetArmySlots fun(self): ArmySlot[]
---@field GetCreaturesCount fun(self, creature: CreatureID): number
---@field AddCreatures fun(self, slot: ArmySlot)
---@field GetArmySlot fun(self, slot: number): ArmySlot
---@field RemoveCreaturesOfCount fun(self, creature: CreatureID, count: number)

__end_import()
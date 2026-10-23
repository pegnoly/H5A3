---@class QuestDataModel
---@field id string
---@field name_path string
---@field text_path string

---@class QuestContext
---@field hero AdvMapHero
---@field date Date

---@class QuestStartContext: QuestContext

---@class QuestUpdateContext: QuestContext
---@field source any

---@class QuestCompleteContext: QuestContext

---@class QuestFailContext: QuestContext

---@class QuestBase: DefaultClassBody
---@field data QuestDataModel
---@field GetProgress fun(self, player?: PlayerID): number
---@field SetProgress fun(self, progress: number, player?: PlayerID)
---@field IsActive fun(self, player?: PlayerID): 1|nil|boolean
---@field IsUnknown fun(self, player?: PlayerID): 1|nil|boolean
---@field IsCompleted fun(self, player?: PlayerID): 1|nil|boolean
---@field IsFailed fun(self, player?: PlayerID): 1|nil|boolean
---@field Init fun(self)
---@field Start fun(self, context: QuestStartContext)
---@field Update fun(self, context: QuestUpdateContext)
---@field Complete fun(self, context: QuestCompleteContext)
---@field Fail fun(self, context: QuestFailContext)

---@param model QuestDataModel
---@return QuestBase
function QuestBase(model)
    ---@type QuestBase
    local _quest = Class {
        typename = "QuestBase"
    }

    _quest.data = model

    ---@param player? PlayerID
    function _quest:GetProgress(player)
        player = player or PLAYER_1
        local p = GetObjectiveProgress(self.data.id, player)
        return p
    end

    ---@param player? PlayerID
    function _quest:SetProgress(progress, player)
        player = player or PLAYER_1
        SetObjectiveProgress(self.data.id, progress, player)
    end

    ---@param player? PlayerID
    function _quest:IsActive(player)
        return GetObjectiveState(self.data.id, player) == OBJECTIVE_ACTIVE
    end

    ---@param player? PlayerID
    function _quest:IsUnknown(player)
        return GetObjectiveState(self.data.id, player) == OBJECTIVE_UNKNOWN
    end

    ---@param player? PlayerID
    function _quest:IsCompleted(player)
        return GetObjectiveState(self.data.id, player) == OBJECTIVE_COMPLETED
    end

    ---@param player? PlayerID
    function _quest:IsFailed(player)
        return GetObjectiveState(self.data.id, player) == OBJECTIVE_FAILED
    end

    return _quest
end


__end_import()
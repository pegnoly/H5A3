---@GENERATED DO_NOT_REMOVE
---@enum MainQuestUpdateSource
MainQuestUpdateSource = {
	STACKS_KILLED = 1,-- убито стеков
	TEST_SOURCE = 2,-- тестовый источник
}

---@class __MainQuestUpdateContext: QuestUpdateContext
---@field source MainQuestUpdateSource
---@field stacks_killed? number
---@field is_test? bool

---@END_OF GENERATED

---@class __MainQuestStartContext: QuestStartContext

---@class __MainQuestCompleteContext: QuestCompleteContext

---@class __MainQuestFailContext: QuestFailContext

---@class __MainQuest: QuestBase
---@field Start fun(self, context: __MainQuestStartContext)
---@field Update fun(self, context: __MainQuestUpdateContext)
---@field Complete fun(self, context: __MainQuestCompleteContext)
---@field Fail fun(self, context: __MainQuestFailContext)

---@return __MainQuest
function __MainQuest()
    local _quest = QuestBase({
        id = "MAIN_QUEST",
        name_path = "UserCampaigns/A3C1/M1/Quests/Primary/Main/name.txt",
        text_path = "UserCampaigns/A3C1/M1/Quests/Primary/Main/Texts/"
    }) --[[@as __MainQuest]]

    function _quest:Init()

    end

    ---@param context __MainQuestStartContext
    function _quest:Start(context)

    end

    ---@param context __MainQuestUpdateContext
    function _quest:Update(context)

    end

    ---@param context __MainQuestCompleteContext
    function _quest:Complete(context)

    end

    ---@param context __MainQuestFailContext
    function _quest:Fail(context)

    end

    return _quest
end

MainQuest = __MainQuest()

__end_import()
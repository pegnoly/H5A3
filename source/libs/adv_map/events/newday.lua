---@class NewDayEventHandler: EventHandlerBase
---@field func fun(date: Date)

---@class __NewDayEvent: EventBase
---@field subscribe fun(self, handler: NewDayEventHandler)
---@field send fun(self, date: Date)

---@return __NewDayEvent
function __NewDayEvent()
    local _event = EventBase() --[[@as __NewDayEvent]]
    local trigger_handler_name = "new_day_started"
    new_day_trigger_body = function()
        ---@type Date
        __date = Date()
        %_event:send(__date)
    end
    parse(trigger_handler_name..[[ = new_day_trigger_body]])()
    Trigger(NEW_DAY_TRIGGER, trigger_handler_name)
    
    return _event
end

NewDayEvent = __NewDayEvent()

__end_import()
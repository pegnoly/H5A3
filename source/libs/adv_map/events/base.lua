---@enum HandlerPriority
HandlerPriority = {
    Default = 0,
    High = 1,
    Low = 2
}

---@class EventHandlerBase
---@field priority? HandlerPriority -- HandlerPriority.Default by default
---@field is_background? bool -- wait for handler finish its work/put at background;  nil by default
---@field func fun(...) -- needed for correct base event class impl

---@class EventBase: DefaultClassBody
---@field handlers EventHandlerBase []
---@field subscribe fun(self, handler: EventHandlerBase)
---@field unsubscribe fun(self, func: function)
---@field send fun(...)

---@return EventBase
function EventBase()
    ---@type EventBase
    local _event = Class {
        typename = "EventBase"
    }

    _event.handlers = {}

    ---@param handler EventHandlerBase
    function _event:subscribe(handler)
        self:unsubscribe(handler.func)
        table.push(self.handlers, handler)
    end

    ---@param func function
    function _event:unsubscribe(func)
        local updated_handlers = Iterator(self.handlers)
            .Filter(
            ---@param item EventHandlerBase
            function (item)
                if item.func == %func then
                    return nil
                end
                return 1
            end)
            .Collect()
        self.handlers = updated_handlers
    end

    function _event:send(...)
        ---@param handler EventHandlerBase
        for _, handler in self.handlers do
            handler.func(table.unpack(arg))
        end       
    end

    return _event
end

__end_import()
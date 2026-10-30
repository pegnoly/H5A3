---@class RegionEnterEventHandler: EventHandlerBase
---@field func fun(hero: AdvMapHero, region: Region)

---@class RegionEnterEvent: EventBase
---@field subscribe fun(self, handler: RegionEnterEventHandler)
---@field send fun(self, hero: AdvMapHero, region: Region)

---@param region Region
---@return RegionEnterEvent
function RegionEnterWithStopEvent(region)
    local _event = EventBase() --[[@as RegionEnterEvent]]
    _event.typename = "RegionEnterEvent"

    local trigger_handler_name = region.name.."_entered_with_stop"
    trigger_body = function(entered_hero, entered_region)
        __hero = AdvMapHero(entered_hero)
        __region = Region(entered_region)
        %_event:send(__hero, __region)
    end
    parse(trigger_handler_name..[[ = trigger_body]])()
    Trigger(REGION_ENTER_AND_STOP_TRIGGER, region.name, trigger_handler_name)

    return _event
end

__end_import()
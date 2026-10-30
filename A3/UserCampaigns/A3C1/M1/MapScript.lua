while not import do
    sleep()
end

import('@entry_points/adv_map_entry_point')

local adv_map_hero = AdvMapHero(GetPlayerHeroes(PLAYER_1)[0])

print("Position: ", adv_map_hero:GetPosition())

NewDayEvent:subscribe({
    func = function (date)
        print("Date: ", date)
    end
})

local region = Region("start_island_orc_garrison")
local event = region:ConnectWithStopEvent()
event:subscribe({
    ---@param hero AdvMapHeroBase|IArmyContainer|IInteractable|IMovable
    ---@param region Region
    func = function (hero, region)
        print("Hero ", hero.name, " entered ", region.name)
    end
})
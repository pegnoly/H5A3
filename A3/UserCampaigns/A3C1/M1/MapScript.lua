while not import do
    sleep()
end

import('@entry_points/adv_map_entry_point')

local adv_map_hero = AdvMapHero(GetPlayerHeroes(PLAYER_1)[0])

print("Position: ", adv_map_hero:GetPosition())
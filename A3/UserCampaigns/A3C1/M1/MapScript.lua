while not import do
    sleep()
end

import('entry_points/adv_map_entry_point', 1)

local test_data = Iterator({1, 2, 3})
    .Map(function (item)
        return item * 2
    end)
    .Collect()

print("Test data: ", test_data)

local creature = Creature(CREATURE_ROYAL_GRIFFIN)

print("Abilities: ", creature.abilities)
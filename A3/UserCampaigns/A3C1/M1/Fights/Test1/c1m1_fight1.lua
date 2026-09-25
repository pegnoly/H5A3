
while not (UNIT_COUNT_GENERATION_MODE_POWER_BASED and UNIT_COUNT_GENERATION_MODE_RAW and Iterator) do
    sleep()
end

c1m1_fight1 = {
	stack_count_generation_logic = {
		[1] = UNIT_COUNT_GENERATION_MODE_POWER_BASED,
		[2] = UNIT_COUNT_GENERATION_MODE_POWER_BASED,
		[3] = UNIT_COUNT_GENERATION_MODE_RAW,
	},

	army_base_count_data = {
		[1] = {
			[DIFFICULTY_EASY] = 10000,
			[DIFFICULTY_NORMAL] = 15000,
			[DIFFICULTY_HEROIC] = 25000,
			[DIFFICULTY_HARD] = 20000,
		},
		[2] = {
			[DIFFICULTY_HEROIC] = 35000,
			[DIFFICULTY_HARD] = 30000,
			[DIFFICULTY_EASY] = 20000,
			[DIFFICULTY_NORMAL] = 25000,
		},
		[3] = {
			[DIFFICULTY_HEROIC] = 30,
			[DIFFICULTY_EASY] = 15,
			[DIFFICULTY_HARD] = 25,
			[DIFFICULTY_NORMAL] = 20,
		},
	},

	army_counts_grow = {
	},

	army_getters = {
		[1] = function ()
            local id = Iterator(Creature.Selection.FromTownsAndTiers({TOWN_ACADEMY, TOWN_DUNGEON}, {1, 2}))
                .Filter(function(creature)
                    local result = Creature.Params.IsGeneratable(creature)
                    return result
                end)     
                .TakeRandom(1)
                .Collect()[1]
            return id
		end,
		[2] = function ()
            local id = Iterator(Creature.Selection.FromTownsAndTiers({TOWN_DUNGEON}, {4}))
                .Filter(function(creature)
                    local result = 1
                    return result
                end)     
                .TakeRandom(1)
                .Collect()[1]
            return id
		end,
		[3] = function ()
            local result = Random.FromTable({108})
            return result
        end,
	},

}
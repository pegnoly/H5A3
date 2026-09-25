while not (import and __end_import) do
    sleep()
end

import("consts/ability", 1)
import("consts/artifact", 1)
import("consts/common", 1)
import("consts/creature", 1)
import("consts/skill", 1)
import("consts/spell", 1)
import("consts/town_building", 1)
import("consts/week", 1)

import("generated/creatures", 1)
import("generated/heroes", 1)
import("generated/artifacts", 1)
import("generated/spells", 1)

import("common/core", 1)
import("common/consts", 1)
import("common/class", 1)
import("common/random", 1)
import("common/iterators", 1)

import("common/creature", 1)

__end_import()
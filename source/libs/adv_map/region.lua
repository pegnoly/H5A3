---@class Region: DefaultClassBody
---@field name string
---@field Block fun(self, player?: PlayerID)
---@field Unblock fun(self, player?: PlayerID)
---@field BlockForPlayers fun(self, players: PlayerID[])
---@field UnblockForPlayers fun(self, players: PlayerID[])
---@field ConnectWithStopEvent fun(self): RegionEnterEvent

---@param name string
---@return Region
function Region(name)
    ---@type Region
    local _region = Class {
        typename = "Region"
    }

    _region.name = name

    ---@return RegionEnterEvent
    function _region:ConnectWithStopEvent()
        local event = RegionEnterWithStopEvent(self)
        return event
    end
    
    ---@param player? PlayerID(+4)
    function _region:Block(player)
        player = player or PLAYER_1
        SetRegionBlocked(self.name, 1, player)
    end

    ---@param player? PlayerID
    function _region:Unblock(player)
        player = player or PLAYER_1
        SetRegionBlocked(self.name, nil, player)
    end

    ---@param players PlayerID[]
    function _region:BlockForPlayers(players)
        for _, player in players do
            SetRegionBlocked(self.name, 1, player)
        end
    end

    ---@param players PlayerID[]
    function _region:UnblockForPlayers(players)
        for _, player in players do 
            SetRegionBlocked(self.name, nil, player)
        end
    end

    return _region
end

__end_import()
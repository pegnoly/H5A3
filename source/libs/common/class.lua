---@class DefaultClassBody
---@field typename string
---@field __type? function(): string
---@field __sametype? function(object: table): 1|nil
---@field __equal__? function(other: table): 1|nil|boolean
---@field __tostr__? function(): string
---@field next? function()
---@field __pureVirtualCall__? function()

---@param body DefaultClassBody
---@return table
---@nodiscard
function Class(body)

    function body:__type()
        return self.typename
    end

    function body:__sametype(object)
        for key, v in self do
            if not object[key] and v then
                return nil
            end
        end
        return 1;
    end
    
    function body:__equal__(other)
        if not self:__sametype(other) then
            return nil
        end
        return self == other
    end
    
    function body:__tostr__()
        local result = ""
        for key, value in self do
            result = result..'['..key..']=..., '
        end
        return result
    end
    
    function body:next()
    
    end

    function body:__pureVirtualCall__(...)
        print(table.unpack(arg))
        return _ERRORMESSAGE("Attempt to call a purely abstract class method")
    end
    
    return body
end

__end_import()
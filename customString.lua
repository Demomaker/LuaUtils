CustomString = { str = "" }

function CustomString:new(o, str)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    self.str = str
    return o
end

function CustomString:split(ch)
    local aTable = {}
    local newstr = self.str
    local index = 0
    for i = 0, #newstr do
        local v = newstr:sub(i,i)
        if ch == "" then
            if aTable[index] == nil then
                aTable[index] = v
            else
                aTable[index] = aTable[index] + v
            end
            index = index + 1
        elseif v == ch then
            index = index + 1
        else
            aTable[index] = aTable[index] + v
        end
    end
    return aTable
end

function CustomString:getStringAsTable()
    return self:split("")
end

function CustomString:getStringAsPairs()
    return pairs(self:getStringAsTable())
end

function CustomString:iter(func)
    for k,v in self:getStringAsPairs() do
        func(v)
    end
end

function CustomString:map(func)
    local retTable = {}
    for k,v in self:getStringAsPairs() do
        retTable[k] = func(v)
    end
    return retTable
end

function CustomString:fromTableOfChars(aTable)
    local newStr = ""
    for k,v in pairs(aTable) do
        newStr = newStr .. v
    end
    return CustomString:new(nil, newStr)
end

function CustomString:replace(ch, newch)
    local function replaceChar(oldch)
        if oldch == ch then
            return newch
        else
            return oldch
        end
    end
    self.str = self:fromTableOfChars(self:map(replaceChar)).str
end

return CustomString

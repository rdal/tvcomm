-------------------------------------------------------------------------------------
---- Class: String
----
---- This is the base class String
----
---- | Date        | Author                  | Description
----
----  10/03/2008     Rafael Donato             Initial Creation
----  11/08/2008     Rafael Donato             Added explode function
----
---------------------------------------------------------------------------------------

String = {}
stringmt = {}

function String:new(s)
    return setmetatable({ value = s or '' }, stringmt)
end

function String:print()
    print(self.value)
end

function String:getValue()
    return self.value
end

-- This function tokenizes a string based on a separator
function String:explode(separator)

    local piece = ''
    local pieces = {}

    lastStop = 1
    start = 1
    stop = 1

    -- Finds the first ocurrency of the separator
    start,stop = string.find(self.value, separator:getValue(), lastStop)
    while start ~= nil do
        
        -- Get from the begining until separator, so it gets a token
        piece = string.sub(self.value, lastStop, start - 1)

        table.insert(pieces, piece)
        lastStop = stop+1

        start,stop = string.find(self.value, separator:getValue(), lastStop)

    end
    piece = string.sub(self.value, lastStop, string.len(self.value))
    table.insert(pieces, piece)

    return pieces
end


-- The metatable to create callbacks
stringmt.__add = function (a,b) return String:new(a.value..b.value) end
stringmt.__index = String -- redirect queries to the String table

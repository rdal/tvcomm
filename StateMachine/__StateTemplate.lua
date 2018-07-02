-------------------------------------------------------------------------------------
------ Class: StateName
------
------ This is the base class for StateName
------
------ | Date        | Author                  | Description
------
------  18/01/2009     Rafael Donato             Criacao Inicial
------
------
-----------------------------------------------------------------------------------------


StateName = {}
statemt = {}

-- Class Constructor
function StateName:new()


    local instance = {}
    setmetatable(instance, statemt) -- Associate this StateName object with statemt metatable

    instance.finished = false
    instance.nextState = ""

    return instance

end


function StateName:onBegin(data)
end

function StateName:execute(evt)
end

function StateName:onEnd()
end

function StateName:isFinished()
    return self.finished
end

function StateName:setFinished(f)
    self.finished = f
end

function StateName:getNextState()
    return self.nextState
end

function StateName:getData()
    return nil
end

-- The metatable to create callbacks
statemt.__index = StateName -- redirect queries to StateName table

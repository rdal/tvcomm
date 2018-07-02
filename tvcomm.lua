require "util/Factory"


local factory = Factory:new()

function changeScreen(screen)

    local data

    if(SCREEN ~= nil) then
        data = SCREEN:getData()
        SCREEN:onEnd()
    end
    SCREEN = screen
    SCREEN:onBegin(data)
end

function handler(evt)

    if evt.class ~= 'key' then return end

    SCREEN:execute(evt)
    evt.class = nil

    if(SCREEN:isFinished() == true) then
        SCREEN:setFinished(false)
        changeScreen(factory:getScreen(SCREEN:getNextState()))        
    end

end
event.register(handler)

local SCREEN = nil
--local factory = Factory:new()
--changeScreen(Tira:new(nil))

-- cor de fundo
--canvas:attrColor('black')

-- Muda para o primeiro estado da aplicacao
changeScreen(factory:getScreen("TIRA"))

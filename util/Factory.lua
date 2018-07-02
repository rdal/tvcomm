-------------------------------------------------------------------------------------
------ Class: Factory
------
------ This is the base class for Factory
------
------ | Date        | Author                  | Description
------
------  16/01/2009     Rafael Donato             Criacao Inicial
------
------
-----------------------------------------------------------------------------------------
require("Globals")
require("StateMachine/Tira")
require("StateMachine/ProductDetails")
require("StateMachine/Login")


Factory = {}
factorymt = {}

-- Class Constructor
function Factory:new()


    local instance = {}
    setmetatable(instance, factorymt) -- Associate this Factory object with factorymt metatable

    -- Set up a parameter
    instance.tira = Tira:new()
    instance.productDetails = ProductDetails:new()
    instance.login = Login:new()

    return instance

end


function Factory:getScreen(screenName)

    ret = nil

    if(screenName == ST_TIRA_STATE) then
        ret = self.tira
    elseif (screenName == ST_PRODUCTDETAILS_STATE) then
        ret = self.productDetails
    elseif (screenName == ST_LOGIN_STATE) then
        ret = self.login
    end

    return ret

end

-- The metatable to create callbacks
factorymt.__index = Factory -- redirect queries to Factory table

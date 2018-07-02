-------------------------------------------------------------------------------------
------ Class: Order
------
------ This is the base class Order
------
------ | Date        | Author                  | Description
------
------  10/04/2008     Rafael Donato             Initial Creation
------
------
-----------------------------------------------------------------------------------------

require "util/String"

Order = {}
ordermt = {}

function Order:new(id, prodId, q, cardB, cardN, cardSC, good, m, uId)
    
    local instance = {}
    setmetatable(instance, ordermt) -- Associate this Order object with ordermt metatable

    instance.orderId = id
    instance.productId = prodId
    instance.quantity = q
    instance.cardBrand = cardB -- String
    instance.cardNumber = cardN -- String
    instance.cardSecurityCode = cardSC
    instance.goodThru = good
    instance.months = m
    instance.userId = uId


    return instance

end

-- Returns the order id
function Order:getOrderId()
    return self.orderId
end

-- Returns the order's product id
function Order:getProductId()
    return self.productId
end

-- Returns the order's product id
function Order:getQuantity()
    return self.quantity
end

-- Returns the order's card brand
function Order:getCardBrand()
    return self.cardBrand
end

-- Returns the order's card number
function Order:getCardNumber()
    return self.cardNumber
end

-- Returns the order's card security code
function Order:getCardSecurityCode()
    return self.cardsecurityCode
end

-- Returns the order's card good thru date
function Order:getGoodThru()
    return self.goodThru
end

-- Returns the order's number of months in which the order was divided
function Order:getMonths()
    return self.months
end

-- Returns the order's user id
function Order:getUserId()
    return self.userId
end


ordermt.__index = Order -- redirect queries to the Order table

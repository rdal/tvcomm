-------------------------------------------------------------------------------------
---- File: ProductRepository
----
---- Manipulate Product objetcs
----
---- | Date        | Author                  | Description
----
----  11/05/2008     Rafael Donato             Initial Creation
----  11/11/2008     Rafael Donato             Handle product id in getProductDataByPos
----  11/22/2008     Rafael Donato             Handle product name and price
----  01/10/2009     Rafael Donato             getProductDataByPos gets data through a CSV object
----
----
---------------------------------------------------------------------------------------

require "model/Product"
require "util/CSV"


ProductRepository = {}
productrepositorymt = {}

function ProductRepository:new()
    
    local instance = {}
    setmetatable(instance, productrepositorymt) -- Associate this ProductRepository object with classtabelmt metatable

    -- Set up a parameter
    instance.par = nil
    
    return instance
end 

-- This function retrieves the Product data
function ProductRepository:getProductDataByPos(pos)
    local products = {}

    csv = CSV:new("/root/TVComm2/res/products.csv")
    products = csv:getProducts()

    local product = nil
    for k,prod in pairs(products) do

        if(tonumber(pos) == k) then
            product = prod
            break
        end
    end

    return product

end

-- The metatable to create callbacks
productrepositorymt.__index = ProductRepository -- redirect queries to ProductRepository table

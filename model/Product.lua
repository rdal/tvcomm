-------------------------------------------------------------------------------------
---- Class: Product
----
---- This is the base class Product
----
---- | Date        | Author                  | Description
----
----  10/03/2008     Rafael Donato             Initial Creation
----
----
---------------------------------------------------------------------------------------

Product = {}
productmt = {}

function Product:new(id, n, desc, p)
    --return setmetatable({ name = n, description = desc, price = p }, productmt)
    local instance = {}
    setmetatable(instance, productmt) -- Associate this Product object with productmt metatable

    instance.productId = id
    instance.name = n
    instance.description = desc
    instance.price = p
    --instance.imagePath = path
    

    return instance
    
end

-- Returns the product id
function Product:getProductId()
    return self.productId
end

-- Returns the product's name
function Product:getName()
    return self.name
end

-- Returns the product's description
function Product:getDescription()
    return self.description
end

-- Returns the product's price
function Product:getPrice()
    return self.price
end

-- Returns the product's image path
--function Product:getImagePath()
--    return self.imagePath
--end

-- The metatables to create callbacks
productmt.__index = Product -- redirect queries to the Product table

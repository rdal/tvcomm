-------------------------------------------------------------------------------------
------ Class: CSV
------
------ This is the base class for CSV
------
------ | Date        | Author                  | Description
------
------  10/01/2008     Rafael Donato             Initial Creation
------
------
-----------------------------------------------------------------------------------------
require("util/String")
require("model/Product")


CSV = {}
csvtablemt = {}

-- Class Constructor
function CSV:new(CSVFile)


    local instance = {}
    setmetatable(instance, csvtablemt) -- Associate this CSV object with csvtablemt metatable

    instance.products = {}

    local pieces = {}

    -- Read CSV file and save its lines as a Product instance    
    for line in io.lines(CSVFile) do
        l = String:new(line)
        separator = String:new(";")
        
        pieces = l:explode(separator)
        prod = Product:new(pieces[1], pieces[2], pieces[3], pieces[4])
        table.insert(instance.products, prod)
    end

    return instance

end


-- Return the products from the CSV File
function CSV:getProducts()
    return self.products;
end

-- The metatable to create callbacks
csvtablemt.__index = CSV -- redirect queries to CSV table

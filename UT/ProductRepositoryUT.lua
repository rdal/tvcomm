require ("model/ProductRepository")

prodRep = ProductRepository:new()

prod = prodRep:getProductDataByPos(1)
print(prod:getName())

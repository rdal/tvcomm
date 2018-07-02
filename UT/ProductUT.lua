require("model/Product")

id = 5
n = "Nome"
desc = "Descricao"
p = 150.35
path = "image/img.png"

prod = Product:new(id, n, desc, p, path)

print(prod:getProductId())
print(prod:getName())
print(prod:getDescription())
print(prod:getPrice())
print(prod:getImagePath())

-------------------------------------------------------------------------------------
------ Class: ProductDetails
------
------ This is the base class for ProductDetails
------
------ | Date        | Author                  | Description
------
------  16/01/2009     Rafael Donato             Criacao Inicial
------
------
-----------------------------------------------------------------------------------------
require("Globals")
require("model/ProductRepository")
require("model/Product")
require("uiComponents/TextBox")

ProductDetails = {}
productdetailsmt = {}

-- Class Constructor
function ProductDetails:new()


    local instance = {}
    setmetatable(instance, productdetailsmt) -- Associate this ProductDetails object with productdetailsmt metatable

    -- Set up a parameter
    instance.finished = false
    instance.nextState = ""

    instance.pRepository = ProductRepository:new()
    instance.currentProductIdx = 0
    instance.currentProduct = nil

    instance.nameBox = TextBox:new()
    instance.priceBox = TextBox:new()
    instance.textBox = TextBox:new()

    return instance

end

function ProductDetails:onBegin(data)
    print("onBegin PRODUCT DETAILS")
    self.currentProductIdx = data
    self.currentProduct = self.pRepository:getProductDataByPos(self.currentProductIdx)

    self:redrawProductDetails()
end

function ProductDetails:execute(evt)
    print("PRODUCT DETAILS")

    if evt.class == 'key' and evt.type == 'press' then
        if evt.key == 'RED' then
            event.post('out', { class='ncl', type='presentation', area='stopresize', transition='starts' })
            event.post('out', { class='ncl', type='presentation', area='startresize', transition='stops' })
            self.finished = true
            self.nextState = ST_TIRA_STATE
        
        elseif evt.key == 'CURSOR_LEFT' then
            if self.currentProductIdx == 1 then
                self.currentProductIdx = 5
            else
                self.currentProductIdx = self.currentProductIdx -1
            end
            self.currentProduct = self.pRepository:getProductDataByPos(self.currentProductIdx)

        elseif evt.key == 'CURSOR_RIGHT' then
            if self.currentProductIdx == 5 then
                self.currentProductIdx = 1
            else
                self.currentProductIdx = self.currentProductIdx +1
            end
            self.currentProduct = self.pRepository:getProductDataByPos(self.currentProductIdx)

        elseif evt.key == 'GREEN' then
            self.finished = true
            self.nextState = ST_LOGIN_STATE
        end
        

    end
    self:redrawProductDetails()
    --evt.class = nil

end

function ProductDetails:onEnd()
    print("onEnd PRODUCT DETAILS")
end

function ProductDetails:isFinished()
    return self.finished
end

function ProductDetails:setFinished(f)
    self.finished = f
end

function ProductDetails:getNextState()
    return self.nextState
end

function ProductDetails:getData()
    local pRep = ProductRepository:new()
    local p = pRep:getProductDataByPos(self.currentProductIdx)

    return {self.currentProductIdx, p}
end

--------------------------------------------------------------------------------

function ProductDetails:redrawProductDetails()

    -- Imagem limite fundo
    img = canvas:new("images/limite.png")
    dx, dy = img:attrSize()
    canvas:compose(0, 0, img)

    -- Imagem de navegacao
    --img = canvas:new("images/navegacao.png")
    --dx, dy = img:attrSize()
    --canvas:compose(0, 80, img)
    
    -- Imagem do Produto
    img = canvas:new("images/imagemproduto".. self.currentProductIdx ..".png")
    dx, dy = img:attrSize()
    canvas:compose(26, 30, img)

    -- Nome do Produto
    self.nameBox:setText(self.currentProduct:getName())
    self.nameBox:setPosition(3,3)
    self.nameBox:drawTextBox()

    -- Preco do Produto
    self.priceBox:setText("R$ "..self.currentProduct:getPrice())
    self.priceBox:setPosition(10,232)
    self.priceBox:drawTextBox()

    -- Descricao do Produto
    self.textBox:setText(self.currentProduct:getDescription())
    self.textBox:setPosition(10, 270)
    self.textBox:drawTextBox()

    -- Botao Comprar
    --img = canvas:new("images/comprar.png")
    --dx, dy = img:attrSize()
    --canvas:compose(510, 260, img)

    -- Botao Retornar
    --img = canvas:new("images/retornar.png")
    --dx, dy = img:attrSize()
    --canvas:compose(510, 300, img)

    -- Botao Sair
    --img = canvas:new("images/sair.png")
    --dx, dy = img:attrSize()
    --canvas:compose(531, 340, img)

    canvas:flush()
end

-- The metatable to create callbacks
productdetailsmt.__index = ProductDetails -- redirect queries to ProductDetails table

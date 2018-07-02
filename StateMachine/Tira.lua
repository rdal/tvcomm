-------------------------------------------------------------------------------------
------ Class: Tira
------
------ This is the base class for Tira
------
------ | Date        | Author                  | Description
------
------  16/01/2009     Rafael Donato             Criacao Inicial
------
------
-----------------------------------------------------------------------------------------
require("Globals")

Tira = {}
tiramt = {}

-- Class Constructor
function Tira:new()


    local instance = {}
    setmetatable(instance, tiramt) -- Associate this Tira object with tiramt metatable

    -- Set up a parameter
    --instance.lastS = lastScreen
    instance.finished = false
    instance.nextState = ""

    local img
    local dx, dy
	
	-- Posicao das imagens na tira
	local xProdlist = 117
	local yProdlist = 295
	
    -- Icone interativo
    img = canvas:new('images/icon.png')
    dx, dy = img:attrSize()
    instance.icon = { img=img, x=531, y=340, dx=dx, dy=dy }
    
    -- Menu
    img = canvas:new('images/menu.png')
    dx, dy = img:attrSize()
    instance.menu = { img=img, x=90, y=285, dx=dx, dy=dy }
    
    -- ImagemProduto1
    img = canvas:new('images/prodlist1.png')
    dx, dy = img:attrSize()
    instance.imagemproduto1 = { img=img, x=xProdlist, y=yProdlist, dx=dx, dy=dy }
    
    -- ImagemProduto2
    img = canvas:new('images/prodlist2.png')
    dx, dy = img:attrSize()
    instance.imagemproduto2 = { img=img, x=xProdlist+73, y=yProdlist, dx=dx, dy=dy }
    
    -- ImagemProduto3
    img = canvas:new('images/prodlist3.png')
    dx, dy = img:attrSize()
    instance.imagemproduto3 = { img=img, x=xProdlist+146, y=yProdlist, dx=dx, dy=dy }
    
    -- ImagemProduto4
    img = canvas:new('images/prodlist4.png')
    dx, dy = img:attrSize()
    instance.imagemproduto4 = { img=img, x=xProdlist+219, y=yProdlist, dx=dx, dy=dy }
    
    -- ImagemProduto5
    img = canvas:new('images/prodlist5.png')
    dx, dy = img:attrSize()
    instance.imagemproduto5 = { img=img, x=xProdlist+292, y=yProdlist, dx=dx, dy=dy }
	
	-- Botao Sair
	img = canvas:new('images/sair.png')
	dx, dy = img:attrSize()
	instance.sair = { img=img, x=531, y=340, dx=dx, dy=dy }
	
	-- Focus na lista de produtos
	img = canvas:new('images/focuslista.png')
	dx, dy = img:attrSize()
	instance.focuslista = { img=img, x=xProdlist+141, y=yProdlist-5, dx=dx, dy=dy }
    
    return instance

end

function Tira:onBegin(data)
    --print("onBegin TIRA")
	-- cor de fundo
	canvas:attrColor('black')
	produtoselecionado=3
    self:redrawicon()
end

function Tira:execute(evt)

    print("Function handler!!")
    --for k,v in pairs(evt) do print(k,v) end
    if evt.class == 'key' and evt.type == 'press' then
        if evt.key == 'BLUE' then
            buttonred = "SAIR"
			self:redrawmenu()
			self:redrawsair()
			focus = "TIRA"
			print(focus)
		end
		
		
		if focus == "TIRA" then --- focus da tira
			if self.focuslista.x ~= 112 then --senão tiver no primeiro produto da lista
				if evt.key == 'CURSOR_LEFT' then
					self.focuslista.x = self.focuslista.x - 73
					produtoselecionado = produtoselecionado - 1
					print(produtoselecionado)
					self:redrawmenu()
				end
			end
			
			if self.focuslista.x ~= 404 then --senão tiver no ultimo produto da lista
				if evt.key == 'CURSOR_RIGHT' then
					self.focuslista.x = self.focuslista.x + 73
					produtoselecionado = produtoselecionado + 1
					print(produtoselecionado)
					self:redrawmenu()
				end
			end
			
			if evt.key == 'RED' and buttonred == "SAIR" then
				buttonblue = nil
				focus = nil
				self:redrawicon()
				buttonred = nil
			end
			
			if evt.key == 'ENTER' then
				event.post('out', { class='ncl', type='presentation', area='startresize', transition='starts' })
				event.post('out', { class='ncl', type='presentation', area='stopresize', transition='stops' })
				xProdlist = 117
				self.focuslista.x = xProdlist + 141
				self.finished = true
				self.nextState = ST_PRODUCTDETAILS_STATE
				print("Novo estado: ST_PRODUCTDETAILS_STATE")
				focus = nil
			end
		end
		
		
		
    end

end

function Tira:onEnd()
    print("onEnd TIRA")
	canvas: drawRect('fill', 0,0, canvas:attrSize())
end

function Tira:isFinished()
    return self.finished
end

function Tira:setFinished(f)
    self.finished = f
end

function Tira:getNextState()
    return self.nextState
end

function Tira:getData()
	return produtoselecionado
end
------------------------------------------------------------------

-- Funcao de redesenho:
-- primeiro o fundo, depois o icon
function Tira:redrawicon ()

    for k,v in pairs(self) do print(k,v) end

    canvas:drawRect('fill', 0,0, canvas:attrSize())
    canvas:compose(self.icon.x, self.icon.y, self.icon.img)
    canvas:flush()
end

function Tira:redrawmenu ()
    canvas:drawRect('fill', 0,0, canvas:attrSize())
    canvas:compose(self.menu.x, self.menu.y, self.menu.img)
    canvas:compose(self.imagemproduto1.x, self.imagemproduto1.y, self.imagemproduto1.img)
    canvas:compose(self.imagemproduto2.x, self.imagemproduto2.y, self.imagemproduto2.img)
    canvas:compose(self.imagemproduto3.x, self.imagemproduto3.y, self.imagemproduto3.img)
    canvas:compose(self.imagemproduto4.x, self.imagemproduto4.y, self.imagemproduto4.img)
    canvas:compose(self.imagemproduto5.x, self.imagemproduto5.y, self.imagemproduto5.img)
	canvas:compose(self.sair.x, self.sair.y, self.sair.img)
	canvas:compose(self.focuslista.x, self.focuslista.y, self.focuslista.img)	
    canvas:flush()
end

function Tira:redrawsair ()
	--canvas:drawRect('fill', 0,0, canvas:attrSize())
	canvas:compose(self.sair.x, self.sair.y, self.sair.img)
	canvas:flush()
end

-- The metatable to create callbacks
tiramt.__index = Tira -- redirect queries to Tira table

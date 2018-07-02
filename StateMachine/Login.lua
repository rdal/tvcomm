-------------------------------------------------------------------------------------
------ Class: Login
------
------ This is the base class for Login
------
------ | Date        | Author                  | Description
------
------  18/01/2009     Rafael Donato             Criacao Inicial
------
------
-----------------------------------------------------------------------------------------


Login = {}
loginmt = {}

-- Class Constructor
function Login:new()


    local instance = {}
    setmetatable(instance, loginmt) -- Associate this Login object with loginmt metatable

    instance.finished = false
    instance.nextState = ""

    instance.data = nil
    instance.selectedProduct = nil
    instance.loginFocus = true

    instance.input = {
        text  = '',
        face  = 'vera.ttf',
        color = 'black',
        x  = 30,
        y  = 85,
        dy = 10
    }
    instance.password = {
        text  = '',
        face  = 'vera.ttf',
        color = 'black',
        x  = 30,
        y  = 150,
        dy = 10
    }

    return instance

end


function Login:onBegin(data)

    print("onBegin LOGIN")

    self.data = data
    self.selectedProduct = data[2]

    self.input.text=''
    self.password.text=''
    self.loginFocus = true

    self:redrawLogin()
end

function Login:execute(evt)

    if evt.class == 'key' and evt.type == 'press' then
        if evt.key == 'CURSOR_DOWN' then
            self.loginFocus = false

        elseif evt.key == 'CURSOR_UP' then
            self.loginFocus = true

        elseif evt.key == 'BLUE' then
            self.finished = true
            self.nextState = ST_PRODUCTDETAILS_STATE

        elseif evt.key == 'ENTER' then

        else
            self:handleInput(evt)
        end
    end
    self:redrawLogin()
    --evt.class = nil

end

function Login:onEnd()
    print("onEdn LOGIN")
end

function Login:isFinished()
    return self.finished
end

function Login:setFinished(f)
    self.finished = f
end

function Login:getNextState()
    return self.nextState
end

function Login:getData()
    return self.data[1]
end


-------------------------------------------------------------------

function Login:handleInput (evt)

    if evt.class ~= 'key'   then return end
    if evt.type  ~= 'press' then return end

    local key = evt.key
    if tonumber(key) then
        if (self.loginFocus == true) then
            self.input.text = self.input.text .. key
        else
            self.password.text = self.password.text .. key
        end
    elseif key == 'CURSOR_LEFT' then
        if (self.loginFocus == true) then
            self.input.text = string.sub(self.input.text, 1, -2)
        else
            self.password.text = string.sub(self.password.text, 1, -2)
        end
    end
end

function Login:redrawLogin()

    -- Imagem de navegacao
    img = canvas:new("images/autenticacao.png")
    dx, dy = img:attrSize()
    canvas:compose(0, 0, img)

    -- Pinta o texto do login
    canvas:attrColor(self.input.color)
    canvas:attrFont(self.input.face, self.input.dy)
    canvas:drawText(self.input.text, self.input.x, self.input.y)
    
    -- Pinta o texto da senha
    canvas:attrColor(self.password.color)
    canvas:attrFont(self.password.face, self.password.dy)
    canvas:drawText(self.password.text, self.password.x, self.password.y)

    canvas:flush()
end


-- The metatable to create callbacks
loginmt.__index = Login -- redirect queries to Login table

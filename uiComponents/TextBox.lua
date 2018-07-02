-------------------------------------------------------------------------------------
------ Class: TextBox
------
------ This is the base class for TextBox
------
------ | Date        | Author                  | Description
------
------  18/01/2009     Rafael Donato             Descricao Inicial
------
------
-----------------------------------------------------------------------------------------


TextBox = {}
textboxmt = {}

-- Class Constructor
function TextBox:new()


    local instance = {}
    setmetatable(instance, textboxmt) -- Associate this TextBox object with textboxmt metatable

    -- Set up a parameter
    instance.text = ""
    instance.limitLineLength = 40
    instance.color = 'black'
    instance.face = 'vera.ttf'
    instance.x = 0
    instance.y = 0

    return instance

end

function TextBox:setPosition(posX, posY)
    self.x = posX
    self.y = posY
end

function TextBox:setText(txt)
    self.text = txt
end

function TextBox:setFontColor(clr)
    self.color = clr
end

function TextBox:setFontFace(fce)
    self.face = fce
end

function TextBox:drawTextBox()                 -- funcao para desenho de textos

    canvas:attrColor(self.color)
    canvas:attrFont(self.face, 20)

    -- Description to be drawned
    --description = self.text

    -- Characters limit per line
    --limitLineLength = self.limitLineLength
    textLength = string.len (self.text)

    -- Look for the edge of the line
    i = 0
    count = 0
    while ((i<textLength) and (textLength > self.limitLineLength)) do

        if string.sub (self.text, self.limitLineLength - i , self.limitLineLength - i) == ' ' then
            line = string.sub (self.text, 1, self.limitLineLength - i)
            canvas:drawText(line, self.x, (self.y + (count*20)))
            --print(line)

            count = count + 1
            self.text = string.sub (self.text, self.limitLineLength - i + 1, textLength)
            textLength = string.len (self.text)
            i = 0

        end
        i = i + 1
    end
    canvas:drawText(self.text, self.x, (self.y + (count*20)))
    --canvas:flush()

end


-- The metatable to create callbacks
textboxmt.__index = TextBox -- redirect queries to TextBox table

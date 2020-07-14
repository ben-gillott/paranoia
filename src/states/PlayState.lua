--[[
Comment
]]


PlayState = Class{__includes = BaseState}

local gboard

function PlayState:enter()
    gboard = Board(25,25)
end

function PlayState:update(dt)    
    gboard:updateTargets()
    gboard:update(dt)

    if love.keyboard.wasPressed('w') then
        gboard:move("up")
    elseif love.keyboard.wasPressed('s') then
        gboard:move("down")
    elseif love.keyboard.wasPressed('a') then
        gboard:move("left")
    elseif love.keyboard.wasPressed('d') then
        gboard:move("right")
    end

end

--on move update board cornerxy


function PlayState:render()
    gboard:render()
end
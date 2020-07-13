--[[
Comment
]]


PlayState = Class{__includes = BaseState}

local gboard

function PlayState:enter()
    gboard = Board()
end

function PlayState:update(dt)
    Board:update()
end

--on move update board cornerxy


function PlayState:render()
    gboard:render()
end
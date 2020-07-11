--[[
Comment
]]


PlayState = Class{__includes = BaseState}

local gboard

function PlayState:enter()
    gboard = Board()
end

function PlayState:update(dt)

end

function PlayState:render()
    gboard:render()
end
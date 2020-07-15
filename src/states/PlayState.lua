--[[
Comment
]]


PlayState = Class{__includes = BaseState}

local gboard
local offsetLimit = 2
local offsetX = 0
local offsetY = 0
function PlayState:enter()
    gboard = Board(130,40)
end

function PlayState:update(dt)    
    gboard:updateTargets()
    gboard:update(dt)

    if love.keyboard.wasPressed('w') then
        if offsetY <= offsetLimit then
            gboard:move("up")
            offsetY = offsetY + 1
        end
        --TODO: Else add shake/feedback for each of these statements
    elseif love.keyboard.wasPressed('s') then
        if offsetY >= -offsetLimit then
            gboard:move("down")
            offsetY = offsetY - 1
        end

    elseif love.keyboard.wasPressed('a') then
        if offsetX >= -offsetLimit then
            gboard:move("left")
            offsetX = offsetX - 1
        end
    elseif love.keyboard.wasPressed('d') then
        if offsetX <= offsetLimit then
            gboard:move("right")
            offsetX = offsetX + 1
        end
    end
end



function PlayState:render()
    gboard:render()
end
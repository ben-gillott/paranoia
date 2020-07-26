--[[
Comment
]]

ScoreState = Class{__includes = BaseState}

function ScoreState:enter()
    
end

function ScoreState:update(dt)    
    if love.keyboard.wasPressed('return') then
        gStateMachine:change('play', {1})
    end
end


function ScoreState:render()
    love.graphics.setFont(gFonts['large'])
    love.graphics.printf("Game Over", 0, 70, VIRTUAL_WIDTH, 'center')
    love.graphics.printf("SCORE : ()", 0, 100, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf("Press Enter to Play Again", 0, 150, VIRTUAL_WIDTH, 'center')
end
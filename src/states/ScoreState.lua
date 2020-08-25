--[[
Comment
]]

ScoreState = Class{__includes = BaseState}

function ScoreState:enter(params)
    self.time = params.time
    self.test = params.test
end

function ScoreState:update(dt)    
    if love.keyboard.wasPressed('return') then
        gSounds['level_load']:play()
        gStateMachine:change('play', {1})
    end
end


function ScoreState:render()
    love.graphics.setFont(gFonts['large'])
    love.graphics.printf("Game Over", 0, 70, VIRTUAL_WIDTH, 'center')
    local score = self.time or '---'
    love.graphics.printf("Score : " .. tostring(score), 0, 110, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf("Press Enter to Play Again", 0, 160, VIRTUAL_WIDTH, 'center')
end
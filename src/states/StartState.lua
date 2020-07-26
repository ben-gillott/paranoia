--[[
Comment
]]

StartState = Class{__includes = BaseState}

function StartState:enter()
    
end

function StartState:update(dt)    
    if love.keyboard.wasPressed('return') then
        gSounds['level_load']:play()
        gStateMachine:change('play')
    end
end


function StartState:render()
    love.graphics.setFont(gFonts['large'])
    love.graphics.printf("Tile Game", 0, 50, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf("Press Enter To Start", 0, 90, VIRTUAL_WIDTH, 'center')
end
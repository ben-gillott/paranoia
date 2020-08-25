--[[
Comment
]]

TutorialState = Class{__includes = BaseState}

function TutorialState:enter()
    
end

function TutorialState:update(dt)    
    if love.keyboard.wasPressed('return') then
        gSounds['level_load']:play()
        gStateMachine:change('play')
    end
end


function TutorialState:render()
    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf("Tutorial", 0, 20, VIRTUAL_WIDTH, 'center')
    
    love.graphics.printf("Press Enter To Start", 0, 200, VIRTUAL_WIDTH, 'center')
end
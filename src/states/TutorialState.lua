--[[
Comment
]]
local anim_scale_min = 1
local anim_scale_max = 1.15
local anim_rate = .4

TutorialState = Class{__includes = BaseState}

function TutorialState:enter()
    self.anim_scale = 1
    self.anim_inceasing = true
end

function TutorialState:update(dt)    

    if self.anim_inceasing then
        self.anim_scale = self.anim_scale + dt*anim_rate
        if self.anim_scale > anim_scale_max then
            self.anim_inceasing = false
        end
    else
        self.anim_scale = self.anim_scale - dt*anim_rate
        if self.anim_scale < anim_scale_min then
            self.anim_inceasing = true
        end
    end

    if love.keyboard.wasPressed('return') then
        gSounds['level_load']:play()
        gStateMachine:change('play')
    end
end


function TutorialState:render()
    -- love.graphics.setColor(0,0,0)
    love.graphics.setFont(gFonts['medium'])
    
    --Tilesfall
    love.graphics.printf("watch your step", -100, 30, VIRTUAL_WIDTH, 'center')
    love.graphics.draw(gTextures['tile1'], 80, 60, 0, 4.25/10, 4.25/10)
    love.graphics.draw(gTextures['char'], 84, 60, 0, 1.2, 1.2)

    love.graphics.draw(gTextures['char'], 124, 60, 1, 1.2, 1.2)


    --Enemy 
    love.graphics.printf("avoid enemies", 100, 30, VIRTUAL_WIDTH, 'center')
    love.graphics.draw(gTextures['skull_left'], 280, 60, 0, .2, .2)
    love.graphics.draw(gTextures['skull_right'], 330, 60, 0, .2, .2)


    --WASD / Arrows
    love.graphics.printf("WASD or arrow keys to move", 0, 100, VIRTUAL_WIDTH, 'center')
    
    -- love.graphics.setColor(255,0,0)
    love.graphics.printf("collect all the tiles!", 0, 160, VIRTUAL_WIDTH, 'center')


    love.graphics.setColor(255,255,255)
    -- love.graphics.rectangle("fill", 178, 224, 10, 10)
    local textheight = 14
    local textwidth = 170
    local offsetx = (textwidth*self.anim_scale-textwidth)/(1.1)
    local offsety = (textheight*self.anim_scale-textheight)/(1.1)
    love.graphics.printf("Press Enter To Start", 0, 210, VIRTUAL_WIDTH, 'center', 0, self.anim_scale, self.anim_scale, offsetx, offsety)

end
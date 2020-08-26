--[[
Comment
]]
local anim_scale_min = 1
local anim_scale_max = 1.15
local anim_rate = .4


StartState = Class{__includes = BaseState}

function StartState:enter()
    self.anim_scale = 1
    self.anim_inceasing = true
end

function StartState:update(dt)    
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
        gStateMachine:change('tutorial')
    end
end


function StartState:render()
    love.graphics.setFont(gFonts['large'])
    love.graphics.printf("Needs a New Name", 0, 50, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gFonts['medium'])
    -- love.graphics.printf("Press Enter To Start", 0, 90, VIRTUAL_WIDTH, 'center')
    local textheight = 14
    local textwidth = 170
    local offsetx = (textwidth*self.anim_scale-textwidth)/(1.1)
    local offsety = (textheight*self.anim_scale-textheight)/(1.1)
    love.graphics.printf("Press Enter To Start", 0, 100, VIRTUAL_WIDTH, 'center', 0, self.anim_scale, self.anim_scale, offsetx, offsety)


end
--[[

]]
--TODO Export to constant
local pRadius = 10
local segNum = 8


Player = Class{}

function Player:init(state, centerX, centerY)
    self.state = state --Can be normal, dead
    self.x = centerX
    self.y = centerY
end

function Player:update(dt)
    
end

function Player:setState(stateIn)
    self.state = stateIn
end

function Player:getState()
    return self.state
end

function Player:render()
    -- love.graphics.draw(gTextures['main'], gFrames['balls'][self.skin],self.x, self.y)
    --TODO: check state
    if self.state == "normal" then
        love.graphics.setColor(0,0,255)
        love.graphics.circle('fill', self.x, self.y, pRadius, segNum)
    elseif self.state == "dead" then
        love.graphics.setColor(0,255,255)
        love.graphics.circle('fill', self.x, self.y, pRadius, segNum)
    end

end
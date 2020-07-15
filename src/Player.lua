--[[

]]

local pRadius = 10
local segNum = 8

Player = Class{}

function Player:init(state, centerX, centerY)
    self.state = state
    self.x = centerX
    self.y = centerY
end

function Player:update(dt)

end

function Player:render()
    -- love.graphics.draw(gTextures['main'], gFrames['balls'][self.skin],self.x, self.y)
    --TODO: check state
    love.graphics.setColor(0,0,255)
    love.graphics.circle('fill', self.x, self.y, pRadius, segNum)
end
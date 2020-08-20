--[[

]]
--TODO Export to constant
local pRadius = 10
local segNum = 8
local playerI = 3
local playerJ = 3
local startScale = 1.2
local offsetX = 5
local offsetY = 8

Player = Class{}

function Player:init(state, centerX, centerY, tile_gapIn, tile_sizeIn, cx, cy)
    self.tile_gap = tile_gapIn
    self.tile_size = tile_sizeIn
    self.state = state --Can be normal, dead
    self.x = centerX
    self.y = centerY
    self.corner_x = cx
    self.corner_y = cy
    self.scale = startScale
    self:resetCenter()

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
    -- if self.state == "normal" then
    --     love.graphics.setColor(0,0,255)
    --     love.graphics.circle('fill', self.x, self.y, pRadius, segNum)
    -- elseif self.state == "dead" then
    --     love.graphics.setColor(0,255,255)
    --     love.graphics.circle('fill', self.x, self.y, pRadius, segNum)
    -- end

    love.graphics.draw(gTextures['char'], self.x, self.y, 0, self.scale, self.scale, offsetX, offsetY)

end




-- ===== ---


function Player:resetCenter()
    playerI = 3
    playerJ = 3
end


function Player:getI()
    return playerI
end

function Player:getJ()
    return playerJ
end

function Player:move(dir)
    local shiftDist = self.tile_gap + self.tile_size

    if dir == "up" then
        self.y = self.y - shiftDist
        playerJ = playerJ-1 --center moves up in board
    elseif dir == "down" then
        self.y = self.y + shiftDist
        playerJ = playerJ+1 --center moves down in board
    elseif dir == "left" then
        self.x = self.x - shiftDist
        playerI = playerI - 1 --center moves left in board
    elseif dir == "right" then
        self.x = self.x + shiftDist
        playerI = playerI + 1 --center moves right in baord
    end
end

function Player:isOOB()
    return playerI < 1 or playerI > 5 or playerJ < 1 or playerJ > 5
end





--[[

]]
--TODO Export to constant
local enemyRadius = 7
local segNum = 4

Enemy = Class{}

function Enemy:init(i, j, TileGap, TileSize, InitBoardX, InitBoardY)
    self.i = i
    self.j = j
    self.tileGap = TileGap
    self.tileSize = TileSize
    self.state = "normal" --Can be normal, dead --TODO: Add faling state
    self.x = InitBoardX+i*TileGap+(i+.5)*TileSize
    self.y = InitBoardY+j*TileGap+(j+.5)*TileSize
end

function Enemy:update(dt)
    
end

function Enemy:setState(stateIn)
    self.state = stateIn
end

function Enemy:getState()
    return self.state
end

function Enemy:render()
    -- love.graphics.draw(gTextures['main'], gFrames['balls'][self.skin],self.x, self.y)
    --TODO: check state
    if self.state == "normal" then
        love.graphics.setColor(255,255,255)
        love.graphics.circle('fill', self.x, self.y, enemyRadius, segNum)

    elseif self.state == "dead" then
        love.graphics.setColor(255,255,255)
        love.graphics.circle('fill', self.x, self.y, enemyRadius/2, segNum)
    end

end
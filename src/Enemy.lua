--[[

]]
--TODO Export to constant
local enemyRadius = 7
local segNum = 4

Enemy = Class{}

function Enemy:init(i, j, dir, TileGap, TileSize, InitBoardX, InitBoardY)
    self.i = i
    self.j = j
    self.dir = dir
    self.tileGap = TileGap
    self.tileSize = TileSize
    self.state = "normal" --Can be normal, dead --TODO: Add faling state
    self.x = InitBoardX+self.i*TileGap+(self.i+.5)*TileSize
    self.y = InitBoardY+self.j*TileGap+(self.j+.5)*TileSize
end

function Enemy:update(dt)

end

function Enemy:setState(stateIn)
    self.state = stateIn
end

function Enemy:getState()
    return self.state
end

function Enemy:getI()
    return self.i
end
function Enemy:getJ()
    return self.j
end

function Enemy:move(dir, BoardCornerX, BoardCornerY)

    if dir == "up" then
        self.j = self.j-1
    elseif dir == "down" then
        self.j = self.j+1
    elseif dir == "left" then
        self.i = self.i - 1
    elseif dir == "right" then
        self.i = self.i + 1
    end

    self.x = BoardCornerX+self.i*TileGap+(self.i+.5)*TileSize
    self.y = BoardCornerY+self.j*TileGap+(self.j+.5)*TileSize
end

function Enemy:autoMove(BoardCornerX, BoardCornerY)
    if self.dir == "up" then
        self.j = self.j-1
    elseif self.dir == "down" then
        self.j = self.j+1
    elseif self.dir == "left" then
        self.i = self.i - 1
    elseif self.dir == "right" then
        self.i = self.i + 1
    end

    self.x = BoardCornerX+self.i*TileGap+(self.i+.5)*TileSize
    self.y = BoardCornerY+self.j*TileGap+(self.j+.5)*TileSize

    -- TODO: AI go brr
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
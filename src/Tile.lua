--[[

]]

Tile = Class{}


function Tile:init(tile_size, type, x, y)
    -- simple positional and dimensional variables
    self.tile_size = tile_size
    self.type = type
    self.x = x
    self.y = y
end

function Tile:update(dt)

end

function Tile:render()
    -- love.graphics.draw(gTextures['main'], gFrames['balls'][self.skin],self.x, self.y)
    --TODO: draw self based on current state, xy and dimensions
    love.graphics.rectangle('fill', self.x, self.y, self.tile_size, self.tile_size)
end
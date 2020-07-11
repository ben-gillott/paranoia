--[[

]]

Tile = Class{}

function Tile:init(params)
    -- simple positional and dimensional variables
    self.length = params.length;
    self.x = params.x;
    self.y = params.y;
end

function Tile:update(dt)

end

function Tile:render()
    -- love.graphics.draw(gTextures['main'], gFrames['balls'][self.skin],self.x, self.y)
    --TODO: draw self based on current state, xy and dimensions
end
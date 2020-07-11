--[[

]]

Player = Class{}

function Player:init(params)
    -- simple positional and dimensional variables
    self.tile_x = 0;
    self.tile_y = 0;

end

function Player:update(dt)

end

function Player:render()
    -- love.graphics.draw(gTextures['main'], gFrames['balls'][self.skin],self.x, self.y)
    --TODO: draw self based on current state
end
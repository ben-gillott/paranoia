
Board = Class{}

local map = {}
-- local tiletest

function Board:init()
    self.board_w = 5
    self.board_h = 5
    self.corner_x = 0
    self.corner_y = 0
    self.tile_gap = 5
    self.tile_size = 20

    for i=1,5 do
        map[i] = {}
        for j=1,5 do
            map[i][j] = Tile(self.tile_size, 0, self.corner_x + (self.tile_gap+self.tile_size)*i, self.corner_y + (self.tile_gap+self.tile_size)*j)
        end
    end

end

function Board:update(dt)
--loop and update all tiles tx ty to match equat match board corner
    self.corner_x = 100
    self:testFunc()
end

function Board:testFunc()
    offsetx = self.corner_x + (self.tile_gap+self.tile_size);
    offsety = self.corner_y + (self.tile_gap+self.tile_size);

    for i=1,5 do
        for j=1,5 do
            -- print(self.tile_gap)
            map[i][j]:setTarget(offsetx*i, offsety*j)
        end
    end
end

function Board:move(dir_string)

end


function Board:render()
    for i=1,5 do
        for j=1,5 do
            map[i][j]:render()
        end
    end
end

Board = Class{}

function Board:init()
    self.board_w = num
    self.board_h = 5
    self.corner_x = 0
    self.corner_y = 0
    self.tile_gap = 5

    self.map = {}
    for i=1,5 do
        map[i] = {}
        for j=1,5 do
            map[i][j] = 0
        end
    end
    print(map[5][5])

end

function Board:update(dt)

end

function Board:render()
    
end
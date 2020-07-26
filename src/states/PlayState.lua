--[[
Comment
]]


PlayState = Class{__includes = BaseState}

-- local board
-- local player
--Check the offset of the board and if it is out of bounds
--TODO: In prog - use offsets to get death

--Coordinates that are at the center of the screen rn
local i = 3
local j = 3
-- local offsetLimit = 2
-- local offsetX = 0
-- local offsetY = 0

--TODO:
TileGap = 1
TileSize = 20
InitBoardX = 120
InitBoardY = 30


function PlayState:init()
    i = 3
    j = 3
    self.board = Board(TileGap, TileSize, InitBoardX, InitBoardY)
    self.player = Player("normal", InitBoardX+3*TileGap+3.5*TileSize, InitBoardY+3*TileGap+3.5*TileSize)
    self.enemy = Enemy(1, 1, TileGap, TileSize, InitBoardX, InitBoardY)
    
    --TODO: remove, Manual danger testing
    self.board:manualDanger(1,5)
end


function PlayState:update(dt)    
    self.board:updateTargets()
    
    self.board:update(dt)
    --#Get keyboard movement
    if love.keyboard.wasPressed('w') then
        self:moveBoard("up")
    elseif love.keyboard.wasPressed('s') then
        self:moveBoard("down")
    elseif love.keyboard.wasPressed('a') then
        self:moveBoard("left")
    elseif love.keyboard.wasPressed('d') then
        self:moveBoard("right")
    end


    --check OOB
    if self.board:isOOB() then --is off the board, fall off
        self.player:setState("dead")
    end
    --Check if on danger 
    if self.board:onDanger() then --is on board but on danger tile
        self.player:setState("dead")
    end
    --for testing - reset to alive after death TODO: REMOVE THIS FOR PROD
    if (not self.board:onDanger()) and (not self.board:isOOB()) then
        self.player:setState("normal")
    end

    if self.player:getState() == "dead" then
        gSounds['player_death']:play()
        gStateMachine:change('score', {})
    end

end

--Move the board in a direction
function PlayState:moveBoard(dir)
    gSounds['player_move']:play()

    if dir == "up" then
        self.board:move("up")
    elseif dir == "down" then
        self.board:move("down")
    elseif dir == "left" then
        self.board:move("left")
    elseif dir == "right" then
        self.board:move("right")
    end

end

function PlayState:render()
    self.board:render()
    self.player:render()
    self.enemy:render()
end
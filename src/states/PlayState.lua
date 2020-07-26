--[[
Comment
]]


PlayState = Class{__includes = BaseState}

-- local gboard
-- local gplayer
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
    self.gboard = Board(TileGap, TileSize, InitBoardX, InitBoardY)
    self.gplayer = Player("normal", InitBoardX+3*TileGap+3.5*TileSize, InitBoardY+3*TileGap+3.5*TileSize)

    --TODO: Manual danger testing
    self.gboard:manualDanger(1,5)
end


function PlayState:update(dt)    
    self.gboard:updateTargets()
    
    self.gboard:update(dt)
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
    if self.gboard:isOOB() then --is off the board, fall off
        self.gplayer:setState("dead")
    end
    --Check if on danger 
    if self.gboard:onDanger() then --is on board but on danger tile
        self.gplayer:setState("dead")
    end
    --for testing - reset to alive after death TODO: REMOVE THIS FOR PROD
    if (not self.gboard:onDanger()) and (not self.gboard:isOOB()) then
        self.gplayer:setState("normal")
    end

    if self.gplayer:getState() == "dead" then
        gSounds['player_death']:play()
        gStateMachine:change('score', {})
    end

end

--Move the board in a direction
function PlayState:moveBoard(dir)
    gSounds['player_move']:play()

    if dir == "up" then
        self.gboard:move("up")
    elseif dir == "down" then
        self.gboard:move("down")
    elseif dir == "left" then
        self.gboard:move("left")
    elseif dir == "right" then
        self.gboard:move("right")
    end

end

function PlayState:render()
    self.gboard:render()
    self.gplayer:render()
end
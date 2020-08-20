--[[
Comment
]]


PlayState = Class{__includes = BaseState}

-- local board
-- local player
--Check the offset of the board and if it is out of bounds
--Coordinates that are at the center of the screen rn
-- local i = 3
-- local j = 3
-- local offsetLimit = 2
-- local offsetX = 0
-- local offsetY = 0

TileGap = 1
TileSize = 20
InitBoardX = 120
InitBoardY = 30

EnemySpawnDelay = 6


function PlayState:init()
    self.timer = 0
    self.spawntimer = 0
    self.i = 3
    self.j = 3
    self.board = Board(TileGap, TileSize, InitBoardX, InitBoardY)
    self.player = Player("normal", InitBoardX+3*TileGap+3.5*TileSize, InitBoardY+3*TileGap+3.5*TileSize, TileGap, TileSize, InitBoardX, InitBoardY)
    self.enemies = {}
    
    -- self:addEnemy(5, 3, "left")
    
    -- self.board:manualDanger(1,5)
    -- self.board:manualFalling(2,5)
    --TODO: Remove
    self:addEnemy(1, 1, "left")
    self:addEnemy(2, 1, "right")
end

function PlayState:render()
    self.board:render()
    self.player:render()
    for k,enemy in pairs(self.enemies) do
        enemy:render()
    end
end

function PlayState:update(dt)    
    self.board:updateTargets()
    self.board:update(dt)

    self.timer = self.timer + dt
    
    self.spawntimer = self.spawntimer + dt
    if self.spawntimer >= EnemySpawnDelay then
        self.spawntimer = 0
        -- self:addRandomEnemy()
    end


    --#Get keyboard movement
    if love.keyboard.wasPressed('w') then
        self.player:move("up")
    elseif love.keyboard.wasPressed('s') then
        self.player:move("down")
    elseif love.keyboard.wasPressed('a') then
        self.player:move("left")
    elseif love.keyboard.wasPressed('d') then
        self.player:move("right")
    end


    --check OOB or danger tile for character
    if self.player:isOOB() or self.board:onDanger(self.player:getI(), self.player:getJ()) then --is off the board, fall off
        PlayState:gameOver()
    end

    --Tron falling tiles
    if (not self.board:onFalling(self.player:getI(), self.player:getJ()) and (not self.board:onDanger(self.player:getI(), self.player:getJ()))) then
        self.board:manualFalling(self.player:getI(), self.player:getJ())
    end

    --Check for each enemy
    for k,enemy in pairs(self.enemies) do
        --Enemy died
        if enemy:getState() == "dead" then
            --Remove from db
            table.remove(self.enemies, k)
        end
        --Enemy fell
        if self.board:isOOB(enemy:getI(), enemy:getJ()) or self.board:onDanger(enemy:getI(), enemy:getJ()) then
            enemy:setState("falling")
        end
        --Enemy kills player
        if enemy:getI() == self.player:getI() and enemy:getJ() == self.player:getJ() and (enemy:getState() == "normal") then
            --TODO: Implement death delay and animation
            
            PlayState:gameOver()
        end
        --Update each enemy
        
        if enemy:isMoveTime() then
            enemy:autoMove(self.board:getCornerX(), self.board:getCornerY())
        end

        enemy:update(dt)
    end
end




function PlayState:gameOver()
    -- self.player:setState("dead")
    gSounds['player_death']:play()
    gStateMachine:change('score', {})
end
--===========--===========--===========

--Move the board in a direction
function PlayState:movePlayer(dir)
    gSounds['player_move']:play()
    local oppositeDir = "temp"
    if dir == "up" then
        self.player:move("up")
        oppositeDir = "down"
    elseif dir == "down" then
        self.player:move("down")
        oppositeDir = "up"
    elseif dir == "left" then
        self.player:move("left")
        oppositeDir = "right"
    elseif dir == "right" then
        self.player:move("right")
        oppositeDir = "left"
    end

    --No longer needed since Pivot 3.0
    -- for k, enemy in pairs(self.enemies) do
    --     enemy:move(oppositeDir, self.board:getCornerX(), self.board:getCornerY())
    -- end
end




function PlayState:addRandomEnemy()
    --Random left right
    local ix = math.random(2)
    local dir = "left"
    local i = 5
    if ix == 2 then
        dir = "right"
        i = 1
    end
    
    local ij = math.random(5)

    self:addEnemy(i, ij ,dir)
end

function PlayState:addEnemy(i, j, direction)
    self.enemies[#self.enemies+1] = Enemy(i, j, direction, TileGap, TileSize, InitBoardX, InitBoardY)
end

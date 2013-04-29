--------------------------------------------------------------------------------
-- player.lua
-- author: keith w. thompson

KEY_PLAYER_LEFT = 97 -- a
KEY_PLAYER_RIGHT = 100 -- d
KEY_PLAYER_UP = 119 -- w
KEY_PLAYER_DOWN = 115 -- s
KEY_PLAYER_JUMP = 32 -- [space]

PLAYER_MOVE_LEFT = 0
PLAYER_MOVE_RIGHT = 1

PLAYER_STATE_BLOCK = SHAPE_SQUARE
PLAYER_STATE_BALL  = SHAPE_CIRCLE
PLAYER_STATE_SPIKE = SHAPE_TRIANGLE
PLAYER_STATE_MORPH = SHAPE_MORPH

function createPlayer ( shape )
  local player = {}
  player.shape = makeShape( shape )
  player.state = shape
  player.state_new = shape
--  player.shape:setLoc ( 0.0, -100.0 )
  player.shape:setScl ( 16, 16 )
  player.shape:setColor ( 0.6, 0.7, 0.22 )
  layers[LAYER_MAIN]:insertProp ( player.shape )

  -- Physics
  player.shape:addPhysics ( 0.0, -100, 16 )
--  player.shape:activate ()

  function player:main ()
--    printf("player::main: %f\n", time:getTime())
    -- input
    if MOAIInputMgr.device.keyboard:keyIsDown ( KEY_PLAYER_LEFT ) then
      self:move ( PLAYER_MOVE_LEFT )
--      self.shape:applyLocalForce ( 100, 0, 0, -8 )
    elseif MOAIInputMgr.device.keyboard:keyIsDown ( KEY_PLAYER_RIGHT) then
      self:move ( PLAYER_MOVE_RIGHT )
--      self.shape:applyLocalForce ( -100, 0, 0, -8 )
    end

    -- state machine
    if PLAYER_STATE_MORPH == self.state then
      if self.shape:isMorphComplete () then
        self.state = self.state_new
      end
    else
      if self.state_new ~= self.state then
        self.shape:morph ( self.state_new, 0.33 )
        self.state = PLAYER_STATE_MORPH
      else
        if PLAYER_STATE_BLOCK == self.state then
        elseif PLAYER_STATE_BALL == self.state then
        elseif PLAYER_STATE_SPIKE == self.state then
        else
        end
      end
    end
  end

  function player:move ( dir )
    if PLAYER_MOVE_LEFT == dir then
      self.shape:applyLocalForce ( -300, -1, 0, 0 )
--      self.shape.body:applyAngularImpulse ( 100000 )
--      self.shape.body:setAngularVelocity ( -10 )
    elseif PLAYER_MOVE_RIGHT == dir then
      self.shape:applyLocalForce ( 300, -1, 0, 0 )
--      self.shape.body:applyAngularImpulse ( -100000 )
--      self.shape.body:setAngularVelocity ( 10 )
    end
  end

  function player:onKey ( key, down )
    if true == down then
      -- JUMP
      if KEY_PLAYER_JUMP == key then
--        self.shape:morph ( SHAPE_CIRCLE )
        self.state_new = self.state + 1
        if self.state_new > PLAYER_STATE_SPIKE then
          self.state_new = PLAYER_STATE_BLOCK
        end
        local wx, wy = self.shape.body:getPosition ()
        self.shape.body:applyLinearImpulse ( 0, -300, wx, wy )
      end
    end
  end

  function player:clear ()
    layers[LAYER_MAIN]:removeProp ( player.shape )
    player.shape:removePhysics ()
  end

  playerThread = MOAIThread.new ()
  playerThread:run (
    function ()
      while true do
        player:main ()
        coroutine.yield ()
      end
    end
  )

  return player
end


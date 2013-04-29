--------------------------------------------------------------------------------
-- world.lua
-- author: keith w. thompson

function makeWorld ()

  local world = {}
  world.level_id = 1
  world.b2d = MOAIBox2DWorld.new ()
  world.b2d:setGravity ( 0, 10.0 )
  world.b2d:setUnitsToMeters ( 1.0/100.0 )
--  world.b2d:setDebugDrawFlags( MOAIBox2DWorld.DEBUG_DRAW_SHAPES +
--                               MOAIBox2DWorld.DEBUG_DRAW_CENTERS )
  world.b2d:setDebugDrawEnabled ( false )
  layers[LAYER_MAIN]:setBox2DWorld( world.b2d )

    -- setup ground
  ground = {}
  ground.verts = {
      -550, 100,
      550, 100
  }
  ground.body = world.b2d:addBody( MOAIBox2DBody.STATIC, 0, 60 )
  ground.fixtures = {
      ground.body:addChain( ground.verts )
  }
  ground.fixtures[1]:setFriction( 0.8 )

  function world:start ()
    self.b2d:start ()
  end

  function world:stop ()
    self.b2d:stop ()
  end

  function world:clear ()
    layers[LAYER_MAIN]:clear ()
    ground.body:destroy ()
  end

  function world:loadLevel ( id )
    self.level_id = id

    -- load level data
  end

  function world:nextLevel ()
    -- load levle data
    self.loadLevel ( self.level_id + 1 )
  end

  return world
end


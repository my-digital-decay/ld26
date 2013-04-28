--------------------------------------------------------------------------------
-- player.lua
-- author: keith w. thompson

--dofile "shapes.lua"

function createPlayer ()
  local player = makeShape(SHAPE_SQUARE)
  player:setLoc ( 0.0, -100.0 )
  player:setScl ( 16, 16 )
  player:setColor ( 0.6, 0.7, 0.22 )
  layer:insertProp ( player )

  function player:main ()
--    printf("player::main: %f\n", time:getTime())
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


--------------------------------------------------------------------------------
-- input.lua
-- author: keith w. thompson

function onKeyboardEvent ( key, down )
--[[
  if true == down then
    printf ( "key: %d [down]\n", key)
  else
    printf ( "key: %d [up]\n", key)
  end
--]]
  if true == down then
    -- ESC
    if 27 == key then
      player:morph ( SHAPE_TRIANGLE )
      box:morph ( SHAPE_CIRCLE )
      ball:morph ( SHAPE_TRIANGLE )
      spike:morph ( SHAPE_SQUARE )
    end
  end
end

MOAIInputMgr.device.keyboard:setCallback ( onKeyboardEvent )


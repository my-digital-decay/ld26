--------------------------------------------------------------------------------
-- input.lua
-- author: keith w. thompson

function printf ( ... )
  return io.stdout:write ( string.format (...))
end

function onKeyboardEvent ( key, down )
  if true == down then
    printf ( "key: %d [down]\n", key)
  else
    printf ( "key: %d [up]\n", key)
  end

  if true == down then
    -- ESC
    if 27 == key then
--      box:setTexture ( "circle.png" )
    end
  end
end

MOAIInputMgr.device.keyboard:setCallback ( onKeyboardEvent )


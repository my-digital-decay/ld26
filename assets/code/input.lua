--------------------------------------------------------------------------------
-- input.lua
-- author: keith w. thompson


KEY_BACK = 27 -- [esc]
KEY_SELECT = 13 -- [return]
KEY_SPACE = 32 -- [space]

function onKeyboardEvent ( key, down )
--[[
  if true == down then
    printf ( "key: %d [down]\n", key)
  else
    printf ( "key: %d [up]\n", key)
  end
--]]
  if true == down then
    if KEY_BACK == key then
      -- quit / back
      if GAME_STATE_BACKEND == game_state then
        game_state_new = GAME_STATE_FRONTEND
      elseif GAME_STATE_FRONTEND == game_state then
        game_state_new = GAME_STATE_QUIT
      end
    end

    if KEY_SELECT == key or KEY_SPACE == key then
      if GAME_STATE_FRONTEND == game_state then
        game_state_new = GAME_STATE_BACKEND
      end
    end
  end

  if nil ~= player then
    player:onKey ( key, down )
  end
end

MOAIInputMgr.device.keyboard:setCallback ( onKeyboardEvent )


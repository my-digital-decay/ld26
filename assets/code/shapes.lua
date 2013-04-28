--------------------------------------------------------------------------------
-- shapes.lua
-- author: keith w. thompson

--
-- Squares
--

SHAPE_SQUARE = 1

function square_onDraw ( index, xOff, yOff, xFlip, yFlip )
  MOAIGfxDevice.setPenWidth ( 2 )
  MOAIDraw.drawRect ( -1, -1, 1, 1 )
end

local squareDeck = MOAIScriptDeck.new ()
squareDeck:setRect ( -1, -1, 1, 1 )
squareDeck:setDrawCallback ( square_onDraw )
squareDeck.morphTargets = {
    0.0, -1.0, -- top (center)
    0.5, -1.0,
    1.0, -1.0,
    1.0, -0.5,
    1.0,  0.0, -- right (center)
    1.0,  0.5,
    1.0,  1.0,
    0.5,  1.0,
    0.0,  1.0, -- bottom (center)
   -0.5,  1.0,
   -1.0,  1.0,
   -1.0,  0.5,
   -1.0,  0.0, -- left (center)
   -1.0, -0.5,
   -1.0, -1.0,
   -0.5, -1.0,
    0.0, -1.0, -- top (center)
}


--
-- Circles
--

SHAPE_CIRCLE = 2

function circle_onDraw ( index, xOff, yOff, xFlip, yFlip )
  MOAIGfxDevice.setPenWidth ( 2 )
  MOAIDraw.drawCircle ( 0, 0, 1, 32 )
end

local circleDeck = MOAIScriptDeck.new ()
circleDeck:setRect ( -1, -1, 1, 1 )
circleDeck:setDrawCallback ( circle_onDraw )
local sect = {
  math.cos(math.pi/2.0), -math.sin(math.pi/2.0),
  math.cos(3.0 * math.pi/8.0), -math.sin(3.0 * math.pi/8.0),
  math.cos(math.pi/4.0), -math.sin(math.pi/4.0),
  math.cos(math.pi/8.0), -math.sin(math.pi/8.0),
  math.cos(0), math.sin(0),
}
circleDeck.morphTargets = {
     sect[1],  sect[2],  -- top (center)
     sect[3],  sect[4],
     sect[5],  sect[6],
     sect[7],  sect[8],
     sect[9],  sect[10], -- right (center)
     sect[7], -sect[8],
     sect[5], -sect[6],
     sect[3], -sect[4],
     sect[1], -sect[2],  -- bottom (center)
    -sect[3], -sect[4],
    -sect[5], -sect[6],
    -sect[7], -sect[8],
    -sect[9],  sect[10], -- left (center)
    -sect[7],  sect[8],
    -sect[5],  sect[6],
    -sect[3],  sect[4],
     sect[1],  sect[2],  -- top (center)
}

--
-- Triangles
--

SHAPE_TRIANGLE = 3

function triangle_onDraw ( index, xOff, yOff, xFlip, yFlip )
  MOAIGfxDevice.setPenWidth ( 2 )
  MOAIDraw.drawLine {-1, 1, 0, -1, 1, 1, -1, 1}
end

local triangleDeck = MOAIScriptDeck.new ()
triangleDeck:setRect ( -16, -16, 16, 16 )
triangleDeck:setDrawCallback ( triangle_onDraw )
triangleDeck.morphTargets = {
    0.0   , -1.0,   -- top (center)
    0.1666, -0.6666,
    0.3333, -0.3333,
    0.5   ,  0.0,
    0.6666,  0.3333,
    0.8333,  0.6666,
    1.0   ,  1.0,   -- bottom (right)
    0.5   ,  1.0,
    0.0   ,  1.0,   -- bottom (center)
    0.5   ,  1.0,
   -1.0   ,  1.0,   -- bottom (left)
   -0.8333,  0.6666,
   -0.6666,  0.3333,
   -0.5   ,  0.0,
   -0.3333, -0.3333,
   -0.1666, -0.6666,
    0.0   , -1.0,   -- top (center)
}

function getShapeDeck ( shape )
  if ( SHAPE_SQUARE == shape ) then
    return squareDeck
  elseif ( SHAPE_CIRCLE == shape ) then
    return circleDeck
  elseif ( SHAPE_TRIANGLE == shape ) then
    return triangleDeck
  else
    printf("getShapeDeck - shape error!")
  end

    return nil
end

--
-- Morph
--

SHAPE_MORPH = 4

function makeMorphDeck ( index )

  printf("makeMorphDeck: %d\n", index)

  local morphDecks = {}
  morphDecks[index] = MOAIScriptDeck.new ()

  local deck = morphDecks[index]
  deck:setRect ( -1, -1, 1, 1 )
  deck.morphSrc = {}
  deck.morphDest = {}
  deck.morphLines = {}

  function deck:onUpdate ()
    local t = self.timer:getTime()
    for i = 1, 34 do
      self.morphLines[i] = lerp(self.morphSrc[i], self.morphDest[i], t)
    end
  end

  function morph_onDraw ( index, xOff, yOff, xFlip, yFlip )
--    printf("morph_onDraw: %d\n", index)
    local deck = morphDecks[index]
    deck:onUpdate ()
    MOAIGfxDevice.setPenWidth ( 2 )
    MOAIDraw.drawLine (deck.morphLines)
  end
  deck:setDrawCallback ( morph_onDraw )

  deck.timer = MOAITimer.new ()
  deck.timer:setSpan (1.0)
  deck.timer:setSpeed (4)

  local curve = MOAIAnimCurve.new ()
  curve:reserveKeys ( 2 )
  curve:setKey ( 1, 0.0, 0.0 , MOAIEaseType.EASE_OUT )
  curve:setKey ( 2, 1.0, 1.0, MOAIEaseType.EASE_IN )
  deck.timer:setCurve (curve)

  function deck:start ()
    self.timer:start ()
  end

  return deck
end

--
-- Make Shape Prop
--

local shapeIdx = 1;

function makeShape ( shape )

  printf("makeShape: %d\n", shapeIdx)

  s = MOAIProp2D.new ()
  s.shape = shape;
  s:setDeck ( getShapeDeck ( shape ) )

  s:setIndex (shapeIdx)
  shapeIdx = shapeIdx + 1

  function s:morph ( shape )
    if ( self.shape ~= shape ) then
--      printf("s:morph: %d\n", self:getIndex())
      local morphDeck = makeMorphDeck (self:getIndex())
      morphDeck.morphSrc = getShapeDeck(self.shape).morphTargets
      morphDeck.morphDest = getShapeDeck(shape).morphTargets
      self:setDeck ( morphDeck )
      morphDeck:start ()
    end
  end

  return s
end


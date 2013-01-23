module Bacon (
      EventStream
    , eventStream
    , onValue

    , MouseMoveEvent, clientX, clientY
    , mousemoveEventStream
    ) where

import Language.Fay.FFI

import JQuery (JQuery)

data EventStream a
instance Foreign a => Foreign (EventStream a)

-- | Wrapper for Bacon's "asEventStream"
-- Consider to use the more specific (~ more type-safe) versions instead!
eventStream :: Foreign a => String -> JQuery -> Fay (EventStream a)
eventStream = ffi "%2['asEventStream'](%1)"

-- | Wrapper for Bacon's "onValue"
onValue :: Foreign a => EventStream a -> (a -> Fay ()) -> Fay ()
onValue = ffi "%1['onValue'](%2)"


-- | 'mousemove' event type
data MouseMoveEvent = MME { clientX :: Int
                          , clientY :: Int
                          }
  deriving (Show)
-- TODO The above is a rather (;-)) incomplete definition
instance Foreign MouseMoveEvent

mousemoveEventStream :: JQuery -> Fay (EventStream MouseMoveEvent)
mousemoveEventStream = eventStream "mousemove"

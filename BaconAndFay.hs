module BaconAndFay where

import Prelude  -- Strange, but required (fixes issue with "$")
import Language.Fay.FFI

-- FFI bindings are in some helper modules...
import Bacon (MouseMoveEvent, clientX, clientY, mousemoveEventStream, onValue)
import JQuery (JQuery, ready, select, text)

-- | This function, when given a JQuery element and a MouseMoveEvent,
-- will display the 'clientX' and 'clientY' locations contained in the event
-- in the given element.
updatePointer :: JQuery -> MouseMoveEvent -> Fay ()
updatePointer container event = void $ text container pos
  where
    pos = "Mouse @ " ++ show (clientX event) ++ ":" ++ show (clientY event)

    -- Control.Monad.void
    void m = m >>= \_ -> return ()


-- | Entry point of our "application"
main :: Fay ()
main = ready $ do -- Remember "ready" is like "JQuery(function() { ... });"
    -- var body = $("body")
    body <- select "body"
    -- var evts = body.asEventStream("mouseover")
    evts <- mousemoveEventStream body

    -- var value = $("#value")
    value <- select "#value"

    -- evts.onValue(function(event) { return updatePointer(value, event); })
    onValue evts (updatePointer value)

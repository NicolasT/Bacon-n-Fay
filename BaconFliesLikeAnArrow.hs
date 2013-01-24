module BaconFliesLikeAnArrow where

import Prelude hiding (map)
import Language.Fay.FFI

import JQuery
import Bacon

setCss :: JQuery -> String -> EventStream String -> Fay ()
setCss elem prop stream = onValue stream $ void . css elem prop
  where
    void m = m >>= \_ -> return ()

main :: Fay ()
main = ready $ do
    container <- select "#container"

    mouseMove <- mousemoveEventStream container

    forM_ (zip [0..] "Bacon Flies Like an Arrow") $ \(i, char) -> do
        s <- select "<span>"
        text s [char]
        css s "position" "absolute"
        appendTo s container

        stream <- delay mouseMove (100 * i)

        map (\event -> show (clientX event + i * 10 + 15) ++ "px") stream >>= setCss s "left"
        map (\event -> show (clientY event) ++ "px") stream >>= setCss s "top"

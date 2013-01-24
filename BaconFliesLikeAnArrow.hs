module BaconFliesLikeAnArrow where

import Prelude
import Language.Fay.FFI

import JQuery
import Bacon

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
        onValue stream $ \event -> do
            css s "top" $ show (clientY event) ++ "px"
            css s "left" $ show (clientX event + i * 10 + 15) ++ "px"
            return ()

module JQuery (
      JQuery
    , select
    , ready
    , text
    ) where

import Language.Fay.FFI

data JQuery
instance Foreign JQuery
instance Show JQuery

-- | Wrapper around "JQuery(...)" as a selector
select :: String -> Fay JQuery
select = ffi "jQuery(%1)"

-- | Wrapper around "JQuery(...)" as a "document.ready" handler
ready :: Fay () -> Fay ()
ready = ffi "jQuery(%1)"

-- | Wrapper around "JQuery.text"
text :: JQuery -> String -> Fay JQuery
text = ffi "%1.text(%2)"


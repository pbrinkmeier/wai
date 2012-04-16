{-# LANGUAGE OverloadedStrings #-}
module Network.Wai.Middleware.MethodOverride
    ( methodOverride
    ) where

import Network.Wai
import Control.Monad (join)

-- | Allows overriding of the HTTP request method via the _method query string
-- parameter.
methodOverride :: Middleware
methodOverride app req =
    app req'
  where
    req' =
        case join $ lookup "_method" $ queryString req of
            Nothing -> req
            Just m -> req { requestMethod = m }

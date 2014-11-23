{-# LANGUAGE OverloadedStrings #-}

module Main where

import Web.Scotty
import Network.Wai
import Data.Text.Encoding (decodeUtf8)
import Data.Text.Lazy (fromStrict, unpack)
import Control.Monad.IO.Class (liftIO)

main = scotty 3000 $ do
  get "/" $ do
    setHeader "Content-Type" "text/html"
    file "index.html"

  get (regex "^/tiles.*") $ do
    req <- request
    let p = decodeUtf8 $ rawPathInfo req 
    liftIO $ print p
    file $ fp p

  where fp p = "." ++ (unpack $ fromStrict p)
  

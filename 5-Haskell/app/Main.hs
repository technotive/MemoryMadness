-- Based on hoogle.haskell.org/ library lookups.
-- Examples online are outdated, but you can do a lot by looking at function types.
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use null" #-}

module Main where
import Helper -- See Helper.hs for more information as well
import Network.Socket
import Network.Socket.ByteString
import qualified Data.ByteString as Bytes
import Data.ByteString.UTF8 as UTF8 hiding (take)
import Data.Char
import Control.Monad

maxConnectionsPending :: Int
maxConnectionsPending = 8

port :: PortNumber
port = 9001

main :: IO ()
main = do
    endpoint <- socket AF_INET Stream 0
    bind endpoint (SockAddrInet port inAddrAny)
    listen endpoint maxConnectionsPending
    putStrLn $ "Listening on port " ++ show port ++ " on any interface."
    myListen endpoint

myListen :: Socket -> IO ()
myListen endpoint = forever $ do
    (handler, info) <- accept endpoint
    logConnected info
    communicate handler
    logDisconnected info
    close handler

communicate :: Socket -> IO ()
communicate handler = do
    request <- recv handler 256
    when (Bytes.length request > 0) $ do
        logRequest request
        let response = processRequest request
        send handler response
        communicate handler
        

processRequest :: Bytes.ByteString -> Bytes.ByteString
processRequest request
    | size == [] = UTF8.fromString "\n"
    | otherwise  = UTF8.fromString $ take len text ++ "\n"
    where len  = read size
          text = takeWhile isAlpha req'
          size = takeWhile isDigit $ dropWhile (not . isDigit) req'
          req' = UTF8.toString request

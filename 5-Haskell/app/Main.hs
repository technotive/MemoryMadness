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
    bind endpoint (SockAddrInet port Helper.inAddrAny)
    listen endpoint maxConnectionsPending
    putStrLn $ "Listening on port " ++ show port ++ " on any interface."
    listenForConnectionsOn endpoint

listenForConnectionsOn :: Socket -> IO ()
listenForConnectionsOn endpoint = forever $ do
    (handler, info) <- accept endpoint
    putStrLn Helper.green
    putStrLn $ "Client " ++ Helper.clientIp info ++ " connected"
    putStrLn Helper.blue
    communicate handler
    putStrLn Helper.red
    putStrLn $ "Client " ++ Helper.clientIp info ++ " disconnected"
    putStrLn Helper.reset

communicate :: Socket -> IO ()
communicate handler = do
    request <- recv handler 256
    log' request
    let response = processRequest request
        nextAction = decideNextAction request
    send handler response
    nextAction handler

log' :: Bytes.ByteString -> IO ()
log' request
    | byteCount > 0 = putStrLn $ "\nReceived " ++ show byteCount ++ " bytes\n" ++ show request
    | otherwise     = putStrLn "\nReceived nothing."
    where byteCount = Bytes.length request

processRequest :: Bytes.ByteString -> Bytes.ByteString
processRequest request
    | size == [] = UTF8.fromString "\n"
    | otherwise  = UTF8.fromString $ take n text ++ "\n"
    where n    = read size
          text = takeWhile isAlpha req'
          size = takeWhile isDigit $ dropWhile (not . isDigit) req'
          req' = UTF8.toString request

decideNextAction :: Bytes.ByteString -> (Socket -> IO ())
decideNextAction request
    | byteCount > 0 = communicate
    | otherwise     = close
    where byteCount = Bytes.length request

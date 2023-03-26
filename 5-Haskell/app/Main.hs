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
    putStrLn $ "Client " ++ Helper.clientName info ++ " connected"
    putStrLn Helper.blue
    receiveDataOn handler
    putStrLn Helper.red
    putStrLn $ "Client " ++ Helper.clientName info ++ " disconnected"
    putStrLn Helper.reset

receiveDataOn :: Socket -> IO ()
receiveDataOn handler = do
    request <- recv handler 256
    log request
    let response = processRequest request
        nextAction = decideNextAction request
    nextAction handler

log :: Bytes.ByteString -> IO ()
log request
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
    | byteCount > 0 = receiveDataOn
    | otherwise     = close
    where byteCount = Bytes.length request


-- onRequest :: Bytes.ByteString -> Socket -> IO ()
-- onRequest request handler 
--     | byteCount > 0 = do
--         putStrLn $ "Received " ++ show byteCount ++ " bytes\n" ++ request'
--         respond request' handler
--     | otherwise     = close handler
--     where byteCount = Bytes.length request
--           request'  = UTF8.toString request

-- respond :: String -> Socket -> IO ()
-- respond request handler = do
--     send handler (responseFrom request)
--     receiveDataOn handler

-- responseFrom :: String -> ByteString
-- responseFrom request
--     | size == [] = UTF8.fromString "\n"
--     | otherwise  = UTF8.fromString $ take n text ++ "\n"
--     where n = read size
--           text = takeWhile isAlpha request
--           size = takeWhile isDigit $ dropWhile (not . isDigit) request
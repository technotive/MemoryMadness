module Main where
import Helper
import Network.Socket
import Network.Socket.ByteString
import qualified Data.ByteString as Bytes
import Data.ByteString.UTF8 as UTF8 hiding (take)
import Data.Char

maxConnectionsPending :: Int
maxConnectionsPending = 8

port :: PortNumber
port = 9001

-- Haskell reads in a very different way, NOTE:
-- You can roughly think of the `<-` directive as "await" and `IO ()` as "async void"
-- You can think of `$` as 
--   "first calculate everything right of $ then input the result into the function left of $"
--   This is actually exactly the same thing as using parenthesis () on the entrire right-hand side.
-- You can think of `.` as 
--   "make a new function which first does the thing to the right of . and then the thing to the left of ."
--   The official term for this directive is "Composition", mathematically speaking: (f . g) n == f(g(n))

main :: IO ()
main = do
    endpoint <- socket AF_INET Stream 0
    _ <- bind endpoint (SockAddrInet port Helper.inAddrAny)
    _ <- listen endpoint maxConnectionsPending
    putStrLn $ "Listening on port " ++ show port ++ " on any interface."
    _ <- listen' endpoint
    putStrLn "Done"

listen' :: Socket -> IO ()
listen' endpoint = do
    (handler, info) <- accept endpoint
    putStrLn Helper.green
    putStrLn $ "Client " ++ Helper.clientName info ++ " connected"
    putStrLn Helper.blue
    connected handler
    putStrLn Helper.red
    putStrLn $ "Client " ++ Helper.clientName info ++ " disconnected"
    putStrLn Helper.reset
    listen' endpoint

connected :: Socket -> IO ()
connected handler = do
    request <- recv handler 256
    onRequest request handler

onRequest :: Bytes.ByteString -> Socket -> IO()
onRequest request handler 
    | byteCount > 0 = do
        putStrLn $ "Received " ++ show byteCount ++ " bytes\n" ++ request'
        respond request' handler
    | otherwise     = close handler
    where byteCount = Bytes.length request
          request'  = UTF8.toString request

respond :: String -> Socket -> IO ()
respond request handler = do
    send handler (responseFrom contents0 contents1)
    connected handler
    where contents0 = takeWhile isAlpha request
          contents1 = takeWhile isDigit $ dropWhile (not . isDigit) request

responseFrom :: String -> String -> ByteString
responseFrom text size
    | size == [] = UTF8.fromString "\n"
    | otherwise  = UTF8.fromString $ take n text ++ "\n"
    where n = read size
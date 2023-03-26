module Main where
import Helper
import Network.Socket
import Network.Socket.ByteString
import qualified Data.ByteString as Bytes

maxConnectionsPending :: Int
maxConnectionsPending = 8

port :: PortNumber
port = 9001

-- Haskell reads in a very different way, NOTE:
-- You can roughly think of the `<-` directive as "await" and IO () as "async void"
-- You can think of `$` as "first calculate everything right of $ then input the result into the function left of $"
-- You can think of `.` as "use the output of the function on the right as input for the function on the left"

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
    onData' handler
    putStrLn Helper.red
    putStrLn $ "Client " ++ Helper.clientName info ++ " disconnected"
    putStrLn Helper.reset
    listen' endpoint

onData' :: Socket -> IO ()
onData' handler = do
    request <- recv handler 256
    onRequest' request handler

onRequest' :: Bytes.ByteString -> Socket -> IO()
onRequest' request handler 
    | byteCount == 0 = close handler
    | otherwise      = do 
        putStrLn $ "Received " ++ show byteCount ++ " bytes\n" ++ show request
        onData' handler
    where byteCount = Bytes.length request


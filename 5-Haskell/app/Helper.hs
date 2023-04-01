-- Haskell reads in a very different way, NOTE:
-- You can roughly think of the `<-` directive as "await" and `IO ()` as "async void"
--   (Although that is not exactly what is going on)
-- You can think of `$` as 
--   "first calculate everything right of $ then input the result into the function left of $"
--   This is actually exactly the same thing as using parenthesis () on the entrire right-hand side.
-- You can think of `.` as 
--   "make a new function which first does the thing to the right of . and then the thing to the left of ."
--   The official term for this directive is "Composition", mathematically speaking: (f . g) n == f(g(n))

module Helper(inAddrAny, logConnected, logDisconnected, logRequest) where

import qualified Data.ByteString as Bytes
import Network.Socket
import System.IO (stdout, hFlush)

inAddrAny :: HostAddress
inAddrAny = tupleToHostAddress (0, 0, 0, 0)

clientIp :: SockAddr -> String
clientIp = takeWhile (/= ':') . show

logConnected :: SockAddr -> IO ()
logConnected info = do
    setGreenColor
    putStrLn $ "Client " ++ Helper.clientIp info ++ " connected"
    resetColor
    hFlush stdout
    where setGreenColor = putStr "\x1b[32m"

logDisconnected :: SockAddr -> IO ()
logDisconnected info = do
    setRedColor
    putStrLn $ "Client " ++ Helper.clientIp info ++ " disconnected"
    resetColor
    hFlush stdout
    where setRedColor = putStr "\x1b[31m"

logRequest :: Bytes.ByteString -> IO ()
logRequest request
    | byteCount > 0 = do
        setBlueColor
        putStrLn $ "Received " ++ show byteCount ++ " bytes"
        resetColor
        print request
        hFlush stdout
    | otherwise     = return ()
    where byteCount    = Bytes.length request
          setBlueColor = putStr "\x1b[34m"

resetColor :: IO ()
resetColor = putStr "\x1b[0m"
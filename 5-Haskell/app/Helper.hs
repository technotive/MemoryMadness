module Helper where
import Network.Socket

-- Haskell reads in a very different way, NOTE:
-- You can roughly think of the `<-` directive as "await" and `IO ()` as "async void"
-- You can think of `$` as 
--   "first calculate everything right of $ then input the result into the function left of $"
--   This is actually exactly the same thing as using parenthesis () on the entrire right-hand side.
-- You can think of `.` as 
--   "make a new function which first does the thing to the right of . and then the thing to the left of ."
--   The official term for this directive is "Composition", mathematically speaking: (f . g) n == f(g(n))

inAddrAny :: HostAddress
inAddrAny = tupleToHostAddress (0, 0, 0, 0)

red :: String
red = "\x1b[31m"

green :: String
green = "\x1b[32m"

blue :: String
blue  = "\x1b[34m"

reset :: String
reset = "\x1b[0m"

clientName :: SockAddr -> String
clientName = takeWhile (/= ':') . show
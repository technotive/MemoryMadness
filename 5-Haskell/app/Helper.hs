module Helper where
import Network.Socket

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
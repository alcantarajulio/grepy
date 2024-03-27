module CommandParser (
    dispatch
) where

import Utils (usage)

dispatch :: String -> IO ()
dispatch "--help" = usage
dispatch "-h" = usage
dispatch _ = usage

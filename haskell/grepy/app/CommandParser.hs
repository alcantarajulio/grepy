module CommandParser (
    dispatch
) where

import Utils (usage)
import Data.Maybe ( isNothing )

-- Mock function to test dispatch
hello :: Maybe FilePath -> IO ()
hello path = if isNothing path then (print "Eh nothing") else (print "Nao eh nothing")

dispatch :: String -> String -> Maybe FilePath -> IO ()
dispatch "--help" _ _ = usage
dispatch "-h" _ _ = usage
-- Cases like that must be treated to receive the content from stdin
dispatch "--hello" _ Nothing = hello Nothing
dispatch "--hello" _ (Just path) = hello (Just path)
dispatch _ _ _ = usage

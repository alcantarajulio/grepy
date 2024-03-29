module CommandParser (
    dispatch
) where

import Utils (usage)
import Data.Maybe ( isNothing )
import Grepy (grepy)
import System.IO (readFile)
import Count (countLines)

-- Mock function to test dispatch
-- hello :: Maybe FilePath -> IO ()
-- hello path = if isNothing path then (print "Eh nothing") else (print "Nao eh nothing")

dispatch :: Maybe String -> String -> Maybe String -> [String]
dispatch (Just "--help") _ _ = usage
dispatch (Just "-h") _ _ = usage
dispatch _ _ Nothing = usage
-- No flag
dispatch Nothing pattern (Just content) = grepy pattern content
-- Count
dispatch (Just "--count") pattern (Just content) = [show (countLines (grepy pattern content))]
dispatch (Just "-c") pattern (Just content) = [show (countLines (grepy pattern content))]
dispatch _ _ _ = usage

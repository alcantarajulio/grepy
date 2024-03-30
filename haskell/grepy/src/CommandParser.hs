module CommandParser (
    dispatch
) where

import Utils (usage)
import Data.Maybe ( isNothing )
import Grepy (grepy)
import System.IO (readFile)
import Count (countLines)
import WordRegexp (wordRegExp)

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

-- WordRegexp
dispatch (Just "--word-regexp") pattern (Just content) =
    case wordRegExp pattern of
        Just regex -> grepy regex content
        Nothing -> ["Failed to generate word regex"]  -- or any other appropriate handling
dispatch (Just "-w") pattern (Just content) =
    case wordRegExp pattern of
        Just regex -> grepy regex content
        Nothing -> ["Failed to generate word regex"]  -- or any other appropriate handling

-- Se nenhuma das flags acima corresponder, exibe a mensagem de uso
dispatch _ _ _ = usage

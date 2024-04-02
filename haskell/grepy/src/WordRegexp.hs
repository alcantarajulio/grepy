module WordRegexp (
    wordRegExp,
) where

import Data.List (foldl')
import Format (highlightPattern) 
import Text.Regex.TDFA ((=~))

-- Generates a regex to search for the word as a standalone term, considering whole word case
wordRegExp :: String -> String
wordRegExp pattern = "\\b" ++ pattern ++ "\\b"

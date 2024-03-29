module Grepy
  ( processLines,
    main,
  )
where

import System.Environment (getArgs)
import Text.Regex.TDFA
import Data.List (intercalate)

-- Function to process a line and filter lines matching the regex pattern
findMatches :: String -> String -> [String]
findMatches str pattern = filter (=~ pattern) (lines str)

processLines :: [String] -> String 
processLines [] = []
processLines (x:xs) = findMatches x : processLines xs
  where 
    findMatches 
--TODO 

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


-- Main function that reads the file and prints matching lines
main :: IO ()
main = do
  args <- getArgs
  case args of
    [filePath, pattern] -> do
      contents <- readFile filePath
      let finalMatches = findMatches contents pattern
      mapM_ putStrLn finalMatches
    _ -> putStrLn "Usage: grepy <file-path> <regex-pattern>"
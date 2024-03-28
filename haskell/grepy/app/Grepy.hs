module Grepy
  ( processLines,
    main,
  )
where

import System.Environment (getArgs)
import Text.Regex.TDFA
import Data.List (intercalate)

-- Function to process a line and filter lines matching the regex pattern
processLines :: String -> String -> [String]
processLines str pattern = filter (=~ pattern) (lines str)

-- Main function that reads the file and prints matching lines
main :: IO ()
main = do
  args <- getArgs
  case args of
    [filePath, pattern] -> do
      contents <- readFile filePath
      let finalMatches = processLines contents pattern
      putStrLn $ "Lines matching regex '" ++ pattern ++ "' in file '" ++ filePath ++ "':"
      mapM_ putStrLn finalMatches
    _ -> putStrLn "Usage: grepy <file-path> <regex-pattern>"


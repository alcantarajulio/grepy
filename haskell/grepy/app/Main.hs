-- Main.hs

module Main where

import System.Environment (getArgs)
import Grepy

-- Main function that reads the file and prints matching lines
main :: IO ()
main = do
  args <- getArgs
  case args of
    [pattern, filePath] -> do
      contents <- readFile filePath
      let finalMatches = processLines contents pattern
      putStrLn $ "Lines matching regex '" ++ pattern ++ "' in file '" ++ filePath ++ "':"
      mapM_ putStrLn finalMatches
    _ -> putStrLn "Usage: ./grepy-exe <regex-pattern> <file-path>"

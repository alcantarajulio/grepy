
module Main where

import Grepy

-- Main function that reads the file and prints matching lines
main :: IO ()
main = do
  putStrLn "Enter regex pattern:"
  regex <- getLine
  putStrLn "Enter file path:"
  filePath <- getLine
  contents <- readFile filePath
  let finalMatches = processLines contents regex
  putStrLn $ "Lines matching regex '" ++ regex ++ "' in file '" ++ filePath ++ "':"
  mapM_ putStrLn finalMatches
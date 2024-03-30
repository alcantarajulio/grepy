module MainRecursive (main) where

import GrepyRecursive (recursiveGrepy)

main :: IO ()
main = do
  putStrLn "Enter directory path: "
  dir <- getLine
  putStrLn "Enter pattern to search: "
  pattern <- getLine
  putStrLn "Searching..."
  matches <- recursiveGrepy pattern dir
  putStrLn "Matches found:"
  mapM_ putStrLn matches

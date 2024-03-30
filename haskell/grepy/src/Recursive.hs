module Recursive
  ( main,
  )
where

import Grepy (grepy)
import System.Directory (doesDirectoryExist, listDirectory)
import System.FilePath ((</>))

getAllFiles :: FilePath -> IO [FilePath]
getAllFiles dir = do
  contents <- listDirectory dir
  paths <-
    traverse
      ( \x ->
          doesDirectoryExist (dir </> x) >>= \isDir ->
            if isDir
              then getAllFiles (dir </> x)
              else pure [dir </> x]
      )
      contents
  return (concat paths)

getMatches :: String -> IO [FilePath] -> [String]
getMatches pattern (x : xs) = do
  content <- readFile x
  let linesMatched = grepy pattern content
  addPrefix (x ++ ": ") linesMatched : getMatches pattern xs

addPrefix :: String -> [String] -> [String]
addPrefix prefix = map (\s -> prefix ++ s)

main :: IO ()
main = do
  putStrLn "Enter directory path:"
  dir <- getLine
  files <- getAllFiles dir
  putStrLn "All files in the directory (including subdirectories):"
  mapM_ putStrLn files

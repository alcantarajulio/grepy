module Recursive
  ( main,
  )
where

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

main :: IO ()
main = do
  putStrLn "Enter directory path:"
  dir <- getLine
  files <- getAllFiles dir
  putStrLn "All files in the directory (including subdirectories):"
  mapM_ putStrLn files

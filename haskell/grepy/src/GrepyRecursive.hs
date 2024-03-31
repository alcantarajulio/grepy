-- module GrepyRecursive (recursiveGrepy) where

-- import Control.Exception (IOException, catch, try)
-- import Data.List (foldl')
-- import Format (highlightPattern)
-- import Grepy (findPattern)
-- import System.Directory (doesFileExist, listDirectory)
-- import System.FilePath ((</>))
-- import Text.Regex.TDFA ((=~))

-- -- Function to process the text line by line and find patterns
-- recursiveGrepy :: String -> FilePath -> IO [String]
-- recursiveGrepy pattern dir = do
--   files <- getAllFiles dir
--   let processFile file = do
--         result <- try $ readFileSafe file :: IO (Either IOException String)
--         case result of
--           Left _ -> return [] -- Skip files that couldn't be read
--           Right content -> do
--             let linesList = lines content
--                 processLine acc line = case findPattern pattern line of
--                   Nothing -> acc
--                   Just match -> (file ++ ": " ++ match) : acc
--             return $ foldl' processLine [] (reverse linesList)
--   fileContents <- mapM processFile files
--   return (concat fileContents)

-- -- Function to read file safely, catching exceptions
-- readFileSafe :: FilePath -> IO String
-- readFileSafe file = readFile file `catch` handleIOError
--   where
--     handleIOError :: IOException -> IO String
--     handleIOError _ = return "" -- Return an empty string if an IO exception occurs

-- -- Function to get all files recursively from a directory
-- getAllFiles :: FilePath -> IO [FilePath]
-- getAllFiles dir = do
--   contents <- listDirectory dir
--   paths <-
--     traverse
--       ( \x ->
--           doesFileExist (dir </> x) >>= \isFile ->
--             if isFile
--               then pure [dir </> x]
--               else getAllFiles (dir </> x)
--       )
--       contents
--   return (concat paths)
module GrepyRecursive (recursiveGrepy) where

import Control.Exception (IOException, catch, try)
import Data.List (foldl')
import Format (highlightPattern)
import Grepy (findPattern)
import System.Directory (doesDirectoryExist, doesFileExist, listDirectory)
import System.FilePath ((</>))
import Text.Regex.TDFA ((=~))

-- Function to process the text line by line and find patterns
recursiveGrepy :: String -> FilePath -> [FilePath] -> IO [String]
recursiveGrepy pattern dir excludes = do
  files <- getAllFiles dir excludes
  let processFile file = do
        result <- try $ readFileSafe file :: IO (Either IOException String)
        case result of
          Left _ -> return [] -- Skip files that couldn't be read
          Right content -> do
            let linesList = lines content
                processLine acc line = case findPattern pattern line of
                  Nothing -> acc
                  Just match -> (file ++ ": " ++ match) : acc
            return $ foldl' processLine [] (reverse linesList)
  fileContents <- mapM processFile files
  return (concat fileContents)

-- Function to read file safely, catching exceptions
readFileSafe :: FilePath -> IO String
readFileSafe file = readFile file `catch` handleIOError
  where
    handleIOError :: IOException -> IO String
    handleIOError _ = return "" -- Return an empty string if an IO exception occurs

-- Function to get all files recursively from a directory
getAllFiles :: FilePath -> [FilePath] -> IO [FilePath]
getAllFiles dir excludes = do
  contents <- listDirectory dir
  let fullPath = (dir </>)
  paths <- traverse (getFileOrDir fullPath) contents
  return (concat paths)
  where
    getFileOrDir :: (FilePath -> FilePath) -> FilePath -> IO [FilePath]
    getFileOrDir basePath item = do
      let fullPath = basePath item
      isFile <- doesFileExist fullPath
      isDir <- doesDirectoryExist fullPath
      if isFile && not (any (`elem` excludes) [fullPath]) then
        return [fullPath]
      else if isDir then
        getAllFiles fullPath excludes
      else
        return []

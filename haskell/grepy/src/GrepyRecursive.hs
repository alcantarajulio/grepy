module GrepyRecursive (recursiveGrepy) where

import Control.Exception (IOException, catch, try)
import Data.List (foldl')
import Format (highlightPattern)
import System.Directory (doesFileExist, listDirectory)
import System.FilePath ((</>))
import Text.Regex.TDFA ((=~))

----------------------------------------------------------------------------

-- Function to find the pattern in a line
findPattern :: String -> String -> Maybe String
findPattern pattern line =
  case line =~ pattern :: (String, String, String) of
    (_, "", _) -> Nothing
    (before, matched, after) -> Just (highlightPattern matched (before ++ matched ++ after))

-- Function to process the text line by line and find patterns
recursiveGrepy :: String -> FilePath -> IO [String]
recursiveGrepy pattern dir = do
  files <- getAllFiles dir
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
getAllFiles :: FilePath -> IO [FilePath]
getAllFiles dir = do
  contents <- listDirectory dir
  paths <-
    traverse
      ( \x ->
          doesFileExist (dir </> x) >>= \isFile ->
            if isFile
              then pure [dir </> x]
              else getAllFiles (dir </> x)
      )
      contents
  return (concat paths)

----------------------------------------------------------------------------

-- -- Function to find the pattern in a line
-- findPattern :: String -> String -> Maybe String
-- findPattern pattern line =
--   case line =~ pattern :: (String, String, String) of
--     (_, "", _) -> Nothing
--     (before, matched, after) -> Just (highlightPattern matched (before ++ matched ++ after))
--
-- -- Function to process the text line by line and find patterns
-- recursiveGrepy :: String -> FilePath -> IO [String]
-- recursiveGrepy pattern dir = do
--   files <- getAllFiles dir
--   let processFile file = do
--         result <- try $ readFile file :: IO (Either SomeException String)
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
--
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

----------------------------------------------------------------------------

-- -- Function to find the pattern in a line
-- findPattern :: String -> String -> Maybe String
-- findPattern pattern line =
--   case line =~ pattern :: (String, String, String) of
--     (_, "", _) -> Nothing
--     (before, matched, after) -> Just (highlightPattern matched (before ++ matched ++ after))
--
-- -- Function to process the text line by line and find patterns
-- recursiveGrepy :: String -> FilePath -> IO [String]
-- recursiveGrepy pattern dir = do
--   files <- getAllFiles dir
--   let processFile :: IO [String] -> FilePath -> IO [String]
--       processFile accIO file = do
--         acc <- accIO
--         result <- try $ readFile file :: IO (Either SomeException String)
--         case result of
--           Left _ -> return acc -- Skip files that couldn't be read
--           Right content -> do
--             let linesList = lines content
--                 processLine acc' line = case findPattern pattern line of
--                   Nothing -> acc'
--                   Just match -> (file ++ ": " ++ match) : acc'
--             return $ foldl' processLine acc (reverse linesList)
--   foldl' processFile (return []) files
--
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

----------------------------------------------------------------------------

-- -- Function to find the pattern in a line
-- findPattern :: String -> String -> Maybe String
-- findPattern pattern line =
--   case line =~ pattern :: (String, String, String) of
--     (_, "", _) -> Nothing
--     (before, matched, after) -> Just (highlightPattern matched (before ++ matched ++ after))
--
-- -- Function to process the text line by line and find patterns
-- recursiveGrepy :: String -> FilePath -> IO [String]
-- recursiveGrepy pattern dir = do
--   files <- getAllFiles dir
--   let processFile file = do
--         content <- readFile file
--         let linesList = lines content
--             processLine acc line = case findPattern pattern line of
--               Nothing -> acc
--               Just match -> (file ++ ": " ++ match) : acc
--         return $ foldl' processLine [] (reverse linesList)
--   fileContents <- mapM processFile files
--   return (concat fileContents)
--
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

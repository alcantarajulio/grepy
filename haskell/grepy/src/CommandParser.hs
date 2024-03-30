module CommandParser (
    dispatch,
    dispatchRecursive
) where

import Utils (usage)
import Grepy (grepy)
import System.IO (readFile)
import Count (countLines)
import WordRegexp (wordRegExp)
import GrepyRecursive (recursiveGrepy)

dispatch :: Maybe String -> String -> Maybe String -> [String]
dispatch (Just "--help") _ _ = usage
dispatch (Just "-h") _ _ = usage
dispatch _ _ Nothing = usage

-- No flag
dispatch Nothing pattern (Just content) = grepy pattern content

-- Count
dispatch (Just "--count") pattern (Just content) = [show (countLines (grepy pattern content))]
dispatch (Just "-c") pattern (Just content) = [show (countLines (grepy pattern content))]

-- WordRegexp
dispatch (Just "--word-regexp") pattern (Just content) =
    case wordRegExp pattern of
        Just regex -> grepy regex content
        Nothing -> ["Failed to generate word regex"]  -- or any other appropriate handling
dispatch (Just "-w") pattern (Just content) =
    case wordRegExp pattern of
        Just regex -> grepy regex content
        Nothing -> ["Failed to generate word regex"]  -- or any other appropriate handling
-- No match
dispatch _ _ _ = usage

-- Recursive
dispatchRecursive :: Maybe String -> String -> Maybe FilePath -> IO [String]
dispatchRecursive (Just "--recursive") pattern (Just path) = recursiveGrepy pattern path
dispatchRecursive (Just "-r") pattern (Just path) = recursiveGrepy pattern path
-- Recursive-Exclude
-- dispatchRecursiveExclude :: Maybe String -> String -> Maybe FilePath -> Maybe FilePath -> IO [String]
-- dispatchRecursiveExclude (Just "--recursive-exclude") pattern (Just file_path) (Just dir_path) = recursiveGrepy pattern file_path dir_path
-- dispatchRecursiveExclude (Just "-e") pattern (Just file_path) (Just dir_path) = recursiveGrepy pattern file_path dir_path






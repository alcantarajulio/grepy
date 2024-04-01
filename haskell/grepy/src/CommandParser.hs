module CommandParser (
    dispatch,
    dispatchRecursive,
    dispatchRecursiveExcludes
) where

import Utils (usage)
import Grepy (grepy)
import Count (countLines)
import WordRegexp (wordRegExp)
import GrepyRecursive (recursiveGrepy)

dispatch :: Maybe String -> String -> Maybe String -> [String]
-- Usage
dispatch (Just "--help") _ _ = usage
dispatch (Just "-h") _ _ = usage
dispatch _ _ Nothing = usage

-- No flag
dispatch Nothing pattern (Just content) = grepy pattern content

-- Count
dispatch (Just "--count") pattern (Just content) = [show (countLines (grepy pattern content))]
dispatch (Just "-c") pattern (Just content) = [show (countLines (grepy pattern content))]

-- WordRegexp
dispatch (Just "--word-regexp") pattern (Just content) = do
  let regex = wordRegExp pattern
  grepy regex content

dispatch (Just "-w") pattern (Just content) = do
  let regex = wordRegExp pattern
  grepy regex content

-- no matches
dispatch _ _ _ = usage

-- Recursive
dispatchRecursive :: Maybe String -> String -> Maybe FilePath -> IO [String]
dispatchRecursive (Just "--recursive") pattern (Just dirPath) = recursiveGrepy pattern dirPath []
dispatchRecursive (Just "-r") pattern (Just dirPath) = recursiveGrepy pattern dirPath []

-- Recursive-Exclude
dispatchRecursiveExcludes :: Maybe String -> String -> Maybe FilePath -> Maybe [FilePath] -> IO [String]
dispatchRecursiveExcludes (Just "--recursive-exclude") pattern (Just dirPath) (Just excludes) =
  recursiveGrepy pattern dirPath excludes
dispatchRecursiveExcludes (Just "-e") pattern (Just dirPath) (Just excludes) =
  recursiveGrepy pattern dirPath excludes






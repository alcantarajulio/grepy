module CommandParser (
    dispatch,
    dispatch2
) where

import Utils (usage)
import Grepy (grepy)
import System.IO (readFile)
import Count (countLines)
import WordRegexp (wordRegExp)

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
dispatch _ _ _ = usage

-- Recursive
-- No match
dispatch2 :: Maybe String -> String -> String -> Maybe String-> [String]
dispatch2 (Just "--recursive") pattern file_path (Just path) = usage
dispatch2 (Just "-r") pattern file_path (Just path) = usage


module WordRegexp (
    wordRegExp,
) where

import Data.List (foldl')
import Format (highlightPattern) 
import Text.Regex.TDFA ((=~))

-- Generates a regex to search for the word as a standalone term, considering whole word case
wordRegExp :: String -> Maybe String
wordRegExp pattern = Just ("\\b" ++ pattern ++ "\\b")

-- Function to find the pattern in a line and apply highlighting
findPattern :: String -> String -> Maybe String
findPattern pattern line =
  case wordRegExp pattern of
    Nothing -> Nothing
    Just wordPattern ->
      if line =~ wordPattern :: Bool
        then Just (highlightPattern pattern line)
        else Nothing


-- Function to process the text line by line and find patterns
processText :: String -> String -> [String]
processText pattern text =
  let linesList = lines text
      processLine acc line = case findPattern pattern line of
                                Nothing -> acc
                                Just match -> match : acc
  in foldl' processLine [] (reverse linesList)

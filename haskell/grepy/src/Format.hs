module Format (highlightPattern) where

import Data.List
import Data.List (intercalate, isInfixOf)
import Data.List.Split (splitOn)
import System.Console.ANSI

-- Função para colorir uma palavra
colorWord :: String -> String
colorWord word = setSGRCode [SetColor Foreground Vivid Red] ++ word ++ setSGRCode [Reset]

-- Funpara destacar o padrão na linha
highlightPattern :: String -> String -> String
highlightPattern pattern line =
  intercalate (colorWord pattern) (splitOn pattern line)

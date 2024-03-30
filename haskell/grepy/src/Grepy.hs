module Grepy (
    grepy
) where

import Data.List (foldl')
import Format (highlightPattern)
import Text.Regex.TDFA ((=~))

-- Função para encontrar o padrão em uma linha
findPattern :: String -> String -> Maybe String
findPattern pattern line =
  case line =~ pattern :: (String, String, String) of
    (_, "", _) -> Nothing
    (before, matched, after) -> Just (highlightPattern matched (before ++ matched ++ after))

-- Função para processar o texto linha por linha e encontrar padrões
grepy :: String -> String -> [String]
grepy pattern text =
  let linesList = lines text -- Divide o texto em linhas
  -- Função auxiliar para processar uma linha e adicionar à lista se um padrão for encontrado
      processLine acc line = case findPattern pattern line of
        Nothing -> acc
        Just match -> match : acc
   in foldl' processLine [] (reverse linesList) -- Itera sobre as linhas e acumula os resultados

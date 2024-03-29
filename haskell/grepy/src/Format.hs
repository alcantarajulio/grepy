module Format (destacarPadrao) where
    

import System.Console.ANSI
import Data.List
import Lib

import Data.List.Split (splitOn)
import Data.List (isInfixOf, intercalate)

-- Função para colorir uma palavra
colorirPalavra :: String -> String
colorirPalavra palavra = setSGRCode [SetColor Foreground Vivid Red] ++ palavra ++ setSGRCode [Reset]

-- Função para destacar o padrão na linha
destacarPadrao :: String -> String -> String
destacarPadrao pattern linha =
    intercalate (colorirPalavra pattern) (splitOn pattern linha)
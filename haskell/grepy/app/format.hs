module Main (main) where
import Text.Regex.TDFA
import System.Console.ANSI
import Data.List
import Lib

import Data.List.Split (splitOn)
import Data.List (isInfixOf, intercalate)

-- Função para encontrar e retornar as linhas que contêm o padrão
encontrarLinhas :: String -> String -> [String]
encontrarLinhas pattern inputString =
    filter (isInfixOf pattern) (lines inputString)

-- Função para colorir uma palavra
colorirPalavra :: String -> String
colorirPalavra palavra = setSGRCode [SetColor Foreground Vivid Red] ++ palavra ++ setSGRCode [Reset]

-- Função para destacar o padrão na linha
destacarPadrao :: String -> String -> String
destacarPadrao pattern linha =
    intercalate (colorirPalavra pattern) (splitOn pattern linha)

-- Exemplo de uso
main :: IO ()
main = do
    let inputString = "Hello, World! This is a test.\nWorld is a beautiful place.\nWorld is awesome\nflamengo é foda"
    let regexPattern = "me"
    let linhas = encontrarLinhas regexPattern inputString
    let linhasDestacadas = map (destacarPadrao regexPattern) linhas
    mapM_ putStrLn linhasDestacadas
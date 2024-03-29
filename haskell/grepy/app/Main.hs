module Main (main) where

import CommandParser (dispatch)
import Data.List (foldl')
import Format (highlightPattern)
import Lib
import System.Environment (getArgs)
import System.IO (readFile)
import Text.Regex.TDFA ((=~))
import Utils (usage)

-- Função para encontrar o padrão em uma linha
findPattern :: String -> String -> Maybe String
findPattern pattern line =
  case line =~ pattern :: (String, String, String) of
    (_, "", _) -> Nothing
    (before, matched, after) -> Just (highlightPattern matched (before ++ matched ++ after))

-- Função para processar o texto linha por linha e encontrar padrões
processText :: String -> String -> [String]
processText pattern text =
  let linesList = lines text -- Divide o texto em linhas
  -- Função auxiliar para processar uma linha e adicionar à lista se um padrão for encontrado
      processLine acc line = case findPattern pattern line of
        Nothing -> acc
        Just match -> match : acc
   in foldl' processLine [] (reverse linesList) -- Itera sobre as linhas e acumula os resultados

-- main :: IO ()
-- main = do
--     args <- getArgs
--     case args of
--         [command, pattern, path] -> dispatch command pattern (Just path)
--         -- (NOTE: winiciusallan) This match must receive the file content from stdin
--         [command, pattern] -> dispatch command pattern Nothing
--         _ -> dispatch "help" "" Nothing

main :: IO ()
main = do
  let text = "oi eu gosto de bolo\nbolo de chocolate\nnão tem eustaquio bolo aqui\nisaac limpa catota\nisaac limpa bolo ta\naaaa\na\naaccccbbbb\nabcc"
      pattern = "a+"
      matches = processText pattern text
  putStrLn "Padrões encontrados:"
  -- mapM_ (\(line, matched) -> putStrLn $ "Linha: " ++ line ++ " Padrão: " ++ matched) matches
  let linesMatched = map (highlightPattern pattern) matches
  mapM_ putStrLn linesMatched

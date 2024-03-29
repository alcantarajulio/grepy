module Main (main) where

import Lib
import System.IO (readFile)
import System.Environment (getArgs)
import Utils (usage)
import CommandParser (dispatch)
import Text.Regex.TDFA ( (=~) )
import Data.List (foldl')
import Format (destacarPadrao)

-- Função para encontrar o padrão em uma linha
findPattern :: String -> String -> Maybe String
findPattern line pattern =
  case line =~ pattern :: (String, String, String) of
    (_, "", _) -> Nothing
    (before, matched, _) -> Just (destacarPadrao matched (before ++ matched))

-- Função para processar o texto linha por linha e encontrar padrões
processText :: String -> String -> [String]
processText text pattern =
  let linesList = lines text  -- Divide o texto em linhas
      -- Função auxiliar para processar uma linha e adicionar à lista se um padrão for encontrado
      processLine acc line = case findPattern line pattern of
                                Nothing -> acc
                                Just match -> match : acc
  in foldl' processLine [] (reverse linesList)  -- Itera sobre as linhas e acumula os resultados

main :: IO ()
main = do
    args <- getArgs
    case args of
        [command, pattern, path] -> dispatch command pattern (Just path)
        -- (NOTE: winiciusallan) This match must receive the file content from stdin
        [command, pattern] -> dispatch command pattern Nothing
        _ -> dispatch "help" "" Nothing

-- main = do
--   let text = "oi eu gosto de bolo\nbolo de chocolate\nnão tem eustaquio bolo aqui\nisaac limpa catota\nisaac limpa bolo ta\naaaa\na\naaccccbbbb\nabcc"
--       pattern = "oi"
--       matches = processText text pattern
--   putStrLn "Padrões encontrados:"
--   -- mapM_ (\(line, matched) -> putStrLn $ "Linha: " ++ line ++ " Padrão: " ++ matched) matches
--   let linhasDestacadas = map (destacarPadrao pattern) matches
--   mapM_ putStrLn linhasDestacadas
module Main (main) where

import CommandParser (dispatch)
import Data.List (foldl')
import Format (highlightPattern)
import System.Environment (getArgs)
import System.Directory (doesFileExist)
import System.IO (readFile)
import Text.Regex.TDFA ((=~))
import Utils (usage)
import System.Posix.Terminal (queryTerminal)

isInputFromPipe :: IO Bool
isInputFromPipe = not <$> queryTerminal 0

main :: IO ()
main = do
    args <- getArgs
    case args of
        [flags, pattern, path] -> do
            exists <- doesFileExist path
            if exists then do
                str <- readFile path
                mapM_ putStrLn (dispatch (Just flags) pattern (Just str))
                else do 
                    contents <- getContents
                    if contents == [] then do
                        mapM_ putStrLn (dispatch (Just flags) pattern (Just contents))
                    else mapM_ putStrLn (dispatch (Just "help") "" Nothing) 
        [pattern, path] -> do 
            exists <- doesFileExist path
            if exists then do
                str <- readFile path
                mapM_ putStrLn (dispatch Nothing pattern (Just str)) 
                else do 
                    contents <- getContents
                    if contents == [] then do 
                        mapM_ putStrLn (dispatch (Just pattern) path (Just contents)) 
                    else mapM_ putStrLn (dispatch (Just "help") "" Nothing) 

        [pattern] -> do 
            fromPipe <- isInputFromPipe
            if fromPipe then do 
                contents <- getContents
                mapM_ putStrLn (dispatch Nothing pattern (Just contents))
                else mapM_ putStrLn (dispatch (Just "help") "" Nothing) 

        _ -> mapM_ putStrLn (dispatch (Just "help") "" Nothing)

-- main :: IO ()
-- main = do
--   let text = "oi eu gosto de bolo\nbolo de chocolate\nnão tem eustaquio bolo aqui\nisaac limpa catota\nisaac limpa bolo ta\naaaa\na\naaccccbbbb\nabcc"
--       pattern = "a+"
--       matches = processText pattern text
--   putStrLn "Padrões encontrados:"
--   -- mapM_ (\(line, matched) -> putStrLn $ "Linha: " ++ line ++ " Padrão: " ++ matched) matches
--   let linesMatched = map (highlightPattern pattern) matches
--   mapM_ putStrLn linesMached

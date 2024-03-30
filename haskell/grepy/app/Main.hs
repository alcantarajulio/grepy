module Main (main) where

import CommandParser (dispatch, dispatch2)
import Data.List (foldl')
import Format (highlightPattern)
import System.Environment (getArgs)
import System.Directory (doesFileExist)
import System.IO (readFile)
import Text.Regex.TDFA ((=~))
import Utils (usage, stdinVerify, isFlag, fileNotExits)
import System.Directory.Internal.Prelude (getArgs)
import GHC.Read (readField)


uso :: [String]
uso = dispatch (Just "-h") "" Nothing


main :: IO ()
main = do
    args <- getArgs
    if null args then mapM_ putStrLn uso else do

        verifyStdin <- stdinVerify
        verifyPath <- fileNotExits (last args)



        if not (verifyStdin /= verifyPath) then mapM_ putStrLn uso

        else
            case args of

                [arg1] -> do
                    if verifyStdin then do
                        content <- getContents
                        mapM_ putStrLn (dispatch Nothing arg1 (Just content))
                    else
                        mapM_ putStrLn uso


                [arg1, arg2] -> do
                    if verifyStdin then do
                        if isFlag (head args) then do
                            content <- getContents
                            mapM_ putStrLn (dispatch (Just arg1) arg2 (Just content))
                        else
                            mapM_ putStrLn uso
                    else do
                        if verifyPath then do
                            file <- readFile arg2
                            mapM_ putStrLn (dispatch Nothing arg1 (Just file))
                        else
                            mapM_ putStrLn uso


                [arg1, arg2, arg3] -> do
                        if verifyPath then do
                            file <- readFile arg3
                            mapM_ putStrLn (dispatch (Just arg1) arg2 (Just file))
                        else
                            mapM_ putStrLn uso


                [arg1, arg2, arg3, arg4] -> do
                        if verifyPath then do
                            mapM_ putStrLn (dispatch2 (Just arg1) arg2 arg3 (Just arg4))
                        else
                            mapM_ putStrLn uso

                _ -> mapM_ putStrLn uso

    -- args <- getArgs
    -- case args of
    --     [flags, pattern, path] -> do
    --         exists <- doesFileExist path
    --         if exists then do
    --             str <- readFile path
    --             mapM_ putStrLn (dispatch (Just flags) pattern (Just str))
    --             else do 
    --                 contents <- getContents
    --                 if contents == [] then do
    --                     mapM_ putStrLn (dispatch (Just flags) pattern (Just contents))
    --                 else mapM_ putStrLn (dispatch (Just "help") "" Nothing) 
    --     [pattern, path] -> do 
    --         exists <- doesFileExist path
    --         if exists then do
    --             str <- readFile path
    --             mapM_ putStrLn (dispatch Nothing pattern (Just str)) 
    --             else do 
    --                 contents <- getContents
    --                 if contents == [] then do 
    --                     mapM_ putStrLn (dispatch (Just pattern) path (Just contents)) 
    --                 else mapM_ putStrLn (dispatch (Just "help") "" Nothing) 

    --     [pattern] -> do 
    --         fromPipe <- isInputFromPipe
    --         if fromPipe then do 
    --             contents <- getContents
    --             mapM_ putStrLn (dispatch Nothing pattern (Just contents))
    --             else mapM_ putStrLn (dispatch (Just "help") "" Nothing) 

    --     _ -> mapM_ putStrLn (dispatch (Just "help") "" Nothing)

-- main :: IO ()
-- main = do
--   let text = "oi eu gosto de bolo\nbolo de chocolate\nnão tem eustaquio bolo aqui\nisaac limpa catota\nisaac limpa bolo ta\naaaa\na\naaccccbbbb\nabcc"
--       pattern = "a+"
--       matches = processText pattern text
--   putStrLn "Padrões encontrados:"
--   -- mapM_ (\(line, matched) -> putStrLn $ "Linha: " ++ line ++ " Padrão: " ++ matched) matches
--   let linesMatched = map (highlightPattern pattern) matches
--   mapM_ putStrLn linesMached
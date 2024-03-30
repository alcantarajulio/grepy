module Main (main) where

import CommandParser (dispatch, dispatch2)
import System.Environment (getArgs)
import System.Directory (doesFileExist)
import System.IO (readFile)
import Utils (usage, stdinVerify, isFlag, fileNotExits)


uso :: [String]
uso = dispatch (Just "-h") "" Nothing

main :: IO ()
main = do
    args <- getArgs

    -- Check if number of arguments is zero.
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

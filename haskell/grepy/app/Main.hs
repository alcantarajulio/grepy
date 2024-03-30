module Main (main) where

import CommandParser (dispatch, dispatchRecursive)
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

        if not ((head args) == "--recursive")
            then do
                if not (verifyStdin /= verifyPath) then mapM_ putStrLn uso
                else
                    case args of
                        [arg1] -> do
                            print "1argumento"
                            if verifyStdin then do
                                content <- getContents
                                mapM_ putStrLn (dispatch Nothing arg1 (Just content))
                            else
                                mapM_ putStrLn uso

                        [arg1, arg2] -> do
                            print "2argumentos"
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
                                print "3 argumentos"
                                if verifyPath then do
                                    file <- readFile arg3
                                    mapM_ putStrLn (dispatch (Just arg1) arg2 (Just file))
                                else
                                    mapM_ putStrLn uso

                        _ -> mapM_ putStrLn uso
            else do
                case args of
                    [arg1, arg2, arg3] -> do
                        out <- (dispatchRecursive (Just arg1) arg2 (Just arg3))
                        mapM_ putStrLn out 

                    -- [arg1, arg2, arg3, arg4] -> do
                    --     out <- (dispatchRecursiveExclude (Just arg1) arg2 (Just arg3) (Just arg4))
                    --     mapM_ putStrLn out
                    
                    _ -> mapM_ putStrLn uso


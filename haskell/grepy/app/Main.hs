module Main (main) where

import Lib
import ArgsParser
import System.IO (readFile)

printCount :: IO ()
printCount = putStrLn "oii"

printRecursive :: IO ()
printRecursive = putStrLn "Recursive is running"

perform :: Options -> IO ()
perform (Count filePath) = putStrLn $ filePath
perform Recursive = printRecursive

main :: IO ()
main = do
    opts <- parserOptions
    print opts
    -- perform opts
    -- putStrLn $ "Count: " ++ show (count opts)
    -- putStrLn $ "Recursive: " ++ show (recursive opts)
    -- putStrLn $ "File: " ++ file opts

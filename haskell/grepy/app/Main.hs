module Main (main) where

import Lib
import ArgsParser

main :: IO ()
main = do
    opts <- parserOptions
    putStrLn $ "Count: " ++ show (count opts)
    putStrLn $ "Recursive: " ++ show (recursive opts)
    putStrLn $ "File: " ++ file opts

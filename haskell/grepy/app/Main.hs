module Main (main) where

import Lib
import System.IO (readFile)
import System.Environment (getArgs)
import Utils (usage)
import CommandParser (dispatch)

main :: IO ()
main = do
    args <- getArgs
    case args of
        [command] -> dispatch command 
        _ -> dispatch "help"

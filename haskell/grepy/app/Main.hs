-- Main.hs


module Main where
import Lib
import System.IO (readFile)
import System.Environment (getArgs)
import Utils (usage)
import CommandParser (dispatch)

import System.Environment (getArgs)
import Grepy

-- Main function that reads the file and prints matching lines
main :: IO ()
main = do
    args <- getArgs
    case args of
        [command, pattern, path] -> dispatch command pattern (Just path)
        -- (NOTE: winiciusallan) This match must receive the file content from stdin
        [command, pattern] -> dispatch command pattern Nothing
        _ -> dispatch "help" "" Nothing

module Count
  ( processLines,
    main,
  )
where

import Text.Regex.TDFA

-- Define your regex pattern
pattern :: String
pattern = "oi"

-- Function to process a line and update the count
processLines :: [String] -> Int
processLines [] = 0
processLines (str : tail) = if str =~ pattern then 1 + processLines tail else processLines tail

-- Main function that reads the file and counts matches
main :: IO ()
main = do
  contents <- readFile "app/data.txt"
  -- Split the content into lines

  let linesList = lines contents
  -- Fold over the lines with processLine function, starting count at 0
  let finalCount = processLines linesList
  print ("Number of lines matching regex '" ++ pattern ++ "' : " ++ show finalCount)

import Options.Applicative
import Data.Semigroup ((<>))
import Control.Monad (forM_)
import System.IO
import qualified Data.Text as T
import qualified Data.Text.IO as TIO

data GrepOptions = GrepOptions
    { pattern :: String
    , files :: [FilePath]
    }

grepOptions :: Parser GrepOptions
grepOptions = GrepOptions
    <$> argument str
        ( metavar "PATTERN"
       <> help "Pattern to search for" )
    <*> many (argument str
        ( metavar "FILES..."
       <> help "Files to search in" ))

runGrep :: GrepOptions -> IO ()
runGrep (GrepOptions pattern files) = do
    forM_ files $ \file -> do
        contents <- TIO.readFile file
        let matchingLines = filter (T.isInfixOf (T.pack pattern)) (T.lines contents)
        forM_ matchingLines TIO.putStrLn

main :: IO ()
main = execParser opts >>= runGrep
  where
    opts = info (grepOptions <**> helper)
      ( fullDesc
     <> progDesc "A Haskell clone of grep"
     <> header "grepy - a grep clone written in Haskell" )


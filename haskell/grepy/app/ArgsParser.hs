module ArgsParser (
    Options(..),
    parserOptions
) where

import Options.Applicative

data Options = Count FilePath
             | Recursive
             | Exclude FilePath
             | WordRegex
             deriving (Show)

count :: Parser Options
count = Count <$> strOption
    ( long "count"
    <> short 'c'
    <> help "Mostra a contagem de linhas casadas"
    )

recursive :: Parser Options
recursive = flag' Recursive
    ( long "recursive"
    <> short 'r'
    <> help "Aplica o casamento do padrão recursivamente em um diretório"
    )

wordregex :: Parser Options
wordregex = flag' WordRegex
    ( long "wordregex"
    <> short 'w'
    <> help "Busca o padrão em palavras"
    )

exclude :: Parser Options
exclude = Exclude <$> strOption
    ( long "exclude"
    <> short 'e'
    <> help "Desconsidera todo o conteudo de um arquivo"
    )

optionsParser :: Parser Options
optionsParser = count
            <|> recursive
            <|> wordregex
            <|> exclude

parserOptions :: IO Options
parserOptions = execParser opts
    where
      opts = info (optionsParser <**> helper)
        ( fullDesc 
       <> progDesc "A simple program to demonstrate command-line argument parsing in Haskell" 
       <> header "haskell-arg-parser - a simple argument parser example"
        )

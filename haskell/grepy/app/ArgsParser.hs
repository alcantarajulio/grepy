module ArgsParser (
    parseOptions
) where

import Options.Applicative

count :: Parser Bool
count = switch
    ( long "count"
    <> short 'c'
    <> help "Mostra a contagem de linhas casadas"
    )

recursive :: Parser Bool
recursive = switch
    ( long "recursive"
    <> short 'r'
    <> help "Aplica o casamento do padrão recursivamente em um diretório"
    )

wordregex :: Parser Bool
wordregex = switch
    ( long "wordregex"
    <> short 'w'
    <> help "Busca o padrão em palavras"
    )

exclude :: Parser Input
exclude = FileInput <$> strOption
    ( long "exclude"
    <> short 'e'
    <> help "Desconsidera todo o conteudo de um arquivo"
    )

parserOptions :: IO Options
parserOptions = execParser parser

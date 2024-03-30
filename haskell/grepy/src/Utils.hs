module Utils (
    usage, stdinVerify, isFlag, fileNotExits
) where

import Data.List.Split (splitOn)
import System.Posix.Terminal (queryTerminal)
import Data.String (String)
import System.Directory (doesFileExist)


usage :: [String]
usage = splitOn "\n" "Usage: grepy [-c | --count] [-r | --recursive] \n\
       \     [-w | --word-regexp] [-e | --exclude] [-h | --help] <file>\n\ 
       \ \n\
\ O grepy procura por casamento dos padrões nos arquivos ou string passadas como entrada para o programa.\n\
\ \n\ 
\ options: \n\
\ -c, --count        Exibe a contagem dos padrões casados. \n\
\ -r, --recursive    Procura pelo padrão nos arquivos do diretório passado como parâmetro, recursivamente. \n\
\ -w, --word-regexp  O padrão é buscado seguindo a palavra passada como parâmetro. \n\
\ -e, --exclude      Exclui um arquivo da busca recursiva. Deve ser usada juntamente com `-r` \n\
\ -h, --help         Mostra a mensagem de uso do programa."

-- Verify if stdin is coming from a pipe operator (|)
stdinVerify :: IO Bool
stdinVerify = not <$> queryTerminal 0

isFlag :: String -> Bool
isFlag flag = flag `elem` [ "--count", "-c", "--help", "-h",
      "--word-regexp",  "-w", "--recursive",  "-r",
      "--recursive-exlcude",  "-e"]

fileNotExits :: FilePath -> IO Bool
fileNotExits path = doesFileExist path


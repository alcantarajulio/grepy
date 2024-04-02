module Utils (
    usage, stdinVerify, isFlag, fileNotExits, verifyRecursivesCases
) where

import Data.List.Split (splitOn)
import System.Posix.Terminal (queryTerminal)
import System.Directory (doesFileExist)

usage :: [String]
usage = splitOn "\n" "Usage: grepy [-c | --count] [-r | --recursive] \n\
       \     [-w | --word-regexp] [-e | --exclude] [-h | --help] <file>\n\ 
       \ \n\
\ O grepy procura por casamento dos padrões nos arquivos ou string passadas como entrada para o programa.\n\
\ \n\ 
\ options: \n\
\ -c, --count              Exibe a contagem dos padrões casados. \n\
\ -r, --recursive          Procura pelo padrão nos arquivos do diretório passado como parâmetro, recursivamente. \n\
\ -e, --recursive-exclude  Tem funcionamento similar a `--recursive`, porem desconsidera o arquivo passado.  \n\
\ -w, --word-regexp        O padrão é buscado seguindo a palavra passada como parâmetro. \n\
\ -h, --help               Mostra a mensagem de uso do programa."

-- Verify if stdin is coming from a pipe operator (|)
stdinVerify :: IO Bool
stdinVerify = not <$> queryTerminal 0

isFlag :: String -> Bool
isFlag flag = flag `elem` [ "--count", "-c", "--help", "-h",
      "--word-regexp",  "-w", "--recursive",  "-r",
      "--recursive-exclude",  "-e"]

fileNotExits :: FilePath -> IO Bool
fileNotExits path = doesFileExist path

verifyRecursivesCases :: String -> Bool
verifyRecursivesCases arg = arg `elem` ["--recursive",  "-r", "--recursive-exclude",  "-e"]


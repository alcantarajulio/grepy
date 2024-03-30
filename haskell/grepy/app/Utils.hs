module Utils
  ( usage,
  )
where

usage :: IO ()
usage = do
  putStrLn
    "Usage: grepy [-c | --count] [-r | --recursive] \n\
    \     [-w | --word-regexp] [-e | --exclude] [-h | --help] <file>\n\
    \ \n\
    \ O grepy procura por casamento dos padrões nos arquivos ou string passadas como entrada para o programa.\n\
    \ \n\
    \ options: \n\
    \ -c, --count        Exibe a contagem dos padrões casados. \n\
    \ -r, --recursive    Procura pelo padrão nos arquivos do diretório passado como parâmetro, recursivamente. \n\
    \ -w, --word-regexp    O padrão é buscado seguindo a palavra passada como parâmetro. \n\
    \ -e, --exclude      Exclui um arquivo da busca recursiva. Deve ser usada juntamente com `-r` \n\
    \ -h, --help         Mostra a mensagem de uso do programa."

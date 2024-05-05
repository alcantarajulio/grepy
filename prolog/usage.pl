:- module(usage, [usage/1]).

usage(Return):-
    Return="Usage: grepy [-c | --count] [-r | --recursive] 
       [-w | --word-regexp] [-e | --exclude] [-h | --help] <file> 
O grepy procura por casamento dos padrões nos arquivos ou string passadas como entrada para o programa.

options: 
-c, --count              Exibe a contagem dos padrões casados.
-r, --recursive          Procura pelo padrão nos arquivos do diretório passado como parâmetro, recursivamente.
-e, --recursive-exclude  Tem funcionamento similar a `--recursive`, porem desconsidera o arquivo passado.  
-w, --word-regexp        O padrão é buscado seguindo a palavra passada como parâmetro.
-h, --help               Mostra a mensagem de uso do programa.".
:- module(utils, [file_exists/1, isFlag/1, verifyRecursivesCases/1, usage/1, from_stdin/0, stdin_reader/1]).

:- use_module(library(tty)).

file_exists(File) :- 
    exists_file(File).


from_stdin :-
    current_input(Input),
    \+ stream_property(Input, tty(true)).  


isFlag(Flag) :-
    member(Flag, ["--count", "-c", "--help", "-h",
                  "--word-regexp", "-w", "--recursive", "-r",
                  "--recursive-exclude", "-e"]).

verifyRecursivesCases(Flag) :-
    member(Flag, ["--recursive", "-r", "--recursive-exclude", "-e"]).

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

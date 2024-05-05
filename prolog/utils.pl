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

% xor(true, false).
% xor(false, true).

% xor(A, B) :-
%     dif(A, B).



% stdin_reader(Lines) :-
%     stream_lines(user_input, Lines).

% stream_lines(In, Lines) :-
%     read_string(In, _, Str),
%     split_string(Str, "\n", "\n", Lines).


stdin_reader(String) :-
    stream_lines('teste.txt', String).

stream_lines(FileName, String) :-
    open(FileName, read, Stream),
    read_lines(Stream, Lines),
    atomic_list_concat(Lines, '\n', String),
    close(Stream).

read_lines(Stream, []) :-
    at_end_of_stream(Stream).
read_lines(Stream, [Line|Rest]) :-
    \+ at_end_of_stream(Stream),
    read_line_to_string(Stream, Line),
    read_lines(Stream, Rest).



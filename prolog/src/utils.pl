:- module(utils, [file_exists/1, 
                isFlag/1, 
                verifyRecursivesCases/1, 
                verifyInput/1, 
                usage/1, 
                from_stdin/0, 
                stdin_reader/1, 
                xor/2,
                convert_array_to_string/2,
                atom_to_string/2,
                verifyCount/1
                ]).

:- use_module(library(tty)).

file_exists(File) :- 
    exists_file(File).


from_stdin :-
    current_input(Input),
    \+ stream_property(Input, tty(true)).  


isFlag(Flag) :-
    List = ['--count', '-c', '--help', '-h', '--word-regexp', '-w', '--recursive', '--recursive-exclude', '-e'],
    member(Flag, List).

verifyRecursivesCases(Flag) :-
    member(Flag, ['--recursive', '-r', '--recursive-exclude', '-e']).

verifyCount(Flag) :-
    member(Flag, ['--count', '-c']).

verifyInput(Args) :-
    xor(from_stdin, file_exists(Args)).

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


xor(true, false).
xor(false, true).

xor(A, B) :-
    dif(A, B).


stdin_reader(Result) :-
    stream_lines(user_input, Result).

stream_lines(Input, Lines) :-
    read_string(Input, _, String),
    split_string(String, "\n", "\n", Lines).

read_lines(Stream, []) :-
    at_end_of_stream(Stream).
read_lines(Stream, [Line|Rest]) :-
    \+ at_end_of_stream(Stream),
    read_line_to_string(Stream, Line),
    read_lines(Stream, Rest).

convert_array_to_string([], '').
convert_array_to_string([X], X).
convert_array_to_string([X|Xs], String) :-
    convert_array_to_string(Xs, Rest),
    string_concat(X, '\n', LineWithNewLine),
    string_concat(LineWithNewLine, Rest, String).

atom_to_string(Atom, String) :-
    atom_chars(Atom, String).

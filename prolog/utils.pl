:- module(utils, [file_exists/1, is_recursive/1, isFlag/1, verifyRecursivesCases/1]).

file_exists(File) :- 
    exists_file(File).

is_recursive("--recursive").

stdin_is_pipe :-
    \+ tty(0).

isFlag(Flag) :-
    member(Flag, ["--count", "-c", "--help", "-h",
                  "--word-regexp", "-w", "--recursive", "-r",
                  "--recursive-exclude", "-e"]).

verifyRecursivesCases(Flag) :-
    member(Flag, ["--recursive", "-r", "--recursive-exclude", "-e"]).


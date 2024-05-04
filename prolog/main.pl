:- use_module(dispatch).
:- use_module(usage).
% :- use_module().
% :- use_module().

% parse_args :-
%     current_prolog_flag(argv, Argv),
%     parse_arguments(Argv).
%
% parse_arguments([]).
% parse_arguments([Arg|Rest]) :-
%     dispatch(Arg),
%     parse_arguments(Rest).

% process_argument('--help') :-
%     writeln('Mensagem de usage aqui').
%
% process_argument(Other) :-
%     writeln('Mensagem de erro aqui'),
%     writeln(Other).

handle_args([], Result) :-
    usage.

handle_args([Arg1], Result) :-
    writeln('UM ARGUMENTO').

handle_args([Arg1, Arg2], Result) :-
    % In this predicate, Arg1 could be a file or the string to be matched.
    dispatch(Arg1, Arg2, Result).
    writeln(Result).

handle_args([Arg1, Arg2, Arg3], Result) :-
    writeln('UM ARGUMENTO').
    writeln(Result).

handle_args([Arg1, Arg2, Arg3, Arg4], Result) :-
    writeln('QUATRO ARGUMENTO').
    writeln(Result).

file_exists(File) :- exists_file(File).

main :-
    current_prolog_flag(argv, Argv),
    handle_args(Argv, Result),
    halt.

:- initialization(main).

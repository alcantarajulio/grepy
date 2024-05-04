:- use_module(dispatch).
:- use_module(usage).
:- use_module(utils).
:- use_module(io).
:- use_module(usage).

% grepy
handle_args([], Result) :-
    usage(Result).
% grepy -help
% grepy -h
handle_args([Arg1], Result) :-
    dispatch(Arg1, Result).

% grepy <pattern> file_path
% grepy <pattern> stdin
handle_args([Arg1, Arg2], Result) :-
    (file_exists(Arg2) -> (go(Arg2, Out), dispatch(Arg1, Out, Result)); dispatch(Arg1, Arg2, Result)).

% grepy --count <pattern> file_path
% grepy --count <pattern> stdin
% grepy -c <pattern> file_path
% grepy -c <pattern> stdin
% grepy -word-regexp <pattern> file_path
% grepy -word-regexp <pattern> stdin
% grepy -w <pattern> file_path
% grepy -w <pattern> stdin
% grepy --recursive <pattern> dir_path
% grepy -r <pattern> dir_path
handle_args([Arg1, Arg2, Arg3], Result) :-
    (is_recursive(Arg1) -> dispatchRecursive(Arg1, Arg2, Arg3, Result); (file_exists(Arg3) -> (go(Arg3, Out), dispatch(Arg1, Arg2, Out, Result)); dispatch(Arg1, Arg2, Arg3, Result))).

% grepy --recursive-exclude <pattern> file_path dir_path
% grepy -e <pattern> file_path dir_path
handle_args([Arg1, Arg2, Arg3, Arg4], Result) :-
% falta fazer verificações
    dispatchRecurssiveExclude(Arg1,Arg2,Arg3,Arg4,Result).

main :-
    current_prolog_flag(argv, Argv),
    handle_args(Argv, Result),
    writeln(Result),
    halt.

:- initialization(main).

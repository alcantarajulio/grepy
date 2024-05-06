:- use_module(dispatch).
:- use_module(utils).
:- use_module(io).
:- use_module(writer).

% grepy
handle_args([]) :-
    usage(Result),
    print_strings(Result).
% grepy -help
% grepy -h
% grepy <pattern> stdin
handle_args([Arg1]) :-
    (verifyInput(Arg1) -> 
        (from_stdin ->
            stdin_reader(StdinReturn),
            convert_array_to_string(StdinReturn, Out),
            (dispatch(Arg1, Out, Result) -> true ; usage(Result))
        ; usage(Result))
    ; usage(Result)),
    print_strings(Result).


% grepy <pattern> file_path
% grepy --count <pattern> stdin
% grepy -c <pattern> stdin
% grepy -word-regexp <pattern> stdin
% grepy -w <pattern> stdin
handle_args([Arg1, Arg2]) :-

    (from_stdin ->
        (isFlag(Arg1) ->
            stdin_reader(StdinReturn),
            convert_array_to_string(StdinReturn, Out),
            (dispatch(Arg1, Arg2, Out, Result) -> true ; usage(Result))
        ; usage(Result))
    ; (file_exists(Arg2) ->
        go(Arg2, FileReturn),
        (dispatch(Arg1, FileReturn, Result) -> true ; usage(Result))
        ; usage(Result))),
    print_strings(Result).

% grepy --count <pattern> file_path
% grepy -c <pattern> file_path
% grepy -word-regexp <pattern> file_path
% grepy -w <pattern> file_path
% grepy --recursive <pattern> dir_path
% grepy -r <pattern> dir_path
handle_args([Arg1, Arg2, Arg3]) :-
    (verifyRecursivesCases(Arg1) ->
        (dispatchRecursive(Arg1, Arg2, Arg3) -> true ; usage(Result), print_strings(Result))
    ; (file_exists(Arg3) ->
        go(Arg3, FileReturn),
        (dispatch(Arg1, Arg2, FileReturn, Result) -> print_strings(Result); usage(Result), print_strings(Result))
        ; usage(Result), print_strings(Result))).
   

% grepy --recursive-exclude <pattern> file_path dir_path
% grepy -e <pattern> file_path dir_path
handle_args([Arg1, Arg2, Arg3, Arg4]) :-
    (verifyRecursivesCases(Arg1) -> 
        (dispatchRecursiveExclude(Arg1,Arg2, Arg3, Arg4) -> true ; usage(Result), print_strings(Result))
    ; usage(Result), print_strings(Result)).


main :-
  
    current_prolog_flag(argv, Argv),
    handle_args(Argv),
    halt.


:- initialization(main).

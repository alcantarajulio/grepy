:- use_module(dispatch).
:- use_module(utils).
:- use_module(io).

% grepy
handle_args([], Result) :-
    usage(Result).
% grepy -help
% grepy -h
% grepy <pattern> stdin
handle_args([Arg1], Result) :-
    (verifyInput(Arg1) -> 
        (from_stdin ->
            stdin_reader(StdinReturn),
            convert_array_to_string(StdinReturn, Out),
            (dispatch(Arg1, Out, Result) -> true ; usage(Result))
        ; usage(Result))
    ; usage(Result)).
    % (from_stdin -> (stdin_reader(StdinReturn), writeln(StdinReturn));usage(Result)).

% grepy <pattern> file_path
% grepy --count <pattern> stdin
% grepy -c <pattern> stdin
% grepy -word-regexp <pattern> stdin
% grepy -w <pattern> stdin
handle_args([Arg1, Arg2], Result) :-
    % (isFlag(Arg1) -> writeln(oi) ; writeln(nao)).
    (from_stdin ->
        (isFlag(Arg1) ->
            stdin_reader(StdinReturn),
            convert_array_to_string(StdinReturn, Out),
            (dispatch(Arg1, Arg2, Out, Result) -> true ; usage(Result))
        ; usage(Result))
    ; (file_exists(Arg2) ->
        go(Arg2, FileReturn),
        (dispatch(Arg1, FileReturn, Result) -> true ; usage(Result))
        ; usage(Result))).

    % (from_stdin -> (stdin_reader(StdinReturn),dispatch(Arg1, Arg2, StdinReturn, Result)); (file_exists(Arg2) -> go(Arg2,ReturnIO),dispatch(Arg1, ReturnIO, Result); usage(Result))),
    % writeln(ReturnIO).


% grepy --count <pattern> file_path
% grepy -c <pattern> file_path
% grepy -word-regexp <pattern> file_path
% grepy -w <pattern> file_path
% grepy --recursive <pattern> dir_path
% grepy -r <pattern> dir_path
handle_args([Arg1, Arg2, Arg3], Result) :-
    (verifyRecursivesCases(Arg1) ->
        (dispatchRecursive(Arg1, Arg2, Arg3, Result) -> true ; usage(Result))
    ; (file_exists(Arg3) ->
        go(Arg3, FileReturn),
        (dispatch(Arg1, Arg2, FileReturn, Result) -> true; usage(Result))
        ; usage(Result))).
   
    % (isFlag(/Arg1) -> 
    %     (file_exists(Arg3) ->
    %         (go(Arg3, ResultIO), dispatch(Arg1,Arg2,ResultIO,Result)); (verifyRecursivesCases(Arg1) -> dispatchRecursive(Arg1, Arg2, Arg3, Result)
    %     ; usage(Result)))
    % ; usage(Result)).
    
    % (isFlag(Arg1) -> 
    % ((is_recursive(Arg1) -> 
    %     dispatchRecursive(Arg1, Arg2, Arg3, Result);
    %     (file_exists(Arg3) -> (go(Arg3, Out), dispatch(Arg1, Arg2, Out, Result)); dispatch(Arg1, Arg2, Arg3, Result))))
    % ;usage(Result).

% grepy --recursive-exclude <pattern> file_path dir_path
% grepy -e <pattern> file_path dir_path
handle_args([Arg1, Arg2, Arg3, Arg4], Result) :-
    (verifyRecursivesCases(Arg1) -> 
        (dispatchRecursiveExclude(Arg1,Arg2, Arg3, Arg4, Result) -> true ; usage(Result))
    ; usage(Result)).
    % (dispatchRecurssiveExclude(Arg1,Arg2,Arg3,Arg4,Result);usage(Result)).

main :-
  
    current_prolog_flag(argv, Argv),
    handle_args(Argv, Result),
    writeln(Result),
    halt.

      % leitor(Result),
    % writeln(Result).

% leitor([Line|Tail]):-
% read_line_to_string(user_input,Line),
%     (   Line \= end_of_file -> 
%         leitor(Tail);
%         true
%     ).

:- initialization(main).

:- use_module(dispatch).
:- use_module(utils).
:- use_module(io).

% grepy
handle_args([], Result) :-
    usage(Result).
% grepy -help
% grepy -h
handle_args([Arg1], Result) :-
    (isFlag(Arg1) -> dispatch(Arg1, Result);usage(Result)).

% grepy <pattern> file_path
% grepy <pattern> stdin
handle_args([Arg1, Arg2], Result) :-
    ((file_exists(Arg2) -> (go(Arg2, Out), dispatch(Arg1, Out, Result)); dispatch(Arg1, Arg2, Result)); usage(Result)).

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
    (isFlag(Arg1) -> 
    (verifyRecursivesCases(Arg1) ->
        dispatchRecursive(Arg1, Arg2, Arg3, Result)
        ; (file_exists(Arg3) -> 
            go(Arg3, Out), dispatch(Arg1, Arg2, Out, Result)
          ;  
          )
    )
    ; usage(Result)
    )
    
    % (isFlag(Arg1) -> 
    % ((is_recursive(Arg1) -> 
    %     dispatchRecursive(Arg1, Arg2, Arg3, Result);
    %     (file_exists(Arg3) -> (go(Arg3, Out), dispatch(Arg1, Arg2, Out, Result)); dispatch(Arg1, Arg2, Arg3, Result))))
    % ;usage(Result).

% grepy --recursive-exclude <pattern> file_path dir_path
% grepy -e <pattern> file_path dir_path
handle_args([Arg1, Arg2, Arg3, Arg4], Result) :-
% falta fazer verificações
    (dispatchRecurssiveExclude(Arg1,Arg2,Arg3,Arg4,Result);usage(Result)).

main :-
    % leitor(Result),
    % writeln(Result).
    
    current_prolog_flag(argv, Argv),
    handle_args(Argv, Result),
    writeln(Result),
    halt.


% leitor([Line|Tail]):-
% read_line_to_string(user_input,Line),
%     (   Line \= end_of_file -> 
%         leitor(Tail);
%         true
%     ).

:- initialization(main).

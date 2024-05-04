:- use_module(dispatch).
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

uso :-
    dispatch('--help', _, _).

main :-
    halt.

:- initialization(main).

:- module(dispatch, [dispatch/2,dispatch/3, dispatch/4, dispatchRecursive/4, dispatchRecursiveExclude/5]).

:- use_module(grepy).
:- use_module(usage).
:- use_module(count).
:- use_module(wordRegex).

% Usages
dispatch('--help', Result) :- usage.
dispatch('-h', Result) :- usage.

% Grepy with no flags.
dispatch(Pattern, Content, Result) :- grepy(Pattern, Content, Result).

% Count.
dispatch('--count', Pattern, Content, Result) :- 
    grepy(Pattern, Content, ParcialResult),
    contar_linhas(ParcialResult, Result). 
dispatch('-c', Pattern, Content,Result ) :-
    grepy(Pattern, Content, ParcialResult),
    contar_linhas(ParcialResult, Result). 

% Wordregexp.
dispatch('--wordregexp', Pattern, Content, Result) :-
    gerar_regex(regex, Pattern),
    grepy(regex, Content, Result).
dispatch('-w', Pattern, Content, Result) :-
    gerar_regex(regex, Pattern),
    grepy(regex, Content, Result).

% Recurssive
dispatchRecursive('--recursive', Pattern, Path, Result) :-
    recurssive(Pattern, Path, Result).
dispatchRecursive('-r', Pattern, Path, Result) :-
    recurssive(Pattern, Path, Result).

% Recurssive Exclude
dispatchRecursiveExclude('--recursive-exclude', Pattern, FilePath, Path ,Result) :-
    recurssive(Pattern, FilePath, Path, Result).
dispatchRecursiveExclude('-e', Pattern, FilePath, Path ,Result) :-
    recurssive(Pattern, FilePath, Path, Result).

% Nothing
% dispatch(_, _, _) :- usage, write('esse caso').

:- module(dispatch, [dispatch/2,dispatch/3, dispatch/4, dispatchRecursive/3, dispatchRecursiveExclude/4]).

:- use_module(grepy).
:- use_module(utils).
:- use_module(count).
:- use_module(wordRegex).
:- use_module(recursive).

% Usages
dispatch('--help', Result) :- usage(Result).
dispatch('-h', Result) :- usage(Result).

% Grepy with no flags.
dispatch(Pattern, Content, Result) :- grepy(Pattern, Content, Result).

% Count.
dispatch('--count', Pattern, Content, Result) :- 
    grepy(Pattern, Content, ParcialResult),
    contar_linhas(ParcialResult, Result). 
dispatch('-c', Pattern, Content, Result ) :-
    grepy(Pattern, Content, ParcialResult),
    contar_linhas(ParcialResult, Result). 

% Word-regexp.
dispatch('--word-regexp', Pattern, Content, Result) :-
    gerar_regex(Pattern, Regex),
    grepy(Regex, Content, Result).
dispatch('-w', Pattern, Content, Result) :-
    gerar_regex(Pattern, Regex),
    grepy(Regex, Content, Result).

% Recursive
dispatchRecursive('--recursive', Pattern, Path) :-
    recursive_grepy(Pattern, Path).
dispatchRecursive('-r', Pattern, Path) :-
    recursive_grepy(Pattern, Path).

% Recursive Exclude
dispatchRecursiveExclude('--recursive-exclude', Pattern, FilePath, Path) :-
    recursive_exclude_grepy(Pattern, FilePath, Path).
dispatchRecursiveExclude('-e', Pattern, FilePath, Path) :-
    recursive_exclude_grepy(Pattern, FilePath, Path).

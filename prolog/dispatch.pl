:- module(dispatch, [dispatch/2,dispatch/3, dispatch/4, dispatchRecursive/4, dispatchRecursiveExclude/5]).

:- use_module(grepy).
:- use_module(utils).
:- use_module(count).
:- use_module(wordRegex).

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
dispatchRecursive('--recursive', Pattern, Path, Result) :-
    recursive(Pattern, Path, Result).
dispatchRecursive('-r', Pattern, Path, Result) :-
    recursive(Pattern, Path, Result).

% Recursive Exclude
dispatchRecursiveExclude('--recursive-exclude', Pattern, FilePath, Path ,Result) :-
    recursive(Pattern, FilePath, Path, Result).
dispatchRecursiveExclude('-e', Pattern, FilePath, Path ,Result) :-
    recursive(Pattern, FilePath, Path, Result).
 

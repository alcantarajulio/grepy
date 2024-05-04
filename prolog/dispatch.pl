:- module(dispatch, [dispatch/3, dispatch/2, dispatch/1]).

:- use_module(grepy).
:- use_module(usage).

% Usages.
dispatch('--help', Result) :- usage.
dispatch('-h') :- usage.

% Grepy with no flags.
dispatch(Pattern, Content, Result) :- grepy(Pattern, Content, Result).

% Count.
dispatch('--count', Pattern, Content) :- usage, write(4). 
dispatch('-c', Pattern, Content) :- usage.

% Wordregexp.
dispatch('--wordregexp', Pattern, Content) :- usage.
dispatch('-w', Pattern, Content) :- usage.

% dispatch(_, _, _) :- usage, write('esse caso').

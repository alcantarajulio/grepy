:- module(dispatch, [dispatch/3]).


usage :-
    writeln('bucetinha xebas isaac').

% Usages.
dispatch('--help', _, _) :- usage, write(1).
dispatch('-h', _, _) :- usage, write(2).

% Count.
dispatch('--count', Pattern, Content) :- usage, write(4). 
dispatch('-c', Pattern, Content) :- usage.

% Wordregexp.
dispatch('--wordregexp', Pattern, Content) :- usage.
dispatch('-w', Pattern, Content) :- usage.

% dispatch(_, Pattern, Content) :- usage, write(3).
% dispatch(_, _, _) :- usage, write('esse caso').

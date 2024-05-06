:- module(io, [go/2]).

:- use_module(library(pio)).
:- use_module(library(dcg/basics)).

quoted([]) --> eos.
quoted([Line|Ls]) --> string(Chars),
                      {append([0''|Chars], [0''], Quoted),
                       atom_chars(Line, Quoted) },
                      eol, quoted(Ls).

go(FilePath, Out):-
    once(phrase_from_file(quoted(Lines), FilePath)),
    atomics_to_string(Lines, '\n', Out).

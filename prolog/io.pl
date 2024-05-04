:- use_module(library(pio)).
:- use_module(library(dcg/basics)).
:- initialization(go, main).

quoted([]) --> eos.
quoted([Line|Ls]) --> string(Chars),
                      {append([0''|Chars], [0''], Quoted),
                       atom_chars(Line, Quoted) },
                      eol, quoted(Ls).

go:-
    once(phrase_from_file(quoted(Lines), 'data.txt')),

    atomics_to_string(Lines, '\n', Out),

    open('t.txt', write, Stream),
    write(Stream, Out),
    nl(Stream),
    close(Stream).

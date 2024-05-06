:- module(writer, [print_strings/1]).

print_strings([]).
print_strings([String|Rest]) :-
    atom_string(Atom, String),
    write(Atom),
    nl,
    print_strings(Rest).


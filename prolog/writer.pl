:- module(writer, [print_strings/1]).


print_strings([]).
print_strings([String|Rest]) :-
    atom_string(Atom, String), % Convert string to atom
    write(Atom), % Print the atom
    nl, % Newline
    print_strings(Rest).


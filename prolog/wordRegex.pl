:- module(wordRegex, [gerar_regex/2]).

gerar_regex(Palavra, Regex) :-
    format(atom(Regex), '\\b~w\\b', [Palavra]).

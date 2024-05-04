:- module(wordRegex, [gerar_regex/2]).

% Gera uma regex para buscar a palavra como um termo independente, ignorando maiúsculas e minúsculas
gerar_regex(Palavra, Regex) :-
    format(atom(Regex), '\\b~w\\b', [Palavra]).

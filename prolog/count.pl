:- module(count, [contar_linhas/2]).

% Conta o número de linhas em uma lista de linhas pintadas
contar_linhas(LinhasPintadas, Contagem) :-
    length(LinhasPintadas, Contagem).

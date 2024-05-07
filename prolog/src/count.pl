:- module(count, [contar_linhas/2]).

contar_linhas(LinhasPintadas, Contagem) :-
    length(LinhasPintadas, Contagem).

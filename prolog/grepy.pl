:- use_module(format).

encontrar_linhas_com_pintura(Padrao, Texto) :-
    split_string(Texto, "\n", "", ListaLinhas),
    formatar_linhas_correspondentes(ListaLinhas, Padrao).

formatar_linhas_correspondentes([], _).
formatar_linhas_correspondentes([Linha|Resto], Padrao) :-
    (   re_match(Padrao, "^L") 
    ->  pinta_linha_inteira(Linha, Padrao, Pintada)
    ;   pinta_ocorrencias(Linha, Padrao, Pintada)
    ),
    format("Linha formatada: ~w~n", [Pintada]),
    formatar_linhas_correspondentes(Resto, Padrao).

teste_encontrar_e_pintar_linhas :-
    Texto = "prova de plp\nparadigmas de linguagem de programaçao (plp)\nplpelegal",
    Padrao = "e",
    encontrar_linhas_com_pintura(Padrao, Texto).

:- initialization(teste_encontrar_e_pintar_linhas).
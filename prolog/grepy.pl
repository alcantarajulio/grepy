:- use_module(format).


% Encontra e pinta linhas com o padrão, retornando uma lista de linhas pintadas
encontrar_linhas_com_pintura(Padrao, Texto, LinhasPintadas) :-
    split_string(Texto, "\n", "", ListaLinhas),  % Divide o texto em linhas
    formatar_linhas_correspondentes(ListaLinhas, Padrao, LinhasPintadas).  % Processa cada linha e acumula as pintadas

% Processa cada linha recursivamente, verifica o padrão e aplica a pintura apropriada
formatar_linhas_correspondentes([], _, []).
formatar_linhas_correspondentes([Linha|Resto], Padrao, LinhasPintadas) :-
    (   re_match(Padrao, Linha)  % Verifica se o padrão corresponde em algum lugar na linha
    ->  escolher_pintura(Linha, Padrao, Pintada),
        LinhasPintadas = [Pintada|OutrasLinhasPintadas],  % Inclui a linha pintada na lista de retorno
        format("Linha formatada: ~w~n", [Pintada])  % Imprime a linha formatada para verificação
    ;   LinhasPintadas = OutrasLinhasPintadas
    ),
    formatar_linhas_correspondentes(Resto, Padrao, OutrasLinhasPintadas).

% Escolhe entre pintar toda a linha ou apenas as ocorrências
escolher_pintura(Linha, Padrao, Pintada) :-
    (   re_match("^L", Padrao)  % Se o padrão é para pintar toda a linha
    ->  pinta_linha_inteira(Linha, Padrao, Pintada)
    ;   pinta_ocorrencias(Linha, Padrao, Pintada)
    ).

teste_encontrar_e_pintar_e_contar_linhas :-
    Texto = "prova de plp\nparadigmas de linguagem de programaçao (plp)\nplpelegal\nPLP e coisa de gente boa\nCDG",
    Palavra = "a",
    % gerar_regex(Palavra, Padrao),  % Gera a regex apropriada para a palavra
    encontrar_linhas_com_pintura(Palavra, Texto, LinhasPintadas),
    %contar_linhas(LinhasPintadas, Contagem),
    %format("Regex usada: ~w~n", [Padrao]),
    format("Linhas pintadas: ~w~n", [LinhasPintadas]),
    %format("Número de linhas com correspondências: ~d~n", [Contagem]),
    halt.

:- initialization(teste_encontrar_e_pintar_e_contar_linhas).

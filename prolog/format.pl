% Esse é formatar que nao retorna nada se o padrao nao for encontrado

:- dynamic delimitador/1.
delimitador('\e[31m').  % Código ANSI para texto vermelho
fim_delimitador('\e[0m').  % Código ANSI para resetar a formatação

% Função para contar as ocorrências do padrão no texto
conta_ocorrencias(Text, Pattern, Count) :-
    atom_concat(_, Rest, Text),
    atom_concat(Pattern, Suffix, Rest),
    !,
    conta_ocorrencias(Suffix, Pattern, SubCount),
    Count is 1 + SubCount.
conta_ocorrencias(_, _, 0).

% Função para pintar as ocorrências do padrão no texto
pinta_padrao(Text, Pattern, PaintedText) :-
    delimitador(Delim),
    fim_delimitador(EndDelim),
    atom_concat(Prefix, Rest, Text),
    atom_concat(Pattern, Suffix, Rest),
    !,
    pinta_padrao(Suffix, Pattern, PaintedRest),
    atom_concat(Prefix, Delim, Start),
    atom_concat(Start, Pattern, Middle),
    atom_concat(Middle, EndDelim, HighlightedPattern),
    atom_concat(HighlightedPattern, PaintedRest, PaintedText).
pinta_padrao(Text, _, Text).

% Função principal para pintar e retornar a linha ou string vazia se padrão não encontrado
linha_pintada(Text, Pattern, Result) :-
    conta_ocorrencias(Text, Pattern, Count),
    (
        Count > 0
    ->  pinta_padrao(Text, Pattern, PaintedText),
        Result = PaintedText
    ;   Result = ''
    ).

% Teste
:- initialization(main).

main :-
    Text = 'flamengo e brasileirao\nflamengo é campeao\n todo mundo viu o flamengo de 2019',
    Pattern = 'a',
    linha_pintada(Text, Pattern, Resultado),
    writeln(Resultado),
    halt.


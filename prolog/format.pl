:- module(format, [pinta_linha_inteira/3, pinta_ocorrencias/3]).

:- use_module(library(pcre)).

:- dynamic delimitador/1, fim_delimitador/1.
delimitador('\e[31m').  % Código ANSI para texto vermelho
fim_delimitador('\e[0m').  % Código ANSI para resetar a formatação

pinta_linha_inteira(Text, Pattern, PaintedText) :-
    delimitador(Delim),
    fim_delimitador(EndDelim),
    (   re_match(Pattern, Text) 
    ->  atom_concat(Delim, Text, Start),
        atom_concat(Start, EndDelim, PaintedText)
    ;   PaintedText = Text
    ).

pinta_ocorrencias(Text, Pattern, PaintedText) :-
    delimitador(Delim),
    fim_delimitador(EndDelim),
    re_split(Pattern, Text, Parts, [include_delimiter(true)]),
    pinta_partes(Parts, Pattern, Delim, EndDelim, PaintedText).

pinta_partes([], _, _, _, "").
pinta_partes([Part|Rest], Pattern, Delim, EndDelim, PaintedText) :-
    (   re_match(Pattern, Part) 
    ->  atom_concat(Delim, Part, PartStart),
        atom_concat(PartStart, EndDelim, PaintedPart)
    ;   PaintedPart = Part
    ),
    pinta_partes(Rest, Pattern, Delim, EndDelim, PaintedRest),
    atom_concat(PaintedPart, PaintedRest, PaintedText).

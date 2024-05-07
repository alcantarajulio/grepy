:- module(format, [paint_whole_line/3, paint_occurrences/3]).

:- use_module(library(pcre)).

:- dynamic delimiter/1, end_delimiter/1.
delimiter('\e[31m').
end_delimiter('\e[0m').


paint_whole_line(Text, Pattern, PaintedText) :-
    delimiter(Delim),
    end_delimiter(EndDelim),
    (   re_match(Pattern, Text) 
    ->  atom_concat(Delim, Text, Start),
        atom_concat(Start, EndDelim, PaintedText)
    ;   PaintedText = Text
    ).

paint_occurrences(Text, Pattern, PaintedText) :-
    delimiter(Delim),
    end_delimiter(EndDelim),
    re_split(Pattern, Text, Parts, [include_delimiter(true)]),
    paint_parts(Parts, Pattern, Delim, EndDelim, PaintedText).

paint_parts([], _, _, _, "").
paint_parts([Part|Rest], Pattern, Delim, EndDelim, PaintedText) :-
    (   re_match(Pattern, Part) 
    ->  atom_concat(Delim, Part, PartStart),
        atom_concat(PartStart, EndDelim, PaintedPart)
    ;   PaintedPart = Part
    ),
    paint_parts(Rest, Pattern, Delim, EndDelim, PaintedRest),
    atom_concat(PaintedPart, PaintedRest, PaintedText).

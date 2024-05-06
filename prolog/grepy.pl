:- module(grepy, [grepy/3]).

:- use_module(format).
:- use_module(wordRegex).
:- use_module(count).


grepy(Pattern, Text, PaintedLines) :-
    split_string(Text, "\n", "", LinesList),
    format_corresponding_lines(LinesList, Pattern, PaintedLines).


format_corresponding_lines([], _, []).
format_corresponding_lines([Line|Rest], Pattern, PaintedLines) :-
    (   re_match(Pattern, Line) 
    ->  choose_paint(Line, Pattern, Painted),
        PaintedLines = [Painted|OtherPaintedLines] 
    ;   PaintedLines = OtherPaintedLines
    ),
    format_corresponding_lines(Rest, Pattern, OtherPaintedLines).


choose_paint(Line, Pattern, Painted) :-
    (   re_match("^L", Pattern)
    ->  paint_whole_line(Line, Pattern, Painted)
    ;   paint_occurrences(Line, Pattern, Painted)
    ).

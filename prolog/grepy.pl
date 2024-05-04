:- use_module(format).

% Finds and paints lines with the pattern, returning a list of painted lines
find_lines_with_paint(Pattern, Text, PaintedLines) :-
    split_string(Text, "\n", "", LinesList),  % Divides the text into lines
    format_corresponding_lines(LinesList, Pattern, PaintedLines).  % Processes each line and accumulates the painted ones

% Recursively processes each line, checks the pattern, and applies appropriate painting
format_corresponding_lines([], _, []).
format_corresponding_lines([Line|Rest], Pattern, PaintedLines) :-
    (   re_match(Pattern, Line)  % Checks if the pattern matches anywhere in the line
    ->  choose_paint(Line, Pattern, Painted),
        PaintedLines = [Painted|OtherPaintedLines]  % Includes the painted line in the return list
    ;   PaintedLines = OtherPaintedLines
    ),
    format_corresponding_lines(Rest, Pattern, OtherPaintedLines).

% Chooses between painting the entire line or just the occurrences
choose_paint(Line, Pattern, Painted) :-
    (   re_match("^L", Pattern)  % If the pattern is to paint the entire line
    ->  paint_whole_line(Line, Pattern, Painted)
    ;   paint_occurrences(Line, Pattern, Painted)
    ).



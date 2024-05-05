:- use_module(library(filesex)).
:- use_module(library(pcre)).
:- use_module(format).

% Global variables for color.
:- dynamic delimitador/1, fim_delimitador/1.
delimitador('\e[31m').  % ANSI code for red text
fim_delimitador('\e[0m').  % ANSI code to reset formatting

% Processes each file found recursively.
process_files(DirPath, Pattern) :-
    forall(recursive(DirPath, FilePath),
           process_file(FilePath, Pattern)).

% Processes the file, trying to read and paint the lines with the specified pattern.
process_file(FilePath, Pattern) :-
    catch(
        setup_call_cleanup(
            open(FilePath, read, Stream),
            process_and_paint_lines(Stream, Pattern, FilePath),
            close(Stream)
        ),
        Error,
        print_error(Error, FilePath)
    ).

% Prints error if failing to open or read the file.
print_error(Error, FilePath) :-
    format('Error processing file ~w: ~w~n', [FilePath, Error]).

% Reads and paints lines from a file based on the pattern.
process_and_paint_lines(Stream, Pattern, FileName) :-
    read_line_to_string(Stream, Line),
    (   Line \= end_of_file
    ->  (   find_lines_with_paint(Pattern, Line, Painted),
            (   Painted \= Line
            ->  format('~w: ~w~n', [FileName, Painted])  % Prints only the file name and the painted line
            ;   true  % Does nothing if there is no change after painting
            )
        ),
        process_and_paint_lines(Stream, Pattern, FileName)
    ;   true  % Ends if reaching the end of the file
    ).

% Searches pattern and applies painting if found.
find_lines_with_paint(Pattern, Line, Painted) :-
    (   re_match(Pattern, Line)
    ->  paint_occurrences(Line, Pattern, Painted)
    ;   Painted = Line  % Does not alter the line if there is no match
    ).

% Recursive function to find all files in a directory.
recursive(Dir, Member) :-
    directory_member(Dir, Member, [recursive(true)]),
    exists_file(Member).

% Initialization and testing of the program.
:- initialization(process_files('.', 'caralho')).
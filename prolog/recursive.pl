:- module(recursive, [recursive_grepy/2, recursive_exclude_grepy/3]).

:- use_module(library(filesex)).
:- use_module(library(pcre)).
:- use_module(format).


:- dynamic delimitador/1, fim_delimitador/1.
delimitador('\e[31m'). 
fim_delimitador('\e[0m'). 

recursive_exclude_grepy(Pattern, ExcludedFilePath, DirPath) :-
    forall(recursive_exclude(DirPath, ExcludedFilePath, FilePath),
           process_file(FilePath, Pattern)).


recursive_grepy(Pattern, DirPath) :-
    forall(recursive(DirPath, FilePath),
           process_file(FilePath, Pattern)).


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

print_error(Error, FilePath) :-
    format('Error processing file ~w: ~w~n', [FilePath, Error]).

process_and_paint_lines(Stream, Pattern, FileName) :-
    read_line_to_string(Stream, Line),
    (   Line \= end_of_file
    ->  (   find_lines_with_paint(Pattern, Line, Painted),
            (   Painted \= Line
            ->  format('~w: ~w~n', [FileName, Painted])
            ;   true 
            )
        ),
        process_and_paint_lines(Stream, Pattern, FileName)
    ;   true 
    ).


find_lines_with_paint(Pattern, Line, Painted) :-
    (   re_match(Pattern, Line)
    ->  paint_occurrences(Line, Pattern, Painted)
    ;   Painted = Line  
    ).


recursive(Dir, File) :-
    directory_member(Dir, File, [recursive(true)]),
    exists_file(File).


recursive_exclude(Dir, FileExcluded, File) :-
    directory_member(Dir, File, [recursive(true)]),
    File \= FileExcluded,
    exists_file(File).


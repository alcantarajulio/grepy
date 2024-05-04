:- module(utils, [file_exists/1, is_recursive/1]).

file_exists(File) :- 
    exists_file(File).

is_recursive("--recursive").

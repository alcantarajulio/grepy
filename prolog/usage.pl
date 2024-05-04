% Define options and their descriptions
option('-c', '--count', 'Exibe a contagem dos padrões casados.').
option('-r', '--recursive', 'Procura pelo padrão nos arquivos do diretório passado como parâmetro, recursivamente.').
option('-e', '--recursive-exclude', 'Tem funcionamento similar a `--recursive`, porém desconsidera o arquivo passado.').
option('-w', '--word-regexp', 'O padrão é buscado seguindo a palavra passada como parâmetro.').
option('-h', '--help', 'Mostra a mensagem de uso do programa.').

% Usage message
usage :-
    write('Usage: grepy [-c | --count] [-r | --recursive] '), nl,
    write('[-w | --word-regexp] [-e | --exclude] [-h | --help] <file>'), nl, nl,
    write('O grepy procura por casamento dos padrões nos arquivos ou string passadas como entrada para o programa.'), nl, nl,
    write('options:'), nl,
    show_options,
    !.  % Use the cut to stop backtracking and avoid printing 'true'

% Helper to print all options and their descriptions
show_options :-
    option(Short, Long, Description),
    format('~w, ~w~30|~w~n', [Short, Long, Description]),
    fail.
show_options.  % The final true is implicit here after fail


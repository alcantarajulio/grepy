# Documentação | Grepy
O `grepy` é uma implementação simplificada do comando `grep` do Linux em Haskell, utilizando como principal biblioteca `regex-tdfa`. Ele busca por padrões em arquivos e imprime as linhas que contêm esses padrões.

## Requisitos
  * GHC (Glasgow Haskell Compiler)
  * Biblioteca regex-tdfa
  * Colocar as outra bibliotecas necessárias

## Compilação e Execução
 Em vez de gerar um executável separado, o `grepy` é implementado como um script de shell que compila e executa diretamente o programa Haskell. Isso simplifica a utilização do `grepy`, já que você não precisa se preocupar com a compilação manual do código Haskell.

## Uso e Flags
Para usar o `grepy`, basta executar o script `grepy` fornecendo o padrão e o arquivo como argumentos:

* ./grepy "padrão" arquivo.txt

```bash
O `grepy` suporta as seguintes flags para personalizar a busca:

- `--count` ou `-c`: Exibe a contagem dos padrões casados.
- `--recursive` ou `-r`: Procura pelo padrão nos arquivos do diretório passado como parâmetro, recursivamente.
- `--wordregex` ou `-w`: O padrão é buscado seguindo a palavra passada como parâmetro.
- `--exclude` ou `-e`: Exclui um arquivo da busca recursiva. Deve ser usada em conjunto com `-r`.
- `--help` ou `-h`: Mostra a mensagem de uso do programa
```

## Exemplos de Uso das flags

###  Exibir a Contagem dos Padrões Casados
```bash
./grepy --count "padrão" arquivo.txt
``` 

### Buscar Recursivamente pelo Padrão em um Diretório
```bash
./grepy --recursive "padrão" diretório/
```

### Buscar Padrão Seguindo uma Palavra
```bash
./grepy --wordregex "padrão" arquivo.txt
``` 

### Excluir um Arquivo da Busca Rescursiva
```bash
./grepy --recursive --exclude "arquivo_excluído.txt" "padrão" diretório/
```

### Mostrar a Mensagem de Uso do Programa
```bash
./grepy --help 
```

## Autores

- Winicius Allan
- Ronald Matias
- Francisco Pereira
- Julio Alcântara
- Isaac Vicente


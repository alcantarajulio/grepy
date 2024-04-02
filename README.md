<h1 align="center">Grepy</h1>

O `grepy` é uma implementação simplificada do comando `grep`, do Linux, em
Haskell. Ele busca por padrões especificados pelo usuário em um dado arquivo ou
texto.

## Requisitos
  * [Haskell Stack](https://docs.haskellstack.org/en/stable/install_and_upgrade/)
  * [GHC (Glasgow Haskell Compiler)](https://www.haskell.org/downloads/)

## Compilação e Execução
    
Para poder usar o programa, antes é necessário que seja compilado e colocado em
algum dos diretórios de binário disponível no seu PATH. O script `setup.sh` é o
responsável por fazer isso, ele verifica se `/local/bin` está no seu PATH e
coloca o executável lá.

```bash
$ chmod +x setup.sh clean.sh
$ ./setup.sh
```

Caso o diretório não esteja no seu PATH, você deve adicionar a linha
`PATH=~/.local/bin:$PATH` no seu `.profile` ou `.bashrc` (ou equivalente).
Depois é necessário carregar o arquivo de configuração com:

```bash
source ~/.bashrc
```

Caso queira desfazer e apagar o utilitário, rode o `clean.sh`

## Uso e Flags
Para rodar o programa, basta executar `grepy` na linha de comando fornecendo o padrão e o arquivo como argumentos:

```bash
grepy <padrão> arquivo.txt
```

```bash
O `grepy` suporta as seguintes flags para personalizar a busca:

- `--count` ou `-c`: Exibe a contagem dos padrões casados.
- `--recursive` ou `-r`: Procura pelo padrão nos arquivos do diretório passado como parâmetro, recursivamente.
- `--word-regexp` ou `-w`: O padrão é buscado seguindo a palavra passada como parâmetro.
- `--recursive-exclude` ou `-e`: Exclui um arquivo da busca recursiva.
- `--help` ou `-h`: Mostra a mensagem de uso do programa
```

## Alguns exemplos

###  Exibir a contagem dos padrões casados
```bash
grepy --count <padrão> arquivo.txt
```

### Buscar recursivamente pelo padrão em um diretório
```bash
grepy --recursive <padrão> diretório/
```

### Buscar padrão seguindo uma palavra
```bash
grepy --word-regexp <padrão> arquivo.txt
```

### Excluir um arquivo da busca rescursiva
```bash
grepy --recursive "arquivo_excluído.txt" <padrão> diretório/
```

### Mostrar a mensagem de uso do programa
```bash
grepy --help
```

## Plataforma

O `grepy` foi desenvolvido e testado em sistemas Linux e macOS. O script de setup deve funcionar para esses casos.
Para Windows, o script mencionado não funciona, sendo necessário o usuário compilar o programa e executar o binário fornecido.
(Em Windows, recomendamos um terminal que ofereça suporte a _true color_).

## Autores

- [Winicius Allan](https://github.com/winiciusallan)
- [Ronaldd Matias](https://github.com/RonalddMatias)
- [Francisco Pereira](https://github.com/Francisco-xiq)
- [Julio Alcântara](https://github.com/alcantarajulio)
- [Isaac Vicente](https://github.com/isaacvicente)

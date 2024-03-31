<h1 align="center">Grepy</h1>

O `grepy` é uma implementação simplificada do comando `grep`, do Linux, em Haskell. Ele busca por padrões especificados pelo usuário em um dado arquivo ou texto.

## Requisitos
  * [Haskell Stack](https://docs.haskellstack.org/en/stable/install_and_upgrade/)
  * [GHC (Glasgow Haskell Compiler)](https://www.haskell.org/downloads/)

## Compilação e Execução
    
Para poder usar o programa, antes é necessário que seja compilado e colocado em algum dos diretórios de binário disponível no seu PATH. O script `setup.sh` é o responsável por fazer isso, ele garante que `/local/bin` esteja no seu PATH e coloca o executável lá.

```bash
$ chmod +x setup.sh clean.sh
$ ./setup.sh
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
- `--recursive-exclude` ou `-e`: Tem funcionamento similar a `--recursive`, porem exclui da busca o arquivo passado.
- `--wordregex` ou `-w`: O padrão é buscado seguindo a palavra passada como parâmetro.
- `--help` ou `-h`: Mostra a mensagem de uso do programa
```

## Alguns exemplos

###  Exibir a Contagem dos Padrões Casados
```bash
grepy --count <padrão> arquivo.txt
```

### Buscar Recursivamente pelo Padrão em um Diretório
```bash
grepy --recursive <padrão> diretório/
```

### Buscar Padrão Seguindo uma Palavra
```bash
grepy --wordregex <padrão> arquivo.txt
```

### Excluir um Arquivo da Busca Rescursiva
```bash
grepy --recursive --exclude "arquivo_excluído.txt" <padrão> diretório/
```

### Mostrar a Mensagem de Uso do Programa
```bash
grepy --help
```

## Autores

- [Winicius Allan](https://github.com/winiciusallan)
- [Ronaldd Matias](https://github.com/RonalddMatias)
- [Francisco Pereira](https://github.com/Francisco-xiq)
- [Julio Alcântara](https://github.com/alcantarajulio)
- [Isaac Vicente](https://github.com/isaacvicente)
```

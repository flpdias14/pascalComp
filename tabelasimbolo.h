#ifndef TABELA_SIMBOLO_H
#define TABELA_SIMBOLO_H
typedef union valor {
	int dval;
	float fval;
} valor;
typedef struct simbolo {
	int codigo;
	char *lexema;
	int tipo;
	valor val;
} simbolo;

typedef struct no_tabela_simbolo {
	simbolo *dado;
	struct no_tabela_simbolo *proximo;
} no_tabela_simbolo;

typedef struct tabela_simbolo {
	no_tabela_simbolo *primeiro;
} tabela_simbolo;

/*aloca memória e inicializa a tabela*/
tabela_simbolo * inicializar_tabela ();

/*insere o símbolo s na tabela (inserir no início da lista encadeada)
  o código de s deverá ser gerado automaticamente de maneira incremental
  o valor de retorno deve ser o código de s */
int inserir_simbolo(tabela_simbolo *tabela, simbolo * s);

/* imprime todos os elementos da tabela, formatado da seguinte maneira:
   - cada símbolo deve ser exibido em uma linha
   - cada linha deverá conter o código e o lexema, separados por um "tab" */
void exibir_tabela(tabela_simbolo *tabela);
void exibir_no(no_tabela_simbolo* no);
/*procura por um símbolo, a partir do nome, na tabela de símbolos e 
  retorna um ponteiro para o elemento encontrado. Caso não exista a função 
  deve retornar o valor null */
simbolo * localizar_simbolo_nome(tabela_simbolo *tabela, char *lexema);
simbolo * localizar_no_simbolo_nome(no_tabela_simbolo* no, char *lexema); 

/*procura por um símbolo, a partir do código, na tabela de símbolos e 
  retorna um ponteiro para o elemento encontrado. Caso não exista a função 
  deve retornar o valor null */
simbolo * localizar_simbolo_codigo(tabela_simbolo *tabela, int codigo);
simbolo * localizar_no_simbolo_codigo(no_tabela_simbolo* no, int codigo); 

/*verifica se já existe um símbolo com o nome correspondente ao lexema 
  passado como parâmetro. Em caso afirmativo, retorna o código do símbolo 
  encontrado. Em caso negativo, insere o novo símbolo e retorna seu código. */
int instalar_simbolo(tabela_simbolo *tabela, char *lexema);

/*aloca a memória necessária para armazenar uma estrutura do símbolo 
  e inicializa a variável lexema. Obs: para 'copiar' o valor de um string 
  para outro deve ser utilizada a função strcpy(destino, origem) */
simbolo * criar_simbolo(char *lexema);
tabela_simbolo* tabela;
#endif

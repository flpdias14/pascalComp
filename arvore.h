#ifndef ARVORE_H
#define ARVORE_H

#include <string.h>
#include "tabelasimbolo.h"
#include "y.tab.h"

/* Defina um tipo de dados(struct) para cada tipo de 
nó que irá compor a árvore sintática*/
typedef struct t_expr {
	int op;
	int tipo; //float ou int
	/*ponteiros do tipo void podem receber atribuição de variáveis ponteiros de qualquer tipo*/	
	void *dir, *esq;
	valor valor;
} t_expr;

typedef struct t_attr {
	simbolo *resultado;
	void *expressao;
} t_attr;


typedef struct t_decls{
	simbolo * simbolo;
	int tipo;
} t_decls;

typedef struct t_stmts {
	void *expressao;
} t_stmts;

/* A union valor_sintático está sendo utilizada para 
incorporar todos os tipos de nós declarados acima */
typedef union valor_sintatico {
	t_expr *expr;
	t_attr *attr;
	t_decls *decl;
	t_stmts *stmt;
} valor_sintatico;

/*desta forma, o nó da árvore deve conter a variável do tipo
valor_sintático, que por sua vez, pode assumir a forma de cada 
um dos tipos declarados anteriormente. Esta é uma forma de 
implementar o conceito de herança em uma linguagem que não 
oferece suporte. Neste caso, o valor_sintático assume o papel 
da superclasse abstrata e os tipos específicos (t_expr, t_att etc)
assumem o papel das subclasses. */
typedef struct no_arvore {
	int tipo; //expr, attr, stmt, ... Não confundir com o tipo int ou float
	valor_sintatico dado;
} no_arvore;

/*para cada tipo de nó, devem ser criadas duas funções:
Uma para inicialização da struct (funcionando como construtor);
E a outra para inicialização do nó correspondente.*/
no_arvore * criar_no_expressao(int op, void *dir, void *esq);
t_expr * criar_expressao(int op, void *dir, void *esq);

no_arvore * criar_no_atribuicao(simbolo *resultado, void *expressao);
t_attr * criar_atribuicao(simbolo *resultado, void *expressao);

no_arvore * criar_no_declaracao(simbolo * identificador, int tipo);
t_decls * criar_declaracao(simbolo * identificador, int tipo);

no_arvore * criar_no_statements(void * expressao);
t_stmts * criar_statements(void * expressao);
#endif

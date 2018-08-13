#include <stdlib.h>
#include <stdio.h>
#include "arvore.h"
#include "y.tab.h"

/*ver comentários no arquivo .h */
no_arvore * criar_no_expressao(int op, void *dir, void *esq) {
	no_arvore *novo = (no_arvore *)  malloc(sizeof(no_arvore));
	novo->tipo = EXPR;
	novo->dado.expr =  criar_expressao(op, dir, esq);
	return novo;
}

t_expr * criar_expressao(int op, void *dir, void *esq) {
	t_expr * novo = (t_expr *) malloc(sizeof(t_expr));
	novo->op = op;
	novo->dir = dir;
	novo->esq = esq;
	return novo;
}

no_arvore * criar_no_atribuicao(simbolo *resultado, void *expressao) {
	no_arvore *novo = (no_arvore *)  malloc(sizeof(no_arvore));
	novo->tipo = ATTR;
	novo->dado.attr =  criar_atribuicao(resultado, expressao);
	return novo;
}

t_attr * criar_atribuicao(simbolo *resultado, void *expressao){ 
	t_attr * novo = (t_attr *) malloc(sizeof(t_attr));
	novo->resultado = resultado;
	novo->expressao = expressao;
	return novo;
}

no_arvore * criar_no_declaracao(simbolo * identificador, int tipo){
	no_arvore * novo = (no_arvore *) malloc(sizeof(no_arvore));
	novo->tipo = DECL;
	novo->dado.decl = criar_declaracao(identificador, tipo);
	return novo;
}

t_decls * criar_declaracao(simbolo * identificador, int tipo){
	t_decls * novo = (t_decls * ) malloc(sizeof(t_decls));
	novo->simbolo = identificador;
	novo->tipo = tipo;
	return novo;
}

no_arvore * criar_no_statements( void *expressao) {
	no_arvore *novo = (no_arvore *)  malloc(sizeof(no_arvore));
	novo->tipo = STMTS;
	novo->dado.stmts =  criar_statements(expressao);
	return novo;
}

t_stmts * criar_statements( void *expressao){ 
	t_stmts * novo = (t_stmts *) malloc(sizeof(t_stmts));
	novo->expressao = expressao;	
	return novo;
}

// no_arvore * criar_no_statements( void *expressao) {
// 	no_arvore *novo = (no_arvore *)  malloc(sizeof(no_arvore));
// 	novo->tipo = STMTS;
// 	novo->dado.stmts =  criar_statements(expressao);
// 	return novo;
// }

// t_bloco * criar_bloco( void *expressao){ 
// 	t_bloco * novo = (t_bloco *) malloc(sizeof(t_bloco));
// 	novo->expressao = expressao;	
// 	return novo;
// }
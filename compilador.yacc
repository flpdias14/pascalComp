%{
#include <stdio.h>
#include "tabelasimbolo.h"
#include "constantes.h"
#include "arvore.h"
int yylex(void);
void yyerror(char *);
extern tabela_simbolo* tabela_simbolos;
extern tabela_simbolo* tabela_numeros;
%}

/* Declaracao dos tokens*/
%token 	INTEGER
%token 	REAL
%token 	NUMBER
%token	ID
%token 	 TYPE 
%token PROGRAM VAR READLN WRITELN IF ELSE ATTR GEQ LEQ NEQ EXPR DIV DECL STMTS
/* Declaracao dos operadores. A precedência é definida de baixo para cima. */
%left '+' '-'
%left '*' '/' '%'
/* precedencia do menos unário em uma expr */
%nonassoc UMINUS


%%


program:
	program bloco '\n'	{ }
	|
	;
bloco:

	decls stmts { }
	
	;

decls:
	decls decl	{}
	|
	;
decl:	
	VAR ID ':' TYPE ';'		{ 
				// localiza o simbolo na tabela de simbolos pelo codigo
				simbolo* simbolo = localizar_simbolo_codigo(tabela_simbolos, $2);
				//Setar o tipo da variável simbolo.tipo = $1				
				no_arvore *n = criar_no_declaracao(simbolo, $4);				
				//printf("ID = %s\n TIPO = %d\n",  simbolo->lexema, $1);
				$$ = (int) n;
								}
	;
stmts:
	stmts stmt	{ 
		no_arvore * n = criar_no_statements((void *) $2);
		$$ = (int) n;
	}
	|
	;

stmt:
	expr ';' {}
	| attr 	{}
	| WRITELN '(' ID ')' ';' { 
				// localiza o simbolo na tabela de simbolos pelo codigo
				simbolo* simbolo = localizar_simbolo_codigo(tabela_simbolos, $3);
	
  				(simbolo->tipo == COD_INT ? 
					printf("%s = %d\n",simbolo->lexema, simbolo->val.dval): 
					printf("%s = %f\n",simbolo->lexema, simbolo->val.fval));
							}
	;

attr:
	ID ATTR expr ';'	{

				// localiza o simbolo na tabela de simbolos pelo codigo
				simbolo* simbolo = localizar_simbolo_codigo(tabela_simbolos, $1);
				if (simbolo->tipo == COD_INT) simbolo->val.dval = (int) $3;
				else if (simbolo->tipo == COD_FLOAT) simbolo->val.fval = $3;
				no_arvore * n = criar_no_atribuicao(simbolo, (void*) $3);
				//no_arvore *n = criar_no_atribuicao(simbolo, (void *) $3);
				$$ = (int) n;
                //Setar o valor da variável var->dado.valor.ival ou dval = $3

				}
	;

expr:
	NUMBER {
											simbolo* numero = localizar_simbolo_codigo(tabela_numeros, $1);
											no_arvore *n = criar_no_expressao(NUMBER, (void *) numero, NULL);
				  							$$ = (int) n; 
			}
	| ID {// procurar o símbolo na tabela a partir do $1
											simbolo* simbolo = localizar_simbolo_codigo(tabela_simbolos, $1);
											no_arvore *n = criar_no_expressao(ID, (void *) simbolo, NULL);
											$$ = (int) n;
		}
	| expr '+' expr	{
											no_arvore * n = criar_no_expressao('+', (void *) $1, (void *) $3);
											$$ = (int) n;
	}
	| expr '-' expr	{
											no_arvore *n = criar_no_expressao('-', (void *) $1, (void *) $3);
											$$ = (int) n;
	}
	| expr '*' expr	{				
											no_arvore *n = criar_no_expressao('*', (void *) $1, (void *) $3);
											$$ = (int) n;
											}
	| expr '/' expr	{
											no_arvore * n = criar_no_expressao('/', (void *) $1, (void *) $3);
											$$ = (int) n;
	}
	| expr '%' expr	{
									 		no_arvore * n = criar_no_expressao('%', (void *) $1, (void *) $3);
											$$ = (int) n;
					}
	| '(' expr ')'	{$$ = $2;}
	| '-' expr %prec UMINUS	{$$ = -$2;}
	; 

%%

void yyerror(char *s) {
	fprintf(stderr, "Erro: %s\n", s);
}

int main(void)	{
	
	tabela_simbolos = inicializar_tabela();
	tabela_numeros = inicializar_tabela();
	yyparse();
	//
	return 0;
}

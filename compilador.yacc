%{
#include <stdio.h>
#include <string.h>
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
%token 	TYPE 
%token PROGRAM VAR READLN WRITELN IF THEN ELSE ATTR GEQ LEQ NEQ EXPR MOD DIV DECL STMTS START END WHILE DIFF
/* Declaracao dos operadores. A precedência é definida de baixo para cima. */
%left '+' '-'
%left '*' '/' '%'
/* precedencia do menos unário em uma expr */
%nonassoc UMINUS


%%


program:
	program decls '\n' bloco '\n'	{ }
	|
	;
bloco:
	stmts { }
	;

decls:
	decls decl	{}
	|
	;
decl:	
	VAR ID ':' TYPE ';'		{ 
				// localiza o simbolo na tabela de simbolos pelo nome
				int cod = instalar_simbolo(tabela_simbolos, (char* ) $2, $4);
				//Setar o tipo da variável simbolo.tipo = $1				
				simbolo *simbolo = localizar_simbolo_codigo(tabela_simbolos, cod );
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
				// localiza o simbolo na tabela de simbolos pelo nome
				simbolo* simbolo = localizar_simbolo_nome(tabela_simbolos, (char *) $3);
	
				if(simbolo == NULL){
					yyerror("ERRO : Identificador não declarado");

				}
				else{
					no_arvore *n = criar_no_write(simbolo, simbolo->tipo );
					$$ = (int) n;
				}
  				// if(simbolo->tipo == COD_INT ){
				// 	printf("%s INT= %d\n",simbolo->lexema, simbolo->val.dval);  
				// } 
				// else if(simbolo->tipo == COD_FLOAT){
				// 	printf("%s REAL= %f\n",simbolo->lexema, simbolo->val.fval);
				// }
					
							}
	
	;

attr:
	ID ATTR expr ';'	{

				// localiza o simbolo na tabela de simbolos pelo codigo
				simbolo* simbolo = localizar_simbolo_nome(tabela_simbolos, (char *) $1);
				if(simbolo == NULL){
					yyerror("ERRO : Identificador não declarado");
				}
				else{
					if (simbolo->tipo == COD_INT) simbolo->val.dval = (int) $3;
					else if (simbolo->tipo == COD_FLOAT) simbolo->val.fval = (float) $3;
					no_arvore * n = criar_no_atribuicao(simbolo, (void*) $3);
					//no_arvore *n = criar_no_atribuicao(simbolo, (void *) $3);
					$$ = (int) n;
				}
				
				
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
											simbolo* simbolo = localizar_simbolo_nome(tabela_simbolos,(char *) $1);
											if(simbolo == NULL){
												yyerror("ERRO : Identificador não declarado");
											}
											else{
												no_arvore *n = criar_no_expressao(ID, (void *) simbolo, NULL);
												$$ = (int) n;
											}
											
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
	| expr MOD expr	{
									 		no_arvore * n = criar_no_expressao(MOD, (void *) $1, (void *) $3);
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

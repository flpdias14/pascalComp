%{
#include <stdio.h>
#include "tabelasimbolo.h"
#include "constantes.h"
int yylex(void);
void yyerror(char *);
extern tabela_simbolo* tabela_simbolos;
extern tabela_simbolo* tabela_numeros;
%}
/* union para armazenar os valores dos tokens*/
%union {
	int ival;
	double dval;	
}
/* Declaracao dos tokens*/
%token 	<ival> INTEGER
%token 	<dval> REAL
%token 	<ival> NUMBER
%token	<ival> ID
%token 	<ival> TYPE 
%token PROGRAM VAR READLN WRITELN IF ELSE ATTR
/* Declaracao dos operadores. A precedência é definida de baixo para cima. */
%left '+' '-'
%left '*' '/' '%'
/* precedencia do menos unário em uma expr */
%nonassoc UMINUS

%type <dval> expr
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
				simbolo->tipo = $4;				
				//printf("ID = %s\n TIPO = %d\n",  simbolo->lexema, $1);
								}
	;
stmts:
	stmts stmt	{}
	|
	;
/* Regra para reconhececimento de um statement */
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
                //Setar o valor da variável var->dado.valor.ival ou dval = $3

				}
	;
expr:
	NUMBER {
			simbolo* simbolo = localizar_simbolo_codigo(tabela_numeros, $1);
			$$ = simbolo->val.fval;
			// printf("NUMBER %f\n",  simbolo->val.fval);
			}
	| ID {// procurar o símbolo na tabela a partir do $1
		simbolo* simbolo = localizar_simbolo_codigo(tabela_simbolos, $1);
		$$ = (simbolo->tipo == COD_INT ? simbolo->val.dval : simbolo->val.fval);
		}
	| expr '+' expr	{$$ = $1 + $3;}
	| expr '-' expr	{$$ = $1 - $3;}
	| expr '*' expr	{$$ = $1 * $3;}
	| expr '/' expr	{$$ = $1 / $3;}
	| expr '%' expr	{//$$ = $1 % $3;} 
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

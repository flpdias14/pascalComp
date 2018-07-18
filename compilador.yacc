%{
#include <stdio.h>
#include "tabelasimbolo.h"
#include "constantes.h"
int yylex(void);
void yyerror(char *);
extern tabela_simbolo* tabela;
%}
/* union para armazenar os valores dos tokens*/
%union {
	int ival;
	double dval;	

}
/* Declaracao dos tokens*/
%token 	<ival> INTEGER
%token 	<dval> REAL
%token	<ival> ID
%token 	<ival> TYPE 
%token PROGRAM VAR READLN WRITELN IF ELSE
/* Declaracao dos operadores. A precedência é definida de baixo para cima. */
%left '+' '-'
%left '*' '/' '%'
/* precedencia do menos unário em uma expr */
%nonassoc UMINUS

%type <dval> expr
%%


program:
	program stmt '\n'	{ }
	|
	;
/* Regra para reconhececimento de um statement */
stmt:
	VAR ID ':' TYPE ';'		{ 
				// localiza o simbolo na tabela de simbolos pelo codigo
				simbolo* simbolo = localizar_simbolo_codigo(tabela, $2);
				//Setar o tipo da variável simbolo.tipo = $1				
				simbolo->tipo = $1;				
				//printf("ID = %s\n TIPO = %d\n",  simbolo->lexema, $1);
								}
	| ID ":=" expr ';' 	{
				// localiza o simbolo na tabela de simbolos pelo codigo
				simbolo* simbolo = localizar_simbolo_codigo(tabela, $1);
				if (simbolo->tipo == COD_INT) simbolo->val.dval = (int) $3;
				else if (simbolo->tipo == COD_FLOAT) simbolo->val.fval = $3;
				
                  //Setar o valor da variável var->dado.valor.ival ou dval = $3
										}
	| WRITELN '(' ID ')' ';' { 
				// localiza o simbolo na tabela de simbolos pelo codigo
				simbolo* simbolo = localizar_simbolo_codigo(tabela, $3);
	
  				(simbolo->tipo == COD_INT ? 
					printf("%s = %d\n",simbolo->lexema, simbolo->val.dval): 
					printf("%s = %f\n",simbolo->lexema, simbolo->val.fval));
													}
;
expr:
	INTEGER {$$ = $1;}
	| ID {// procurar o símbolo na tabela a partir do $1
		simbolo* simbolo = localizar_simbolo_codigo(tabela, $1);
		$$ = (simbolo->tipo == COD_INT ? simbolo->val.dval : simbolo->val.fval);
		}
	| REAL {$$ = $1;}
	| expr '+' expr	{$$ = $1 + $3;}
	| expr '-' expr	{$$ = $1 - $3;}
	| expr '*' expr	{$$ = $1 * $3;}
	| expr '/' expr	{$$ = $1 / $3;}
	| expr '%' expr	{$$ = $1 % $3;}
	| '(' expr ')'	{$$ = $2;}
	| '-' expr %prec UMINUS	{$$ = -$2;}
	; 

%%

void yyerror(char *s) {
	fprintf(stderr, "Erro: %s\n", s);
}

int main(void)	{
	
	tabela = inicializar_tabela();
	yyparse();
	//
	return 0;
}

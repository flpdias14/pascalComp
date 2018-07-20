%{

void yyerror(char *s);
#include <stdio.h>
#include "y.tab.h"
#include "tabelasimbolo.h"
#include "constantes.h"
extern tabela_simbolo* tabela;
char* msg_erro = "caractere invalido: ";
%}
letra	[A-Za-z]
digito	[0-9]
id	({letra}|_)({letra}|{digito})*
operadores	[-+*\/=%(\)\n;:><]
%%
var 	{
			return VAR;
		}
program	{
			return PROGRAM;
		}
begin	{
			// return BEGIN;
		}
end		{
			// return END;
		}
integer { 	// passa o codigo do tipo inteiro para o yacc
			yylval.ival = COD_INT; 
			return TYPE;
		}

real 	{ 
			// passa o codigo do tipo float para o yacc
			yylval.ival = COD_FLOAT; 
			return TYPE;
		}

writeln	{	
			return WRITELN;
		}

readln 	{
			return READLN;
		}

if		{
			return IF;
		}

else	{
			return ELSE;
		}
{digito}+"."{digito}+	{yylval.dval = atof(yytext); return REAL;}

{digito}+	{yylval.ival = atoi(yytext);return INTEGER;}

{id}	{ yylval.ival = instalar_simbolo(tabela, yytext);
	return ID;}
{operadores}	{return *yytext;}

[ \t]	;
.	{yyerror(msg_erro);}

%%

int yywrap(void){
	
return 1;
}

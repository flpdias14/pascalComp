%{

void yyerror(char *s);
#include <stdio.h>
#include "y.tab.h"
#include "tabelasimbolo.h"
#include "constantes.h"
extern tabela_simbolo* tabela_simbolos;
extern tabela_simbolo* tabela_numeros;
char* msg_erro = "caractere invalido: ";
%}
letra	[A-Za-z]
digito	[0-9]
id	({letra}|_)({letra}|{digito})*
operadores	[-+*\/=%(\)\n;:><]
numero	({digito}+"."{digito}+|{digito}+)
%%
var 	{
			return VAR;
		}
program	{
			return PROGRAM;
		}
begin	{	return START;}
end		{	return END;}
integer { 	// passa o codigo do tipo inteiro para o yacc
			yylval = COD_INT; 
			return TYPE;
		}

real 	{ 
			// passa o codigo do tipo float para o yacc
			yylval = COD_FLOAT; 
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
:=		{
			return ATTR;
		}

{digito}+"."{digito}+	{ yylval = instalar_numero(tabela_numeros, yytext, COD_FLOAT);
							return NUMBER;
						}

{digito}+	{
					yylval = instalar_numero(tabela_numeros, yytext, COD_INT);
							return NUMBER;
}

{id}	{ yylval = instalar_simbolo(tabela_simbolos, yytext);
	return ID;}
{operadores}	{return *yytext;}

[ \t]	;
.	{yyerror(msg_erro);}

%%

int yywrap(void){
	
return 1;
}

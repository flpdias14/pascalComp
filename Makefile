all: compilador.x

compilador.x: compilador.yacc compilador.lex tabelasimbolo.c 
	yacc -d compilador.yacc
	lex -l compilador.lex
	gcc *.c	

clean:
	rm -f *.o *.*~ *~
	mv a.out compilador.x

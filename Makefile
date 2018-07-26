all: compilador.x

compilador.x: compilador.yacc compilador.lex tabelasimbolo.c 
	yacc -d compilador.yacc
	lex -l compilador.lex
	gcc *.c	-Wno-int-to-pointer-cast -Wno-pointer-to-int-cast

clean:
	rm -f *.o *.*~ *~
	mv a.out compilador.x

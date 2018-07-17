#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include "tabelasimbolo.h"

tabela_simbolo * inicializar_tabela (){
	tabela_simbolo * nova_tabela = (tabela_simbolo*) malloc(sizeof(tabela_simbolo));
}

int inserir_simbolo(tabela_simbolo *tabela, simbolo * s) {
	no_tabela_simbolo* novo_no = (no_tabela_simbolo*) malloc(sizeof(no_tabela_simbolo));
	novo_no->dado = s;
	novo_no->proximo = NULL;
	if(tabela->primeiro == NULL){
		novo_no->dado->codigo = 1;
	}
	else {
		novo_no->dado->codigo = tabela->primeiro->dado->codigo + 1;
		novo_no->proximo = tabela->primeiro;
	}
	tabela->primeiro = novo_no;
	
	return tabela->primeiro->dado->codigo;
}

void exibir_tabela(tabela_simbolo *tabela) {
	// printf("========TABELA DE SIMBOLOS========");
	/*if(tabela->primeiro != NULL){
		tabela_simbolo* aux = tabela;		
		while(aux->primeiro != NULL){
			printf("%d\t%s\n", aux->primeiro->dado->codigo, aux->primeiro->dado->lexema);		
			aux->primeiro = aux->primeiro->proximo;
		}
	}*/
	exibir_no(tabela->primeiro);
}

void exibir_no(no_tabela_simbolo* no){
	if(no->proximo != NULL){
		exibir_no(no->proximo);
	}
	printf("%d\t%s\n", no->dado->codigo, no->dado->lexema);
}

simbolo * criar_simbolo(char *lexema) {
	simbolo* novo_dado = (simbolo*) malloc(sizeof(simbolo));
	novo_dado->codigo = 0;
	novo_dado->lexema = strdup(lexema);
	//printf("---%s---\n", lexema);
	novo_dado->tipo = 0;
	novo_dado->val.dval = 0;
	novo_dado->val.fval = 0;
	return novo_dado;

}

simbolo * localizar_simbolo_nome(tabela_simbolo *tabela, char *lexema){
	if(tabela->primeiro != NULL){
		return localizar_no_simbolo_nome(tabela->primeiro, lexema);	
	}
	return NULL;
}

simbolo * localizar_no_simbolo_nome(no_tabela_simbolo* no, char *lexema) {
	
	if(strcmp(no->dado->lexema, lexema) == 0){
		return no->dado;
	}
	else{
		if(no->proximo != NULL){
			return localizar_no_simbolo_nome(no->proximo, lexema);
		}
		return NULL;
	}

}

simbolo * localizar_simbolo_codigo(tabela_simbolo *tabela, int codigo){
	if(tabela->primeiro != NULL){
		return localizar_no_simbolo_codigo(tabela->primeiro, codigo);
	}
	return NULL;
}

simbolo * localizar_no_simbolo_codigo(no_tabela_simbolo *no, int codigo){
	
	if(no->dado->codigo == codigo){
		return no->dado;
	}
	else{
		if(no->proximo != NULL){
			return localizar_no_simbolo_codigo(no->proximo, codigo);
		}
		return NULL;
	}
}

int instalar_simbolo(tabela_simbolo *tabela, char *lexema) {
	simbolo* dado = localizar_simbolo_nome(tabela, lexema);
	if(dado == NULL){
		dado = criar_simbolo(lexema);
		return inserir_simbolo(tabela, dado);
	}
	return dado->codigo;
}

/*
int main(int args, char *argv[]) {
	tabela_simbolo* tabela = inicializar_tabela();
	printf("Tabela inicializada\n");

	printf("Valor tabela %s\n", tabela->primeiro);

	inserir_simbolo(tabela, criar_simbolo("a"));
	inserir_simbolo(tabela, criar_simbolo("b"));
	inserir_simbolo(tabela, criar_simbolo("d"));
	inserir_simbolo(tabela, criar_simbolo("e"));
	inserir_simbolo(tabela, criar_simbolo("f"));
	inserir_simbolo(tabela, criar_simbolo("gasdasdas"));
	inserir_simbolo(tabela, criar_simbolo("h"));

	exibir_tabela(tabela);

	simbolo* dado = localizar_simbolo_nome(tabela, "a");

	if(dado != NULL){
		printf("Código: %d\n", dado->codigo);
	}

	simbolo* dado2 = localizar_simbolo_codigo(tabela, 6);
	
	if(dado2 != NULL){
		printf("Lexema: %s\n", dado2->lexema);
	}

	printf("Instalado: %d\n", instalar_simbolo(tabela, "i"));

	exibir_tabela(tabela);
}
*/

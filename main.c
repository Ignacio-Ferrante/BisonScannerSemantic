//////////////////////////////////////////////////////////////////////////////////////
/*
      TP5 - 2020
      "Un escaner elemental"

      INTEGRANTES: 
      Alejandro Buergo / 168.569-7
      Ignacio Ferrante / 171.524-0
      Patricio Galli   / 172.467-8
                                                                                    */
//////////////////////////////////////////////////////////////////////////////////////

#include <stdio.h>
#include "parser.h"
#include "scanner.h"
#include "semantic.h"

extern int yynerrs;
extern int errsem;

int main() {
	int parser = yyparse();
	switch(parser){
		case 0:
			puts("Compilacion terminada con exito");
		break;
		case 1:
			puts("Errores de compilación");
		break;
		case 2:
			puts("Memoria insuficiente");
		break;
		}

	printf("Errores sintácticos: %d - Errores léxicos: %d - Errores semanticos: %d\n", yynerrs, errlex, errsem);
	return parser;
}

%{
#include <stdio.h>
#include "scanner.h"
#include "symbol.h"
#include "semantic.h"

void yyerror(const char *);
void mostrarError(char *id, int e);
extern int errlex; 	//Contador de Errores Léxicos
int errsem = 0;         //Contador de Errores Semanticos
int tipoMensaje; //Especifica el tipo de mensaje para el error semantico
%}


%defines "parser.h"
%output "parser.c"

%define api.value.type {char *}
%define parse.error verbose //Mas detalles cuando el Parser encuentre un error en vez de "Syntax Error"

%start programa //El no terminal que es AXIOMA de la gramatica del TP2

%token PROGRAMA FIN_PROG DECLARAR LEER ESCRIBIR CONSTANTE IDENTIFICADOR
%token ASIGNACION "<-"

%left  '+'  '-'
%left  '*'  '/'
%precedence NEG

%%

programa : PROGRAMA {inicio();} listaSentencias FIN_PROG             {fin(); if (errlex || yynerrs || errsem) YYABORT; else YYACCEPT;}

listaSentencias	:	  %empty
                        | listaSentencias sentencia
                        ;

sentencia       :     	  LEER '(' listaIdentificadores ')' ';'
                        | ESCRIBIR '(' listaExpresiones ')' ';'
                        | DECLARAR IDENTIFICADOR ';'                      {if(!existe($2)) {declarar($2); agregar($2);} else {mostrarError($2,0); YYERROR;}}
                        | IDENTIFICADOR "<-" expresion ';'                {asignar($3,$1);}
                        | error ';'
                        ;   

listaIdentificadores :    identificador                                   {leer($1);}
                        | listaIdentificadores ',' identificador          {leer($3);}
                        ;

listaExpresiones :   	  expresion                                       {escribir($1);}
                        | listaExpresiones ',' expresion                  {escribir($3);}
                        ;
                            
expresion :               CONSTANTE
                        | identificador
                        | '(' expresion ')'                               {$$ = $2;}
                        | '-' expresion   %prec NEG                       {$$ = negar($2);}
                        | expresion '+' expresion                         {$$ = sumar($1, $3);}
                        | expresion '-' expresion                         {$$ = restar($1, $3);}
                        | expresion '*' expresion                         {$$ = multiplicar($1, $3);}
                        | expresion '/' expresion                         {$$ = dividir($1, $3);}
                        ;

identificador :         IDENTIFICADOR {if(!existe($1)) {mostrarError($1,1); YYERROR;} else $$ = $1;};

%%

void yyerror(const char *error){
        printf("Linea #%d: %s\n", yylineno, error);
        return;
}

void mostrarError(char *id, int tipoError){
	char errorMsg[200];
	if(tipoError == 0) sprintf(errorMsg, "Error semantico: El identificador %s ya fue declarado", id);
	else sprintf(errorMsg, "Error semantico: El identificador %s nunca fue declarado", id);
	yyerror(errorMsg);
	errsem++;
}

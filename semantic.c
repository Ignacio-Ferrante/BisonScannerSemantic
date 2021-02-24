#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "symbol.h"

int temporal;
const int id_max = 20;

void declarar(char *id){
	printf("Reserve %s, 4\n", id); //reservo 4 bytes para la variable con nombre dado por el id
}

char* generarTemporal(){
	char nuevoTemporal[id_max];
	temporal++;
	sprintf(nuevoTemporal, "Temp#%d", temporal);
	declarar(nuevoTemporal);
	return strdup(nuevoTemporal);
}

void leer(char *id){
	printf("Read %s, Integer\n", id);
}

void escribir(char *id){
	printf("Write %s, Integer\n", id);
}

char* negar(char *idEntrada){
  	char *idSalida;
	idSalida = generarTemporal();
	printf("NEG %s,,%s\n", idEntrada, idSalida);
	return idSalida;
}

char* multiplicar(char *opizq, char *opder){
	char *idSalida;
	idSalida = generarTemporal();
	printf("MULT %s,%s,%s\n", opizq, opder, idSalida);
	return idSalida;
}

char* sumar(char *opizq, char *opder){
	char *idSalida;
	idSalida = generarTemporal();
	printf("ADD %s,%s,%s\n", opizq, opder, idSalida);
	return idSalida;
}

char* restar(char *opizq, char *opder){
	char *idSalida;
	idSalida = generarTemporal();
	printf("SUBS %s,%s,%s\n", opizq, opder, idSalida);
	return idSalida;
}

char* dividir(char *opizq, char *opder){
	char *idSalida;
	idSalida = generarTemporal();
	printf("DIV %s,%s,%s\n", opizq, opder, idSalida);
	return idSalida;
}

void asignar(char *idEntrada, char *idSalida){
	printf("Store %s, %s \n", idEntrada, idSalida);
}

void inicio(){
	printf("Load rtlib,\n");
}

void fin(){
	printf("Exit ,\n");
}
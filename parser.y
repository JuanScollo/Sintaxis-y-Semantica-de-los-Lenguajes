%{
#include <stdio.h>
#include <stdlib.h>
extern FILE *yyin;
int yylex();
void yyerror(const char *s);
%}

%token SI SINO VARIABLE ASIGNAR
%token IDENTIFICADOR ENTERO CARACTER
%token APERTURA_BLOQUE CIERRE_BLOQUE FIN_SENTENCIA ASIGNADOR
%token SUMA RESTA MULTIPLICACION DIVISION
%token MENOR_QUE MAYOR_QUE MENOR_IGUAL MAYOR_IGUAL IGUAL DISTINTO

%%

programa: declaraciones bloque_principal;

declaraciones: VARIABLE IDENTIFICADOR FIN_SENTENCIA
              | VARIABLE IDENTIFICADOR FIN_SENTENCIA declaraciones;

bloque_principal: asignacion_condicionales
                | asignacion_varias;

asignacion_condicionales: asignacion SI condicion APERTURA_BLOQUE asignacion_varias CIERRE_BLOQUE
                         | asignacion SI condicion APERTURA_BLOQUE asignacion_varias CIERRE_BLOQUE SINO APERTURA_BLOQUE asignacion_varias CIERRE_BLOQUE;

asignacion_varias: asignacion
                 | asignacion asignacion_varias;

asignacion: ASIGNAR IDENTIFICADOR ASIGNADOR ENTERO FIN_SENTENCIA
          | ASIGNAR IDENTIFICADOR ASIGNADOR IDENTIFICADOR SUMA IDENTIFICADOR FIN_SENTENCIA
          | ASIGNAR IDENTIFICADOR ASIGNADOR IDENTIFICADOR MULTIPLICACION IDENTIFICADOR FIN_SENTENCIA;

condicion: '(' IDENTIFICADOR MENOR_QUE IDENTIFICADOR ')'
         | '(' IDENTIFICADOR MAYOR_QUE IDENTIFICADOR ')'
         | '(' IDENTIFICADOR MENOR_IGUAL IDENTIFICADOR ')'
         | '(' IDENTIFICADOR MAYOR_IGUAL IDENTIFICADOR ')'
         | '(' IDENTIFICADOR IGUAL IDENTIFICADOR ')'
         | '(' IDENTIFICADOR DISTINTO IDENTIFICADOR ')';

%%

int main(int argc, char **argv) {
    if (argc < 2) {
        fprintf(stderr, "Uso: %s <archivo>\n", argv[0]);
        return 1;
    }
    
    yyin = fopen(argv[1], "r");
    if (!yyin) {
        perror("Error al abrir el archivo");
        return 1;
    }
    
    if (yyparse() == 0) {
        printf("El archivo se ha procesado correctamente.\n");
    } else {
        printf("Hubo un error de sintaxis en el archivo.\n");
    }
    
    fclose(yyin);
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

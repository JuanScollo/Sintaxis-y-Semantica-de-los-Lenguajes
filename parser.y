%{
#include <stdio.h>
#include <stdlib.h>

// Prototipos
int yylex();
void yyerror(const char *s);

%}

%token VARIABLE ASIGNAR SI SINO ID ENTERO CARACTER MAS MENOS MULT DIV MOD MENOR MAYOR MENORIG MAYORIG IGUAL DESIGUAL APERTURA CIERRE PARTIZQ PARTDER ASIGN FIN

%%
// Reglas de producción

programa:
    sentencias
    ;

sentencias:
    sentencias sentencia
    | sentencia
    ;

sentencia:
    sentenciaDeclaracion
    | sentenciaAsignacion
    | condicionalAsignacion
    | condicionalMuestra
    ;

sentenciaDeclaracion:
    VARIABLE ID FIN { printf("Declaración de variable: %s\n", $2); }
    ;

sentenciaAsignacion:
    ASIGNAR ID ASIGN expresion FIN { printf("Asignación a %s\n", $2); }
    ;

condicionalAsignacion:
    SI PARTIZQ condicion PARTDER APERTURA sentencias CIERRE
    | SI PARTIZQ condicion PARTDER APERTURA sentencias CIERRE SINO APERTURA sentencias CIERRE
    ;

condicionalMuestra:
    SI PARTIZQ condicion PARTDER APERTURA muestra CIERRE
    | SI PARTIZQ condicion PARTDER APERTURA muestra CIERRE SINO APERTURA muestra CIERRE
    ;

muestra:
    "mostrar" PARTIZQ sentencia PARTDER FIN { printf("Mostrando resultado\n"); }
    ;

expresion:
    termino
    | expresion MAS termino
    | expresion MENOS termino
    ;

termino:
    factor
    | termino MULT factor
    | termino DIV factor
    | termino MOD factor
    ;

factor:
    ID
    | ENTERO
    | PARTIZQ expresion PARTDER
    ;

condicion:
    expresion comparador expresion
    ;

comparador:
    MENOR
    | MAYOR
    | MENORIG
    | MAYORIG
    | IGUAL
    | DESIGUAL
    ;

%% 

// Función de manejo de errores
void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

// Función principal
int main(int argc, char **argv) {
    if (argc != 2) {
        fprintf(stderr, "Uso: %s <archivo>\n", argv[0]);
        return 1;
    }

    FILE *archivo = fopen(argv[1], "r");
    if (!archivo) {
        perror("Error al abrir el archivo");
        return 1;
    }

    yyin = archivo;
    yyparse();
    fclose(archivo);
    return 0;
}

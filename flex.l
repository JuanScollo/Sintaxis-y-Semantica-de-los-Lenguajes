%{
#include <stdio.h>
#include "parser.tab.h"  /* Incluye los tokens generados por Bison */
%}

%%

[ \t\n]+                                      { /* No hacer nada para espacios en blanco y nuevas líneas */ }

"si"                                          { printf("SI: %s\n", yytext); return SI; }
"sino"                                        { printf("SINO: %s\n", yytext); return SINO; }
"variable"                                    { printf("VARIABLE: %s\n", yytext); return VARIABLE; }
"asignar"                                     { printf("ASIGNAR: %s\n", yytext); return ASIGNAR; }

[a-z][a-z0-9]{0,15}                           { printf("IDENTIFICADOR: %s\n", yytext); return IDENTIFICADOR; }
[0-9]+                                        { printf("ENTERO: %s\n", yytext); return ENTERO; }
"'"[a-z0-9]"'"                                { printf("CARACTER: %s\n", yytext); return CARACTER; }

"->"                                          { printf("ASIGNADOR: %s\n", yytext); return ASIGNADOR; }
"!!"                                          { printf("FIN_SENTENCIA: %s\n", yytext); return FIN_SENTENCIA; }
"["                                           { printf("APERTURA_BLOQUE: %s\n", yytext); return APERTURA_BLOQUE; }
"]"                                           { printf("CIERRE_BLOQUE: %s\n", yytext); return CIERRE_BLOQUE; }

"+"                                           { printf("SUMA: %s\n", yytext); return SUMA; }
"-"                                           { printf("RESTA: %s\n", yytext); return RESTA; }
"*"                                           { printf("MULTIPLICACION: %s\n", yytext); return MULTIPLICACION; }
"//"                                          { printf("DIVISION: %s\n", yytext); return DIVISION; }

"<"                                           { printf("MENOR_QUE: %s\n", yytext); return MENOR_QUE; }
">"                                           { printf("MAYOR_QUE: %s\n", yytext); return MAYOR_QUE; }
"<="                                          { printf("MENOR_IGUAL: %s\n", yytext); return MENOR_IGUAL; }
">="                                          { printf("MAYOR_IGUAL: %s\n", yytext); return MAYOR_IGUAL; }
"="                                           { printf("IGUAL: %s\n", yytext); return IGUAL; }
"!="                                          { printf("DISTINTO: %s\n", yytext); return DISTINTO; }

.                                             { printf("Caracter no reconocido: %s\n", yytext); }

%%

int yywrap() {
    return 1;
}

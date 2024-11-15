%{
#include <stdio.h>
#include "parser.tab.h"  /* Incluye los tokens generados por Bison */
%}

%%

[ \t\n]+                              { /* Ignorar espacios y nuevas líneas */ }

"si"                                  { return SI; }
"sino"                                { return SINO; }
"variable"                            { return VARIABLE; }
"asignar"                             { return ASIGNAR; }

[a-z][a-z0-9]{0,15}                   { return IDENTIFICADOR; }
[0-9]+                                { return ENTERO; }
"'"[a-z0-9]"'"                        { return CARACTER; }

"/"                                   { return APERTURA_BLOQUE; }
"\"                                  { return CIERRE_BLOQUE; }
"!!"                                  { return FIN_SENTENCIA; }
"->"                                  { return ASIGNADOR; }

"+"                                   { return SUMA; }
"-"                                   { return RESTA; }
"*"                                   { return MULTIPLICACION; }
"//"                                  { return DIVISION; }

"<"                                   { return MENOR_QUE; }
">"                                   { return MAYOR_QUE; }
"<="                                  { return MENOR_IGUAL; }
">="                                  { return MAYOR_IGUAL; }
"="                                   { return IGUAL; }
"!="                                  { return DISTINTO; }

.                                     { printf("Caracter no reconocido: %s\n", yytext); }

%%

int yywrap() {
    return 1;
}

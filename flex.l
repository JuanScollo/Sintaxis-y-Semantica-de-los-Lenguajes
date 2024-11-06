%{
#include "y.tab.h"
%}

id        	[a-z]([a-z]+[0-9]){0,15} 
entero    	[0-9]+
caracter	([a-z]+[0-9])+

%%
"si"		{return SI;}
"sino"	{return SINO;}
"variable"	{return VARIABLE;}
"asignar"	{return ASIGNAR;}
"o" 		{return O;}
"no"		{return NO;}
{id}    		{return ID;}
{entero}	{return ENTERO;}
{caracter}	{return CARACTER;}
"+"        	{return MAS;}
"-"        	{return MENOS;}
"*"        	{return MULT;}
"//"    	{return DIV;}
"%"        	{return MOD;}
"<"        	{return MENOR;}
"<=" 	    {return MENORIG;}
">"        	{return MAYOR;}
">="   	 	{return MAYORIG;}
"="        	{return IGUAL;}
"!="   	 	{return DESIGUAL;}
"/"		{return APERTURA;}
"\\"		{return CIERRE;}
"("		{return PARTIZQ;}
")"		{return PARTDER;}
"->"		{return ASIGN;}
"!!"		{return FIN;}
[ \t\n]    	; // Ignorar espacios en blanco
.          	{ printf("Símbolo desconocido: %s\n", yytext); }

%%

int yywrap(void) {
    return 1;
}

%{
#include <stdlib.h>
#include "Proiect.h"
#include "Proiect.tab.h"
void yyerror(char *);
%}

%%
[a-zA-Z] {
		yylval.sIndex = *yytext - 'A';
		return VARIABLE;
	}

0 	{
		yylval.iValue = atoi(yytext);
		return L_INTEGER;
	}

0[lL] 	{
			yylval.iValue = strtol(yytext, NULL, 10);
			return L_INTEGER;
		}

0[uU] 	{
			yylval.iValue = strtoul(yytext, NULL, 10);
			return U_INTEGER;
		}

0[uU][lL] 	{
				yylval.iValue = strtoul(yytext, NULL, 10);
				return U_L_INTEGER;
			}

0[sS] 	{
			yylval.iValue = strtol(yytext, NULL, 10);
			return SHORT;
		}

0[uU][sS] 	{
			yylval.iValue = strtoul(yytext, NULL, 10);
			return U_SHORT;
		}
	
[1-9][0-9]*	{
				yylval.iValue = atoi(yytext);
				return INTEGER;
			}

[1-9][0-9]*[lL]	{
					yylval.iValue = strtol(yytext, NULL, 10);
					return L_INTEGER;
				}

[1-9][0-9]*[uU]	{
					yylval.iValue = strtoul(yytext, NULL, 10);
					return U_INTEGER;
				}

[1-9][0-9]*[uU][lL]	{
						yylval.iValue = strtoul(yytext, NULL, 10);
						return U_L_INTEGER;
					}

[1-9][0-9]*[sS]	{
					yylval.iValue = strtol(yytext, NULL, 10);
					return SHORT;
				}

[1-9][0-9]*[sS][uU]	{
						yylval.iValue = strtoul(yytext, NULL, 10);
						return U_SHORT;
					}


0[xX][0-9A-Fa-f]+     {
						yylval.iValue = strtol(yytext, NULL, 16);
						return INTEGER;
        			}

0[0-7]*     {
				yylval.iValue = strtol(yytext, NULL, 8);
				return INTEGER;
        	}
		
[0]"."[0-9][0-9]*	{
					yylval.dValue = strtod(yytext, NULL);
					return DOUBLE;
				}
				
[1-9][0-9]*"."[0-9][0-9]* 	{
						yylval.dValue = strtod(yytext, NULL);
						return DOUBLE;
					}

					
[-()<>=+*/;{}.,] 	{
					return *yytext;
				}
				
">=" 		return GE;
"<=" 		return LE;
"==" 		return EQ;
"!=" 		return NE;
"++" 		return INC;
"--" 		return DEC;
"while" 	return WHILE;
"for" 		return FOR;
"if" 		return IF;
"else" 		return ELSE;
"write" 	return WRITE;
"*="		return ME;
"/="		return DE;
"+="		return PE;
"-="		return MiE;

[ \t\n]+ 	; /* ignora taburile si new line-urile */

\/\*([^*]|[\r\n]|(\*+([^*/]|[\r\n])))*\*+\/ ; /* ignora comentariile pe mai multe linii */

 "//"[^}\n]* ;	/* ignora comentariile pe o linie */
 
. yyerror("Unknown character");

%%

int yywrap(void) 
{
	return 1;
}
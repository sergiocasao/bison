%{
#include "practica.tab.h"
%}

NUMRE ([0-9]*\.[0-9]+)
NUMEN [0-9]*
CADEN \"[a-zA-z]*\"
POTENCIA [Pp][Oo][Ww]

%%

{NUMRE}         {
		printf("\tNúmero real %s\n",yytext);
                yylval.real = atof(yytext);
                return (REAL);
                }

{NUMEN}         {
		printf("\tNúmero entero %s\n",yytext);
                yylval.entero = atoi(yytext);
                return (ENTERO);
                }

{CADEN}		{
		printf("\tCadena %s\n",yytext);
		yylval.cadena = duplicate_segment(yytext + 1, yyleng - 2);
		return (CADENA);
		}

{POTENCIA}	{
		printf("\tFunción potencia\n");
		yylval.cadena = yytext;
		return (CADENA);
		}

"("		{
		printf("\tParéntesis abierto\n");
                return (yytext[0]);
		}

")"		{
		printf("\tParéntesis cerrado\n");
                return (yytext[0]);
		}

","		{
		printf("\tComa\n");
                return (yytext[0]);
		}

"+"	 	{
		printf("\tSigno más\n");
                return (yytext[0]);
                }

"-"	 	{
		printf("\tSigno menos\n");
                return (yytext[0]);
                }

"*"	 	{
		printf("\tSigno por\n");
                return (yytext[0]);
                }


"/"	 	{
		printf("\tSigno entre\n");
                return (yytext[0]);
                }

"\n"            {
		printf("\n");
		//printf("\tSalto de linea\n");
                return (yytext[0]);
                }
.               ;
%%

%{
#include<stdio.h>
#include<string.h>
#include<math.h>
%}

/* Declaraciones de BISON */
%union{
	int entero;
	double real;
	char* cadena;
}

%token <real> REAL
%type <real> expre
%token <entero> ENTERO
%type <entero> expen
%token <cadena> CADENA
%type <cadena> expca

%left '+' '-'
%left '*' '/'

/* Gramática */
%%

input:    /* cadena vacía */
        | input line
;

line:     '\n'
        | expre '\n'  { printf("\t\tResultado: %f\n", $1); }
        | expen '\n'  { printf("\t\tResultado: %d\n", $1); }
        | expca '\n'  { printf("\t\tResultado: %s\n", $1); }
;

expre:  	REAL { $$ = $1; }
	| '-' expre		 { $$ = - $2; }
	| expre '+' expre        { $$ = $1 + $3;    }
	| expen '+' expre        { $$ = $1 + $3;    }
	| expre '+' expen        { $$ = $1 + $3;    }
	| expre '-' expre        { $$ = $1 - $3;    }
	| expen '-' expre        { $$ = $1 - $3;    }
	| expre '-' expen        { $$ = $1 - $3;    }
	| expre '*' expre        { $$ = $1 * $3;    }
	| expre '*' expen        { $$ = $1 * $3;    }
	| expen '*' expre        { $$ = $1 * $3;    }
	| expre '/' expre        { if($3 == 0.0)
					yyerror("Division por cero");
				   else
					$$ = $1 / $3; }
	| expen '/' expre        { if($3 == 0.0)
					yyerror("Division por cero");
				   else
					$$ = $1 / $3; }
	| expre '/' expen        { if($3 == 0)
					yyerror("Division por cero");
				   else
					$$ = $1 / $3; }
	| expca '(' expre ',' expre ')' { $$ = pow($3,$5); }
	| expca '(' expre ',' expen ')' { $$ = pow($3,$5); }
	| expca '(' expen ',' expre ')' { $$ = pow($3,$5); }
;

expen:  	ENTERO { $$ = $1; }
	| '-' expen		 { $$ = - $2; }
	| expen '+' expen        { $$ = $1 + $3;    }
	| expen '-' expen        { $$ = $1 - $3;    }
	| expen '*' expen        { $$ = $1 * $3;    }
	| expen '/' expen        { if($3 == 0)
					yyerror("Division por cero");
				   else
					$$ = $1 / $3; }
	| expca '(' expen ',' expen ')' { $$ = pow($3,$5); }
;

expca:		CADENA {$$ = $1; }
	| expca '+' expca	 {
        char* s = malloc(sizeof(char)*(strlen($1)+strlen($3)+1));
        strcpy(s,$1);
     	strcat(s,$3);
                                   $$ = s;	    }
   | expca '-' expca       {
       if(strlen(s) > strlen(toRemove))
           yyerror("La segunda cadena es más grande que la primera");
       else
           char* s = malloc(sizeof(char)*(strlen($1)+1));
           char* toRemove = malloc(sizeof(char)*(strlen($3)+1));
           while( s = strstr(s, toRemove) )
               memmove(s, s+strlen(toRemove),1+strlen(s+strlen(toRemove)));
           $$ = s
   }
;


%%

int main() {
  yyparse();
}

yyerror (char *s)
{
  printf("--%s--\n", s);
}

int yywrap()
{
  return 1;
}

char* duplicate_segment(const char* token, int token_length) {
  char* dup = malloc(token_length + 1);
  if (!dup) { /* handle memory allocation error */ }
  memcpy(dup, token, token_length);
  dup[token_length] = 0;
  return dup;
}

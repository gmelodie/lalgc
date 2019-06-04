%{
#include<stdio.h>	
#include "y.tab.h"

int yylex();
void yyerror(char const *s);
%}

%token NUMBER
%left '+' '-'
%left '*' '/'

%%
stmt:expr
	;
expr: expr '+' expr
	| expr '-' expr
	| expr '*' expr
	| expr '/' expr
	| '(' expr ')'
	| NUMBER
/*	| ID */
	;
%%

int main() {
    printf("digite expr : \n");
    yyparse();
	
    printf("expr válida \n");
}

void yywrap(){}

void yyerror (char const *s) {
    fprintf (stderr, "%s\n", s);
}

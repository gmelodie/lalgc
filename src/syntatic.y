%{
#include<stdio.h>
#include "y.tab.h"

int yylex();
void yyerror(char const *s);
%}

%token ID NUM SUM

%start programa

%%

programa:
    dc ID comandos ID
    ;

comandos:
    NUM
    ;

dc:
    SUM
    ;
%%

int main() {
    printf("digite expr : \n");
    yyparse();
}

int yywrap(){return 1;}

void yyerror (char const *s) {
    fprintf (stderr, "%s\n", s);
}



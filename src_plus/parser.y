
%{
#include <iostream>
#include <fstream>
#include <FlexLexer.h>

extern int yylex();
void yyerror(const char *s) { printf("ERROR: %sn", s); }

%}

%token PROGRAM

%%

prog:
;

%%




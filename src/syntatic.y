%{
#include<stdio.h>
//#include "y.tab.h"

int yylex();
void yyerror(char const *s);
void initialize_words_table();

// TODO: como representar o lambda?
%}


%token PROCEDURE PROGRAM DOT CONST
%token READ WRITE
%token ID
%token VAR
%token ATTR 
%token DIV MINUS PLUS TIMES
%token RELATION_S
/*%token EQ NEQ GEQ LEQ GREATER LESS */
%token EQUAL
%token INTEGER INT REAL
%token BEG END
%token FOR WHILE 
%token CLOSE_PAR OPEN_PAR 
%token COLON COMMA SC DO 
%token IF ELSE THEN

%start programa

%%

programa:
    PROGRAM ID SC corpo DOT
    ;

corpo:
    dc BEG comandos END
    ;

dc:
    dc_c dc_v dc_p
    ;


dc_c:
    CONST ID EQUAL numero SC dc_c
	| %empty
    ;


dc_v:
    VAR variaveis COLON tipo_var SC dc_v
	| %empty
    ;


tipo_var:
    REAL
    | INTEGER
    ;

variaveis:
    ID mais_var
    ;


mais_var:
    COMMA variaveis
	| %empty
    ;


dc_p:
    PROCEDURE ID parametros SC corpo_p dc_p
	| %empty
    ;


parametros:
    OPEN_PAR lista_par CLOSE_PAR
	| %empty
    ;


lista_par:
	variaveis COLON tipo_var mais_par
	;


mais_par:
	SC lista_par
	| %empty
	;


corpo_p:
	dc_loc BEG comandos END SC
	;


dc_loc:
	dc_v
	;


lista_arg:
	OPEN_PAR argumentos CLOSE_PAR
	| %empty
	;


argumentos:
	ID mais_ident
	;


mais_ident:
	SC argumentos
	| %empty
	;


pfalsa:
	ELSE cmd
	| %empty
	;


comandos:
	cmd SC comandos
	| %empty
	;


cmd:
	READ OPEN_PAR variaveis CLOSE_PAR
	| WRITE OPEN_PAR variaveis CLOSE_PAR
	| WHILE OPEN_PAR condicao CLOSE_PAR DO cmd
	| IF condicao THEN cmd pfalsa
	| ID ATTR expressao
	| ID lista_arg
	| BEG comandos END
	;


condicao:
	expressao relacao expressao
	;


relacao:
	RELATION_S
	;

/*
	EQ
	| NEQ
	| GEQ
	| LEQ
	| GREATER
	| LESS
	;
*/


expressao:
	termo outros_termos
	;


op_un:
	PLUS
	| MINUS
	| %empty
	;


outros_termos:
	op_ad termo outros_termos
	| %empty
	;


op_ad:
	PLUS
	| MINUS
	;


termo:
	op_un fator mais_fatores
	;


mais_fatores:
	op_mul fator mais_fatores
	| %empty
	;


op_mul:
	TIMES
	| DIV
	;


fator:
	ID
	| numero
	| OPEN_PAR expressao CLOSE_PAR
	;


numero:
	INT
	| REAL
	;



%%

int main() {
    initialize_words_table();
    printf("Type program: \n");
    yyparse();
}


int yywrap(){return 1;}


void yyerror (char const *s) {
    fprintf (stderr, "%s\n", s);
}



%{
#include<stdio.h>
#include<stdlib.h>
#include <iostream>

int yylex();
void yyerror(char const *s);
void initialize_words_table();

int TEST_CASES = 2;

extern FILE * yyin;  // To use other files as input to lex

using namespace std;

%} 


%token PROCEDURE PROGRAM DOT CONST
%token READ WRITE
%token ID
%token VAR
%token ATTR 
%token DIV MINUS PLUS TIMES
%token RELATION_S
/*TODO %token EQ NEQ GEQ LEQ GREATER LESS */
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
	| PROGRAM error DOT
	    {printf("\t\tSyntax error on PROGRAM\n");}
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


dc_p:
	PROCEDURE ID parametros SC corpo_p dc_p
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


parametros:
	OPEN_PAR lista_par CLOSE_PAR
	| OPEN_PAR error CLOSE_PAR
	    {printf("\t\tSyntax error on PROGRAM\n");}
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
	| OPEN_PAR error CLOSE_PAR
		{printf("\t\tSyntax error on lista_arg\n");}
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
	| error cmd
		{printf("\t\tSyntax error: on ELSE\n");}
	| %empty
	;


comandos:
	cmd SC comandos
	| %empty
	;


cmd:
	READ OPEN_PAR variaveis CLOSE_PAR
	| READ error CLOSE_PAR
		{printf("\t\tSyntax error on READ\n");}
	| WRITE OPEN_PAR variaveis CLOSE_PAR
	| WRITE error CLOSE_PAR
		{printf("\t\tSyntax error on WRITE\n");}
	| WHILE OPEN_PAR condicao CLOSE_PAR DO cmd
	| WHILE error DO
		{printf("\t\tSyntax error on WHILE\n");}
	| IF condicao THEN cmd pfalsa
	| IF error THEN
		{printf("\t\tSyntax error on IF\n");}
	| ID ATTR expressao
	| ID lista_arg
	| BEG comandos END
	| BEG error END
		{printf("\t\tSyntax error: missing END\n");}
	;


condicao:
	expressao relacao expressao
	;


relacao:
	RELATION_S
	;
/* TODO
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
	| OPEN_PAR error CLOSE_PAR
		{printf("\t\tSyntax error on fator\n");}
	;


numero:
	INT
	| REAL
	;



%%

FILE* print_menu() {
    /* Prints a user friendly menu.
    Asks the user for a input number corresponding to which test case to use,
	and maps the corresponding file in TEST_DIR

    We return a a file pointer to the test case file or NULL if we need to exit.
    */
    char option;

    printf("Welcome to LALGC, LALG syntatix and lexical analyser!\n\n");
    printf("This program comes with %d test cases. Type:\n", TEST_CASES);

    for (int i = 1; i <= TEST_CASES; i++) {
        printf("\t%d - Run test case %d\n", i, i);
    }

    printf("\tE - Exit program\n\n");

    while (1) {
        printf("Choice: ");
        cin >> option;
        switch (option) {
            case '1': return fopen("input1.in", "r");
            case '2': return fopen("input2.in", "r");
            case 'E': return NULL;
            default: printf("INVALID OPTION! TRY AGAIN\n");
        }
    }
}


int main() {
    initialize_words_table();

    while (1) {
        FILE *input = print_menu();
        if (input == NULL)
            break;

        // Change the input for lex and run test case
        printf("\n\n");
        yyin = input;
        yyparse();
        printf("\n\nFinished test case. Back to menu\n");
    }

    printf("Exiting Program\n");
    return 0;
}


int yywrap(){return 1;}


void yyerror (char const *s) {
    fprintf (stderr, "%s\n", s);
}



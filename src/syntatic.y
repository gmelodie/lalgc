%{
#include<stdio.h>
#include "y.tab.h"

int yylex();
void yyerror(char const *s);
// TODO: como representar o lambda?
%}

%token ID NUM SUM

%start programa

%%

programa:
    PROGRAM SC corpo
    ;

corpo:
    dc BEG comandos END
    ;

dc:
    dc_c dc_v dc_p
    ;

dc_c:
    ID EQUAL numero SC dc_c

    ;

dc_v:

    VAR variaveis COLON tipo_var SC dc_v
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

    ;

dc_p:
    PROCEDURE ID parametros SC corpo_p dc_p

    ;

parametros:
    OPEN_PAR lista_par CLOSE_PAR

    ;

lista_par:
    variavies COLON tipo_var mais_par
    ;

mais_par:
    SC lista_par

    ;

corpo_p:
    dc_loc BEG comandos END SC
    ;

dc_loc:
    dc_v
    ;

lista_arg:
    OPEN_PAR argumentos CLOSE_PAR

    ;

argumentos:
    ID mais_ident
    ;

mais_ident:
    SC argumentos

    ;

pfalsa:
    ELSE cmd

    ;

comandos:
    cmd SC comandos

    ;

cmd:
    READ OPEN_PAR variavies CLOSE_PAR
    | WRITE OPEN_PAR variavies CLOSE_PAR
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
    EQ
    | NEQ
    | GEQ
    | LEQ
    | GREATER
    | LESS
    ;

expressao:
    termo outros_termos
    ;

op_un:
    PLUS
    | MINUS

    ;

outros_termos:
    op_ad termo outros_termos

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
    printf("digite expr : \n");
    yyparse();
}

int yywrap(){return 1;}

void yyerror (char const *s) {
    fprintf (stderr, "%s\n", s);
}



%{
#include <iostream>
#include <fstream>
#include <FlexLexer.h>
#include <cstring>
#include <map>
#include "y.tab.h"

using namespace std;

int recognize_reserved_words(char *);
void correct_print(char *, char *);

%}

COLON ":"
SC ";"
OP "("
CP ")"
DOT "."
COMMA ","

FOR_EQUAL ":="
TO "to"


MATH_SUM (\+|\-)
MATH_MUL (\*|\/)
RELATION_S (>|>=|<|<=|==|<>)
ATRIBUTION :=


INTEGER_NUMBER [+-]?[0-9]+
ERR_INT_NUMBER [+-]?[0-9]+[a-zA-Z][^ \n\t]*

REAL_NUMBER [+-]?[0-9]+"."[0-9]+
ERR_REAL_NUMBER1 [+-]?[0-9]+"."[0-9]*[a-zA-Z][^ \n\t]*
ERR_REAL_NUMBER2 [+-]?"."[0-9][^ \n\t]*

ID [a-zA-Z][a-zA-Z0-9]*


COMMENT "{".*"}"
ERR_COMMENT "{".*

SPACES [ \n\t]+

ERR_SYMBOL .*[\^\'\"\!\@\#\$\%\&\~][^ \n\t]*

/* Rule Section */

%%

{COMMENT} {}
{ERR_COMMENT} {printf("%s - ERRO COMENTÁRIO MAL FORMADO\n", yytext);}


{ERR_REAL_NUMBER1} {printf("%s - ERRO NUMERO REAL MAL FORMADO\n", yytext);}
{ERR_REAL_NUMBER2} {printf("%s - ERRO NUMERO REAL MAL FORMADO\n", yytext);}
{ERR_INT_NUMBER} {printf("%s - ERRO NUMERO INTEIRO MAL FORMADO\n", yytext);}
{INTEGER_NUMBER} { if(yyleng > 100)
			printf("ERRO TAMANHO DO INTEIRO EXCEDIDO\n");
		 else
			return INT;}
{REAL_NUMBER} { if(yyleng > 200)
		    printf("ERRO TAMANHO DO REAL EXCEDIDO\n");
		else
		    return REAL;}

{ID} {return recognize_reserved_words(yytext);}

{COLON} {return COLON;}
{SC} { printf("%s - SEMI COLON\n", yytext); return SC;}
{OP} { printf("%s - SYMB_OPEN_PAREN\n", yytext); return OPEN_PAR;}
{CP} { printf("%s - SYMB_CLOSE_PAREN\n", yytext); return CLOSE_PAR;}
{DOT} { printf("%s - SYMB_DOT\n", yytext); return DOT;}
{COMMA} { printf("%s - SYMB_COMMA\n", yytext); return COMMA;}
{MATH_SUM} { correct_print(yytext, "SYMB_PLUS"); return PLUS; }
{MATH_MUL} { printf("%s - SYMB_MULT\n", yytext); return TIMES;}
{RELATION_S} { printf("%s - SYMB_COMP\n", yytext); return RELATION_S;}
{ATRIBUTION} { printf("%s - SYMB_ATTRIBUTION\n", yytext); return ATTR;}

{ERR_SYMBOL} {printf("%s - ERRO TOKEN INVÁLIDO\n", yytext);}

{SPACES} {}


%%

/** Code Section **/

map <string, int> reserved_words_table;

void initialize_words_table() {
    reserved_words_table["while"] = WHILE;
    reserved_words_table["begin"] = BEG;
    reserved_words_table["end"] = END;
    reserved_words_table["real"] = REAL;
    reserved_words_table["integer"] = INTEGER;
    reserved_words_table["program"] = PROGRAM;
    reserved_words_table["const"] = CONST;
    reserved_words_table["var"] = VAR;
    reserved_words_table["procedure"] = PROCEDURE;
    reserved_words_table["read"] = READ;
    reserved_words_table["write"] = WRITE;
    reserved_words_table["if"] = IF;
    reserved_words_table["then"] = THEN;
    reserved_words_table["else"] = ELSE;
    reserved_words_table["do"] = DO;
    reserved_words_table["for"] = FOR;
}

int yywrap(){return(1);}


int recognize_reserved_words(char *id) {
    if(strlen(id) > 100) {
        printf("ERRO TAMANHO DO ID EXCEDIDO\n");
        // TODO: change return value to ERROR
        return 0;
    }
    if(reserved_words_table.count(id) == 0) { // didn't find id on reserved words
        printf("%s - ID\n", id);
        return ID;
    }
    else {
        printf("%s - PALAVRA RESERVADA\n", id);
        return reserved_words_table[id];
    }
}


void correct_print(char *id, char *name) {
    printf("%s - %s\n", yytext, name);
}



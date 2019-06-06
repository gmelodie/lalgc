%{
#include <iostream>
#include <fstream>
#include <FlexLexer.h>
#include <cstring>
#include <map>
#include "y.tab.h"

using namespace std;

void recognize_reserved_words(char *);
void correct_print(char *, char *);

%}

COLON ":"
SC ";"
OP "("
CP ")"
DOT "."
COMMA ","
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

/*** Rule Section ***/

%%

{COMMENT} {}
{ERR_COMMENT} {printf("%s - ERRO COMENTÁRIO MAL FORMADO\n", yytext);}


{ERR_REAL_NUMBER1} {printf("%s - ERRO NUMERO REAL MAL FORMADO\n", yytext);}
{ERR_REAL_NUMBER2} {printf("%s - ERRO NUMERO REAL MAL FORMADO\n", yytext);}
{ERR_INT_NUMBER} {printf("%s - ERRO NUMERO INTEIRO MAL FORMADO\n", yytext);}
{INTEGER_NUMBER} { if(yyleng > 100)
			printf("ERRO TAMANHO DO INTEIRO EXCEDIDO\n"); 
		 else 
			return NUM;}
{REAL_NUMBER} { if(yyleng > 200)
		    printf("ERRO TAMANHO DO REAL EXCEDIDO\n"); 
		else 
		    return NUM;}

{ID} {recognize_reserved_words(yytext);}

{COLON} {}
{SC} {}
{OP} { printf("%s - SYMB_OPEN_PAREN\n", yytext);}
{CP} { printf("%s - SYMB_CLOSE_PAREN\n", yytext);}
{DOT} { printf("%s - SYMB_DOT\n", yytext);}
{COMMA} { printf("%s - SYMB_COMMA\n", yytext);}
{MATH_SUM} { correct_print(yytext, "SYMB_PLUS"); return SUM; } /* printf("%s - SYMB_PLUS\n", yytext);} */
{MATH_MUL} { printf("%s - SYMB_MULT\n", yytext);}
{RELATION_S} { printf("%s - SYMB_COMP\n", yytext);}
{ATRIBUTION} { printf("%s - SYMB_ATTRIBUTION\n", yytext);}

{ERR_SYMBOL} {printf("%s - ERRO TOKEN INVÁLIDO\n", yytext);}


%%

/** Code Section **/ map <string, bool> reserved_words_table; void initialize_words_table() {
    reserved_words_table.insert(pair <string, bool> ("while", true));
    reserved_words_table.insert(pair <string, bool> ("begin", true));
    reserved_words_table.insert(pair <string, bool> ("end", true));
    reserved_words_table.insert(pair <string, bool> ("real", true));
    reserved_words_table.insert(pair <string, bool> ("integer", true));
    reserved_words_table.insert(pair <string, bool> ("program", true));
    reserved_words_table.insert(pair <string, bool> ("const", true));
    reserved_words_table.insert(pair <string, bool> ("var", true));
    reserved_words_table.insert(pair <string, bool> ("procedure", true));
    reserved_words_table.insert(pair <string, bool> ("read", true));
    reserved_words_table.insert(pair <string, bool> ("write", true));
    reserved_words_table.insert(pair <string, bool> ("if", true));
    reserved_words_table.insert(pair <string, bool> ("then", true));
    reserved_words_table.insert(pair <string, bool> ("else", true));
    reserved_words_table.insert(pair <string, bool> ("do", true));
}

int yywrap(){return(1);}


void recognize_reserved_words(char *id) {
    if(strlen(id) > 100) {
        printf("ERRO TAMANHO DO ID EXCEDIDO\n", id);
        return;
    }
    if(reserved_words_table.count(id) == 0) // didn't find id on reserved words
        printf("%s - ID\n", id);
    else
        printf("%s - PALAVRA RESERVADA\n", id);
}


void correct_print(char *id, char *name) {
    printf("%s - %s\n", yytext, name);
}


/*
int main() {
    initialize_words_table();
    yylex();
    return 0;
}
*/




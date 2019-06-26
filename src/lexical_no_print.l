%{
#include <iostream>
#include <fstream>
#include <FlexLexer.h>
#include <cstring>
#include <map>
#include "y.tab.h"

using namespace std;

// Function declarations
int recognize_reserved_words(char *);
void correct_print(char *, char *);

%}

COLON ":"
SC ";"
OP "("
CP ")"
DOT "."
COMMA ","

TO "to"

MATH_SUM (\+|\-)
MATH_MUL (\*|\/)
RELATION_S (>|>=|<|<=|==|<>)
ATRIBUTION :=

INTEGER_NUMBER [0-9]+
ERR_INT_NUMBER [0-9]+[a-zA-Z][^ \n\t]*

REAL_NUMBER [0-9]+"."[0-9]+
ERR_REAL_NUMBER1 [0-9]+"."[0-9]*[a-zA-Z][^ \n\t]*
ERR_REAL_NUMBER2 "."[0-9][^ \n\t]*

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
			return INT_NUM; }
{REAL_NUMBER} { if(yyleng > 200)
		    printf("ERRO TAMANHO DO REAL EXCEDIDO\n");
		else
		    return REAL_NUM;}

{ID} {return recognize_reserved_words(yytext);}

{COLON} {return COLON;}
{SC} { return SC;}
{OP} { return OPEN_PAR;}
{CP} { return CLOSE_PAR;}
{DOT} { return DOT;}
{COMMA} { return COMMA;}
{MATH_SUM} { return PLUS; }
{MATH_MUL} { return TIMES;}
{RELATION_S} { return RELATION_S;}
{ATRIBUTION} { return ATTR;}

{ERR_SYMBOL} {printf("%s - ERRO TOKEN INVÁLIDO\n", yytext);}

{SPACES} {}


%%
/** Code Section **/


// Hash map for reserved key words
map <string, int> reserved_words_table;


void initialize_words_table() {
    /* Initializes the hash table by adding all the necessary keywords.
    */

    reserved_words_table["while"] = WHILE;
    reserved_words_table["begin"] = BEG;
    reserved_words_table["end"] = END;
    reserved_words_table["real"] = REAL;
    reserved_words_table["integer"] = INTEGER;
    reserved_words_table["real"] = REAL;
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
    reserved_words_table["to"] = TO;
}


// Helper function for Lex
int yywrap(){return(1);}


int recognize_reserved_words(char *id) {
    /* Checks if a given ID is valid. For this we check:
	    - If the length of the ID is valid;
	    - If the ID is reserved keyword.
    */

    if(strlen(id) > 100) {
        printf("ERRO TAMANHO DO ID EXCEDIDO\n");
        return 0;
    }

    if(reserved_words_table.count(id) == 0) { 
	// Didn't find the ID as a reserved word
        return ID;
    }
    else {
	// Everything is ok with the ID
        return reserved_words_table[id];
    }
}


void correct_print(char *id, char *name) {
    /* Helper function to print a ID
    */
    printf("%s - %s\n", yytext, name);
}

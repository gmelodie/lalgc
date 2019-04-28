%{
#include <iostream>
#include <fstream>
#include <FlexLexer.h>

using namespace std;
%}

COLON ":"
SC ";"
OB "{"
CB "}"
OP "("
CP ")"
DOT "."
COMMA ","
MATH_SUM (\+|\-)
MATH_MUL (\*|\/)
RELATION_S (>|>=|<|<=|==|<>)
ATRIBUTION :=

NUMBER [+-]?[0-9]+[["."]?[0-9]+]?

ERR_INT_NUMBER [+-]?[0-9]+[^0-9\.]*

ERR_FLOAT_NUMBER [+-]?[0-9]+[^0-9\.]*

ID [a-zA-Z]

SPACES [ \n\t]+

ERR_SYMBOL [\^\'\"\!\@\#\$\%\&\~]

UNRECOG_SYMBOL .+





/*** Rule Section***/

%%


{COLON} { printf("%s - symb_colon\n", yytext);}
{SC} { printf("%s - symb_semi_colon\n", yytext);}
{OB} { printf("%s - symb_open_brackets\n", yytext);}
{CB} { printf("%s - symb_close_brackets\n", yytext);}
{OP} { printf("%s - symb_open_paren\n", yytext);}
{CP} { printf("%s - symb_close_paren\n", yytext);}

{DOT} { printf("%s - symb_dot\n", yytext);}
{COMMA} { printf("%s - symb_comma\n", yytext);}

{MATH_SUM} { printf("%s - symb_plus\n", yytext);}
{MATH_MUL} { printf("%s - symb_mult\n", yytext);}
{RELATION_S} { printf("%s - symb_comp\n", yytext);}
{ATRIBUTION} { printf("%s - symb_attribution\n", yytext);}

{NUMBER} { printf("%s - number\n", yytext);}

{ID} { printf("%s - id\n", yytext);}

{ERR_SYMBOL} {printf("%s - erro símbolo não pertencente à linguagem\n", yytext);}

{UNRECOG_SYMBOL} {printf("%s - erro símbolo não reconhecido\n", yytext);}

{SPACES} {}

%%



/*** Code Section

***/

int yywrap(){return(1);}

int main() {
    cout << "Testing C++ stuff" << endl;
    yylex();
    return 0;
}

/*
    printf("Testing");
    cout << "Testing C++ stuff" << endl;
    return 0;

}
*/


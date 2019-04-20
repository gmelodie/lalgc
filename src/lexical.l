PROGRAM program
PROCEDURE procedure
VAR var
BEGIN begin
END end
CONST const
COLON :
SC ;
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

INT [0-9]+
FLOAT [0-9]+"."[0-9]+
	
FUNC (read|write)
LOOP (while|do|for)
COND (if|else|then)

CMD (FUNC|LOOP|COND)

IDENT [a-zA-Z][a-zA-Z0-9]*


SPACES [ \n]+ 






/*** Rule Section***/

%%

{PROGRAM} { printf("%s - program\n", yytext);}
{PROCEDURE} { printf("%s - procedure\n", yytext);}
{VAR} { printf("%s - var\n", yytext);}
{BEGIN} { printf("%s - begin\n", yytext);}
{END} { printf("%s - end\n", yytext);}
{CONST} { printf("%s - const\n", yytext);}

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

{INT} { printf("%s - integer\n", yytext);}
{FLOAT} { printf("%s - real\n", yytext);}

{FUNC} { printf("%s - reserved_function\n", yytext);}
{LOOP} { printf("%s - reserved_loop\n", yytext);}
{COND} { printf("%s - reserved_conditional\n", yytext);}
{CMD} { printf("%s - cmd\n", yytext);}

{IDENT} { printf("%s - id\n", yytext);}

{ATRIBUTION} { printf("%s - simb_attribution\n", yytext);}

{SPACES} {}

%%






/*** Code Section***/
int main() {
    yylex();
    return 0;
}



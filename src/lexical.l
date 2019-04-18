RESERVADA (while|if|for)
REGEX_PLUS plus+
REGEX_AST asterisk*
%%
^{RESERVADA} {printf("RESERVADA\n");}
REGEX_PLUS {printf("plus\n");}
REGEX_AST {printf("ast\n");}
%%
int main() {
    yylex();
    return 0;
}

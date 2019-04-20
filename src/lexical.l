PROGRAM program
PROCEDURE procedure
VAR var
BEGIN begin
END end

CONST const

COLON :
SC ;

OB {
CB }
OP (
CP )

DOT .
COMMA ,

MATH_SUM (+|-)
MATH_MUL (*|/)
RELATION_S (>|>=|<|<=|==|<>)

INT {0-9}+
FLOAT {0-9}+.{0-9}+
	
FUNC (read|write)
LOOP (while|do|for)
COND (if|else|then)

CMD (FUNC|LOOP|COND)

IDENT {a-zA-Z}{a-zA-Z0-9}+

%%
^{LOOP} {printf("RESERVADA\n");}
%%

int main() {
    yylex();
    return 0;
}



all: lexical

lexical:
	flex lexical.l
	gcc lex.yy.c -lfl -o lexical
	./lexical < test.txt

clean:
	rm lexical lex.yy.c


all: lexical

lexical:
	flex lexical.l
	g++ lex.yy.c -o lexical
	./lexical < input.in | tee saida.txt

clean:
	rm lexical lex.yy.c

test:
	rm lexical lex.yy.c
	flex lexical.l
	g++ lex.yy.c -o lexical
	./lexical < input.in | tee saida.txt



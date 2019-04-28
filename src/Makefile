all: lexical

lexical:
	flex lexical.l
	g++ lex.yy.c -o lexical
	./lexical < test.txt | tee saida.txt

clean:
	rm lexical lex.yy.c

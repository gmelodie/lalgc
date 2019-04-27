all: lexical

lexical:
	flex lexical.l
	g++ lex.yy.c -o lexical
	echo "\n\n\n"
	./lexical < test.txt | tee saida.txt

clean:
	rm lexical lex.yy.c

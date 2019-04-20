all: lexical

lexical:
	flex lexical.l
	gcc lex.yy.c -lfl -o lexical
	echo "\n\n\n"
	./lexical < test.txt | tee saida.txt

clean:
	rm lexical lex.yy.c


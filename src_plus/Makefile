all: default


default:
	clear
	flex -l lexical.l
	bison -dv parser.y
	g++ -o test parser.tab.c lex.yy.c

lexical:
	flex lexical.l
	g++ lex.yy.c -o lexical
	echo "\n\n\n"

clean:
	rm lexical lex.yy.c
hmm:
	./lexical < test.txt | tee saida.txt


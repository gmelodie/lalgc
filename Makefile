all:
	if [ ! -d "./build" ]; then mkdir ./build; fi
	flex -o build/lex.yy.c src/lexical.l
	cp src/y.tab.h build/
	yacc -d src/syntatic.y -o build/syntatic.tab.c
	g++ build/lex.yy.c build/syntatic.tab.c -o build/meuprograma

clean:
	rm -f ./build/lexical
	rm -f ./build/lex.yy.c
	rm -f build/syntatic.tab.c
	rm -f build/y.tab.h

run:
	./build/meuprograma

test:
	./build/meuprogama < input.in | tee saida.out


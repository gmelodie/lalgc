all:
	if [ ! -d "./build" ]; then mkdir ./build; fi
	flex -o build/lex.yy.c src/lexical.l
	yacc -d src/syntatic.y --defines=build/y.tab.h -o build/y.tab.c
	g++ build/lex.yy.c build/y.tab.c -o build/meuprograma

clean:
	rm -rf build/

run:
	if [ -d "./build" ]; then ./build/meuprograma; fi
	if [ ! -d "./build" ]; then echo "Run failed, build first"; fi


test:
	./build/meuprograma < input.in | tee saida.out


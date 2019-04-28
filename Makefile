all:
	if [ ! -d "./build" ]; then mkdir ./build; fi
	flex -o build/lex.yy.c src/lexical.l
	g++ build/lex.yy.c -o build/lexical

clean:
	rm -f ./build/lexical
	rm -f ./build/lex.yy.c

run:
	./build/lexical < input.in | tee saida.out


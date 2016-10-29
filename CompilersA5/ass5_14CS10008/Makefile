all: a.out

a.out: lex.yy.o y.tab.o ass5_14CS10008_translator.o 
	g++ lex.yy.o y.tab.o ass5_14CS10008_translator.o -lfl


y.tab.o:	y.tab.c
	g++ -c y.tab.c

lex.yy.o:	lex.yy.c
	g++ -c lex.yy.c

lex.yy.c:	ass5_14CS10008.l y.tab.c
	flex ass5_14CS10008.l

y.tab.c:	ass5_14CS10008.y
	yacc -dtv ass5_14CS10008.y

ass5_14CS10008_translator.o: ass5_14CS10008_translator.h ass5_14CS10008_translator.cxx
	g++ -c ass5_14CS10008_translator.cxx

clean:
	rm a.out y.tab.o lex.yy.o lex.yy.c y.tab.c y.tab.h y.output ass5_14CS10008_translator.o

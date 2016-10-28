all: a.out

a.out: y.tab.c lex.yy.c ass3_14CS10008.o
	gcc y.tab.c lex.yy.c ass3_14CS10008.o
	./a.out < ass3_14CS10008_test.c
lex.yy.c: ass3_14CS10008.l
	flex ass3_14CS10008.l

y.tab.c: ass3_14CS10008.y
	bison -dy ass3_14CS10008.y

ass3_14CS10008.o: ass3_14CS10008.c
	gcc -c ass3_14CS10008.c

clean:
	rm y.tab.c y.tab.h a.out lex.yy.c y.output ass3_14CS10008.o

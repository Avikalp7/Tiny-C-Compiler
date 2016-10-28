a.out: y.tab.o lex.yy.o ass4_14CS10008.o 
	gcc ass4_14CS10008.o lex.yy.o y.tab.o -lfl
	./a.out < ass4_14CS10008_test.c
lex.yy.c: ass4_14CS10008.l y.tab.h
	flex ass4_14CS10008.l
y.tab.c: ass4_14CS10008.y
	bison -dty ass4_14CS10008.y
ass4_14CS10008.o: ass4_14CS10008.c y.tab.h
	gcc -c ass4_14CS10008.c
y.tab.h: ass4_14CS10008.y
	bison -dty ass4_14CS10008.y
lex.yy.o: lex.yy.c
	gcc -c lex.yy.c
y.tab.o:    y.tab.c y.tab.h
	gcc -c y.tab.c
clean:
	rm a.out lex.yy.o ass4_14CS10008.o lex.yy.c y.tab.c y.tab.h y.tab.o y.output
run:
	./a.out < ass4_14CS10008_test.c
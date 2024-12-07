task5:	task5.l task5.y task5funcs.c
	bison -d task5.y
	flex -o task5.lex.c task5.l
	gcc -o $@ task5.tab.c task5.lex.c task5funcs.c

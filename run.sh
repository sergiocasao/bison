rm practica.tab.* lex.yy.c salida
bison -d practica.y
flex practica.l
gcc practica.tab.c lex.yy.c -o salida -lm
./salida

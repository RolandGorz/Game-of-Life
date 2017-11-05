all: game

game:conway.s game.c
	gcc -ansi -pedantic -Wall -g -m32 -o game conway.s game.c


clean:
	rm -f game
	rm -f *.o

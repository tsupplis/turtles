clean:
	-@rm turtles_expanded.asm 2> /dev/null
	-@rm turtles.o65 2> /dev/null
	-@rm a2lisp

# Expand macros with CPP, then remove all newlines and CPP junk
compile:
	@gcc -Wall -std=gnu99 a2lisp.c -o a2lisp
	@cpp turtles.asm | sed -E 's/(;.*)|(^#.*)//' | awk /./{print} > turtles_expanded.asm
	@xa turtles_expanded.asm -o turtles.o65

send: compile
	@./transport turtles.o65 | sox -b 8 -r 44100 -L -c 1 -t raw -e unsigned-integer - -d

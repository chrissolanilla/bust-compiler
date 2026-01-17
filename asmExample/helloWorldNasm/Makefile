.PHONY: build

default: build

build:
	nasm -felf64 hello.asm
	ld -o hello hello.o
	./hello

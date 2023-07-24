all: linux win
linux:
	v . -o bin/infini
win:
	v . -os windows -o bin/infini.exe

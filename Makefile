all: linux win
linux:
	v . -o bin/respawn
win:
	v . -os windows -o bin/respawn.exe

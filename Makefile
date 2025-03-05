.PHONY: build run install clean

build:
	./build.sh

run: build
	./run.sh

install: build
	./install.sh

clean:
	rm -rf AutoType.app 
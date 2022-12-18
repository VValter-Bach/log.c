CC=gcc
AR=ar
FLAGS=-Wall -Wextra -O3 -Wpedantic -std=c99
DIR=/usr/local

all: prerequisit static dynamic
	cp src/log.h out/log.h

prerequisit: 
	mkdir -p obj
	mkdir -p out

static: src/log.c
	$(CC) $(FLAGS) -c src/log.c -o obj/logc.s.o
	$(AR) rcs out/liblogc.a obj/logc.s.o

dynamic: src/log.c
	$(CC) $(FLAGS) -fpic -c src/log.c -o obj/logc.d.o
	$(CC) $(FLAGS) -shared obj/logc.d.o -o out/liblogc.so

clean: prerequisit
	rm obj/*
	rm out/*

install: out/liblogc.a out/liblogc.so
	mkdir -p $(DIR)/include/log.c/
	cp out/liblogc.a $(DIR)/lib 
	cp out/liblogc.so $(DIR)/lib 
	cp out/log.h $(DIR)/include/log.c/

uninstall:
	rm -r $(DIR)/include/log.c/
	rm $(DIR)/lib/liblogc.a
	rm $(DIR)/lib/liblogc.so
##############################################################################
# Makefile for Lab 12
# CMP_SC 1050
# SP 2024
# By Jim Ries (RiesJ@missouri.edu)
##############################################################################

# Setup default compiler, compile options, and link options
CC = gcc
CFLAGS = -Wall -Werror -c -g -std=c11 -pedantic-errors
LDFLAGS = -lm -L. -lfight

%.o : %.c 
	@echo Compiling $^ ...
	@$(CC) $(CFLAGS) $^

# Default target
default: a.out

# Other targets
regular: clean a.out

debug: CFLAGS += -DDEBUG
debug: clean a.out

honors: CFLAGS += -DHONORS
honors: clean a.out

honorsdebug: CFLAGS += -DHONORS -DDEBUG
honorsdebug: clean a.out

lib: CFLAGS += -std=gnu11
lib: libfight.a

# Executable
a.out : lab12.o
	@echo Linking $@ ...
	@$(CC) $^ $(LDFLAGS) -o $@
	@echo Done!

# Clean build targets
clean : 
	@rm -rf *.o
	@rm -rf a.out
	@echo All Clean!

cleanall: clean cleanlib

cleanlib :
	@rm -rf *.a

# Build the library (if you have the source)
libfight.a : fight.o
	ar -crs libfight.a fight.o
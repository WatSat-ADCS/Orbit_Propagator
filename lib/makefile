# Makefile for clock and satPosition Library functions
#===================================================================================================================
#
# Copyright (c) 2015 WatSat-ADCS
# Licensed under the MIT license.
#
# authors: Jason Pye (j2pye@uwaterloo.ca)
#
# Change log:
# 2015-12-02 (JP) - Initial release
#
#===================================================================================================================

LIBCLOCK_NAME = clock
LIBSATPOSN_NAME = satPosition

TESTS_DIR = ./tests

#===================================================================================================================

CC = gcc
LD = ld
AR = ar rc
RANLIB = ranlib
RM = rm -f

DEBUG = -g
OPT = -O3
ERR = -Wall
INC_PATH = -I.
LIB_PATH = 
LIBS =
CC_FLAGS = $(INC_PATH) $(DEBUG) $(OPT) $(ERR) -fpic
LD_FLAGS = $(LIB_PATH) $(LIBS) -shared -soname=$(LIBNAME) 

#===================================================================================================================

.PHONY: all clean check

all: lib$(LIBCLOCK_NAME).so

%.so: %.a
	$(LD) $(LD_FLAGS) -soname=$@ --whole-archive $< --no-whole-archive -o $@

lib%.a: %.o
	$(AR) lib$(LIBCLOCK_NAME).a $<
	$(RANLIB) lib$(LIBCLOCK_NAME).a

%.o: %.c
	$(CC) $(CC_FLAGS) -o $@ -c $<

clean:
	$(RM) *.o

check: lib$(LIBCLOCK_NAME).so
	cd $(TESTS_DIR) && make && make check

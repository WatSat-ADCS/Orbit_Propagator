# Makefile for clock and satPosition Library functions
#===================================================================================================================
#
# Copyright (c) 2015 WatSat-ADCS
# Licensed under the MIT license.
#
# authors: Jason Pye (j2pye@uwaterloo.ca)
#
# Change log:
# 2015-12-03 (JP) - Initial release
#
#===================================================================================================================

LIBCLOCK_NAME = clock
LIBSATPOSN_NAME = satPosition

SGP4_DIR = ./SGP4/cpp/
SGP4_NAMES = sgp4unit sgp4io sgp4ext

LIBSATPOSN_OBJS = $(LIBSATPOSN_NAME).o $(LIBCLOCK_NAME).o $(SGP4_NAMES:%=$(SGP4_DIR)%.o)

TESTS_DIR = ./tests/

#===================================================================================================================

CC = g++
LD = ld
AR = ar rc
RANLIB = ranlib
RM = rm -f

DEBUG = -g
OPT = -O3
ERR = -Wall
INC_PATH = -I. -I./SGP4/cpp
LIB_PATH = 
LIBS =
CC_FLAGS = $(INC_PATH) $(DEBUG) $(OPT) $(ERR) -fPIC
LD_FLAGS = $(LIB_PATH) $(LIBS) -shared

#===================================================================================================================

.PHONY: all clean check

all: lib$(LIBCLOCK_NAME).so lib$(LIBSATPOSN_NAME).so

%.so: %.a
	$(LD) $(LD_FLAGS) -soname=$@ --whole-archive $< --no-whole-archive -o $@

lib$(LIBCLOCK_NAME).a: $(LIBCLOCK_NAME).o
	$(AR) lib$(LIBCLOCK_NAME).a $^
	$(RANLIB) lib$(LIBCLOCK_NAME).a

lib$(LIBSATPOSN_NAME).a: $(LIBSATPOSN_OBJS)
	$(AR) lib$(LIBSATPOSN_NAME).a $^
	$(RANLIB) lib$(LIBSATPOSN_NAME).a

$(LIBCLOCK_NAME).o: $(LIBCLOCK_NAME).c
	$(CC) $(CC_FLAGS) -o $@ -c $<

$(LIBSATPOSN_NAME).o: $(LIBSATPOSN_NAME).c
	$(CC) $(CC_FLAGS) -o $@ -c $<

$(SGP4_NAMES:%=$(SGP4_DIR)%.o):
	cd $(SGP4_DIR) && make

clean:
	$(RM) *.o *.a *.so
	cd $(SGP4_DIR) && make clean

check: lib$(LIBCLOCK_NAME).so lib$(LIBSATPOSN_NAME).so
	cd $(TESTS_DIR) && make && make check

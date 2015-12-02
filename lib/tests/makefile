# Makefile for clock and satPosition Unit tests
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

#===================================================================================================================

CC = gcc
RM = rm -f

DEBUG = -g
OPT = -O3 -fprofile-arcs -ftest-coverage
ERR = -Wall
INC_PATH = -I. -I.. -I../SGP4/cpp
LIB_PATH = -L..
LD_PATH = ..
CHECK_LIBS = -Wl,--whole-archive -lcheck -Wl,--no-whole-archive
LIBS = $(CHECK_LIBS) -lm -lrt -lpthread
CC_FLAGS = $(INC_PATH) $(OPT) $(ERR) -DUNIT-TEST
LD_FLAGS = $(LIB_PATH) -pthread

#===================================================================================================================

TEST_CLOCK = test_$(LIBCLOCK_NAME)
TEST_CLOCK_SRC = test_clock.c
TEST_CLOCK_FLAGS = $(CC_FLAGS) $(LD_FLAGS)
TEST_CLOCK_LIBS = $(LIBS) -l$(LIBCLOCK_NAME)

TEST_SATPOSN = test_$(LIBSATPOSN_NAME)
TEST_SATPOSN_SRC = test_satPosition.c
TEST_SATPOSN_FLAGS = $(CC_FLAGS) $(LD_FLAGS)
TEST_SATPOSN_LIBS = $(LIBS) -l$(LIBCLOCK_NAME) -l$(LIBSATPOSN_NAME)

TESTS = $(TEST_CLOCK) $(TEST_SATPOSN)

#===================================================================================================================

.PHONY: all clean check

all: $(TESTS)

$(TEST_CLOCK): $(TEST_CLOCK_SRC)
	$(CC) $(TEST_CLOCK_FLAGS) -o $@ $^ $(TEST_CLOCK_LIBS)

$(TEST_SATPOSN): $(TEST_SATPOSN_SRC)
	$(CC) $(TEST_SATPOSN_FLAGS) -o $@ $^ $(TEST_SATPOSN_LIBS)

clean:
	$(RM) $(TESTS) *.gcno *.gcda *.o

check:
	for t in $(TESTS); do	\
		LD_LIBRARY_PATH='$(LD_PATH)' ./$$t;	\
	done

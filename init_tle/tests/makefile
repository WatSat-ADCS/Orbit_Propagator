# Makefile for init_tle.m Unit tests
#===================================================================================================================
#
# Copyright (c) 2015 WatSat-ADCS
# Licensed under the MIT license.
#
# authors: Jason Pye (j2pye@uwaterloo.ca)
#
# Change log:
# 2015-12-04 (JP) - Initial release
#
#===================================================================================================================

TLE_FILE = ../tle_init.txt
SGP4_PATH = ../../lib/SGP4/cpp
SGP4_OBJS = sgp4unit.o sgp4io.o sgp4ext.o

#===================================================================================================================

CC = g++
RM = rm -f

DEBUG = -g
OPT = -O2 -fprofile-arcs -ftest-coverage
ERR = -Wall
INC_PATH = -I. -I$(SGP4_PATH)
CHECK_LIBS = -Wl,--whole-archive -lcheck -Wl,--no-whole-archive
LIBS = $(CHECK_LIBS) -lm -lrt -lpthread
CC_FLAGS = $(INC_PATH) $(OPT) $(ERR) -DUNIT-TEST
LD_FLAGS = -pthread

#===================================================================================================================

TEST_TLE = test_initTLE
TEST_TLE_SRC = $(TEST_TLE).c
TEST_TLE_FLAGS = $(CC_FLAGS) $(LD_FLAGS)
TEST_TLE_LIBS = $(LIBS) $(SGP4_OBJS:%=$(SGP4_PATH)/%)

TESTS = $(TEST_TLE)

#===================================================================================================================

.PHONY: all clean check

all: $(TESTS)

$(TEST_TLE): $(TEST_TLE_SRC)
	$(CC) $(TEST_TLE_FLAGS) -o $@ $< $(TEST_TLE_LIBS)

clean:
	$(RM) $(TESTS) *.gcno *.gcda *.o

check:
	for t in $(TESTS); do	\
		./$$t;	\
	done

# Makefile for Propagator Simulation
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

TGT_NAME = propagator_simulation

LIB_DIR = ./lib

CC = g++
RM = rm -f

DEBUG = -g
OPT = -O3
ERR = -Wall
INC_PATH = -I. -I$(LIB_DIR) -I./lib/SGP4/cpp
LIB_PATH = -L$(LIB_DIR)
LIBS = -lclock -lsatPosition
CC_FLAGS = $(INC_PATH) $(DEBUG) $(OPT) $(ERR)

#===================================================================================================================

.PHONY: all clean run

all: $(TGT_NAME)

$(TGT_NAME): $(TGT_NAME).o
	cd $(LIB_DIR) && make && make check
	$(CC) $(CC_FLAGS) $(LIB_PATH) -o $@ $^ $(LIBS)

$(TGT_NAME).o: $(TGT_NAME).c
	$(CC) $(CC_FLAGS) -o $@ -c $<

clean:
	$(RM) $(TGT_NAME)

run:
	LD_LIBRARY_PATH='$(LIB_DIR)' ./$(TGT_NAME);

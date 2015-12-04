# Makefile for SGP4 files
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

TGT_NAMES = sgp4ext sgp4unit sgp4io

CC = g++
RM = rm -f

DEBUG = -g
OPT = -O3
ERR = -Wall
INC_PATH = -I.
CC_FLAGS = $(INC_PATH) $(DEBUG) $(OPT) $(ERR) -fPIC

#===================================================================================================================

.PHONY: all clean

all: $(TGT_NAMES:=.o)

%.o: %.cpp
	$(CC) $(CC_FLAGS) -o $@ -c $<

clean:
	$(RM) $(TGT_NAMES:=.o)

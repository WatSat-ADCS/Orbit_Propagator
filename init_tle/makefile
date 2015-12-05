# Makefile to check whether the TLE file produced by init_tle.m
# will work in the Orbit Propagator simulation
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

TLE_FILE = tle_init.txt
TESTS_DIR = ./tests

#===================================================================================================================

.PHONY: check

check: $(TLE_FILE)
	cd $(TESTS_DIR) && make && make check

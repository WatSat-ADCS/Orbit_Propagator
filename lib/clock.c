/*
  Clock for Orbit propagator simulation

  Copyright (c) 2015 WatSat-ADCS
  Licensed under the MIT license.

  authors: Jason Pye (j2pye@uwaterloo.ca)

  Change log:
  2015-12-02 (JP) - Initial release
*/

#include <stdio.h>
#include <stdlib.h>
#include "clock.h"


// Returns current time from clock file.
double readClock(const char* clockfile) {

  double jdate = -1.;

  FILE *fptr;
  fptr = fopen( clockfile, "r" );
  if (fptr == NULL) {
    printf("Error opening file: %s\n", clockfile);
    return -1;
  }

  int ret_code = fscanf(fptr, "%lf", &jdate);
  if (ret_code != 1) {
    printf("There was an error retrieving data from: %s\n", clockfile);
    fclose(fptr);
    return -1;
  }

  fclose(fptr);
  return jdate;
}


// Write new_jdate to clock file.
void writeClock(const char* clockfile, double new_jdate) {

  FILE *fptr;
  fptr = fopen( clockfile, "w" );
  if (fptr == NULL) {
    printf("Error opening file: %s\n", clockfile);
    return;
  }

  int ret_code = fprintf(fptr, "%.5lf", new_jdate);
  if (ret_code < 0) {
    printf("There was an error writing data to: %s\n", clockfile);
    fclose(fptr);
    return;
  }

  fclose(fptr);
  return;
}


// Reset clock to some arbitrary date. Currently 2451723.28495, corresponding
// to the current test initial TLE file.
void resetClock(const char* clockfile) {

  double DEFAULT_TIME = 2451723.28495;
  writeClock(clockfile, DEFAULT_TIME);
  return;

}


// Increment current time by dt.
void tickClock(const char* clockfile, double dt) {

  writeClock(clockfile, readClock(clockfile) + dt);
  return;

}



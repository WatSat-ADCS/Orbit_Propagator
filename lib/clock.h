#ifndef CLOCK_H
#define CLOCK_H

/*
  HEADER
  Clock for Orbit propagator simulation

  Copyright (c) 2015 WatSat-ADCS
  Licensed under the MIT license.

  authors: Jason Pye (j2pye@uwaterloo.ca)

  Change log:
  2015-12-02 (JP) - Initial release
*/

double readClock(const char* clockfile);
// Returns current time from clock file.

void writeClock(const char* clockfile, double new_jdate);
// Write new_jdate to clock file.

void resetClock(const char* clockfile);
// Reset clock to some arbitrary date. Currently 2451723.28495, corresponding
// to the current test initial TLE file.

void tickClock(const char* clockfile, double dt);
// Increment current time by dt.

#endif

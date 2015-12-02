#ifndef SATPOSITION_H
#define SATPOSITION_H

/*
  HEADER
  Determines Satellite position for Orbit propagator simulation

  Copyright (c) 2015 WatSat-ADCS
  Licensed under the MIT license.

  authors: Jason Pye (j2pye@uwaterloo.ca)

  Change log:
  2015-12-02 (JP) - Initial release
*/

void readTLE(const char* tlefile, char* tle1, char* tle2);
// Reads two-line elements from tlefile and puts them in tle1 and tle2.

void writeTLE(const char* tlefile, const char* tle1, const char* tle2);
// Writes the two-line element (tle1,tle2) to the tlefile.

void resetTLE(const char* tlefile, const char* init_tlefile);
// Resets TLE in tlefile to that in init_tlefile.

void currentOrbitState(const char* tlefile, double* position, double* velocity);
// Propagates and updates the state estimate from tlefile to the current time
// and places the new position and velocity in the corresponding variables.

#endif

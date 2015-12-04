#ifndef SATPOSITION_H
#define SATPOSITION_H

/*
  HEADER
  Determines Satellite position for Orbit propagator simulation

  Copyright (c) 2015 WatSat-ADCS
  Licensed under the MIT license.

  authors: Jason Pye (j2pye@uwaterloo.ca)

  Change log:
  2015-12-03 (JP) - Initial release
*/


void readRV(const char* rvfile, double* rvtime, double posn[3], double vel[3]);
// Reads Time, Position, Velocity from rvfile and puts them in rvtime, posn, vel.

void writeRV(const char* rvfile, double rvtime, double posn[3], double vel[3]);
// Writes the Time, Position, Velocity in rvtime, posn, vel to rvfile.

void resetRV(const char* rvfile, const char* init_tlefile);
// Resets the Time, Position, Velocity in rvfile with data
// corresponding to the TLE data in init_tlefile.

void currentOrbitState(const char* rvfile, const char* init_tlefile, const char* clockfile, double* rvtime, double posn[3], double vel[3]);
// Propagates and updates the state estimate from rvfile to the current time
// and places the new time, position, velocity in the corresponding variables.

#endif

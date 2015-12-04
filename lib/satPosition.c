/*
  Determines Satellite position for Orbit propagator simulation

  Copyright (c) 2015 WatSat-ADCS
  Licensed under the MIT license.

  authors: Jason Pye (j2pye@uwaterloo.ca)

  Change log:
  2015-12-03 (JP) - Initial release
*/

#include <stdio.h>

#include "clock.h"

#include "sgp4unit.h"
#include "sgp4io.h"
#include "sgp4ext.h"


// Reads Time, Position, Velocity from rvfile and puts them in rvtime, posn, vel.
void readRV(const char* rvfile, double* rvtime, double posn[3], double vel[3]) {

  FILE *fptr;
  fptr = fopen( rvfile, "r" );
  if (fptr == NULL) {
    printf("Error opening file: %s\n", rvfile);
    return;
  }

  fscanf(fptr, "%lf", rvtime);
  int i;
  for (i = 0; i < 3; i++)
    fscanf(fptr, "%lf", &posn[i]);
  for (i = 0; i < 3; i++)
    fscanf(fptr, "%lf", &vel[i]);

  fclose(fptr);
  return;

}


// Writes the Position, Velocity in posn, vel to rvfile.
void writeRV(const char* rvfile, double rvtime, double posn[3], double vel[3]) {

  FILE *fptr;
  fptr = fopen( rvfile, "w" );
  if (fptr == NULL) {
    printf("Error opening file: %s\n", rvfile);
    return;
  }

  fprintf(fptr, "%.5lf ", rvtime);
  int i;
  for (i = 0; i < 3; i++)
    fprintf(fptr, "%.5lf ", posn[i]);
  for (i = 0; i < 3; i++)
    fprintf(fptr, "%.5lf ", vel[i]);

  fclose(fptr);
  return;

}


// Resets the Position, Velocity in rvfile with Position, Velocity
// corresponding to TLE in tlefile.
void resetRV(const char* rvfile, const char* init_tlefile) {

  // Read data from TLE file
  FILE *tle_fptr;
  tle_fptr = fopen( init_tlefile, "r" );
  if (tle_fptr == NULL) {
    printf("Error opening file: %s\n", init_tlefile);
    return;
  }

  char tle_line1[130], tle_line2[130];
  fgets(tle_line1, 130, tle_fptr);
  fgets(tle_line2, 130, tle_fptr);

  fclose(tle_fptr);


  // Convert TLE data to Time, Position, Velocity data
  const gravconsttype GRAV_CONSTS = wgs72; // Apparently the twoline2rv function needs this.
  elsetrec satrecord; // This too: and object containing the satellite information.
  double startmfe, stopmfe, deltamin;

  twoline2rv(tle_line1, tle_line2, 'v', 'm', 'i', GRAV_CONSTS, startmfe, stopmfe, deltamin, satrecord);
  // Magic inputs... really sketchy and something to come back to.


  // Write Time, Position, Velocity data to rvfile
  double rvtime, posn[3], vel[3];

  sgp4(GRAV_CONSTS, satrecord, 0.0, posn, vel); // Apparently this is the only way to extract the posn/vel data :S
  rvtime = satrecord.jdsatepoch;

  writeRV(rvfile, rvtime, posn, vel);

}


// Propagates and updates the state estimate from tlefile to the current time
// and places the new position and velocity in the corresponding variables.
void currentOrbitState(const char* rvfile, const char* init_tlefile, const char* clockfile, double* rvtime, double posn[3], double vel[3]) {

  const gravconsttype GRAV_CONSTS = wgs72;
  // Check whether these are the right ones to hard-code.

  elsetrec satrecord;
  // This is an object which contains the satellite info.


  // Initialise satrecord directly from TLE file...
  // ... trust me, it's cleaner than using sgp4init()
  FILE *tle_fptr;
  tle_fptr = fopen( init_tlefile, "r" );
  if (tle_fptr == NULL) {
    printf("Error opening file: %s\n", init_tlefile);
    return;
  }

  char tle_line1[130], tle_line2[130];
  fgets(tle_line1, 130, tle_fptr);
  fgets(tle_line2, 130, tle_fptr);

  fclose(tle_fptr);

  double startmfe, stopmfe, deltamin;

  // The twoline2rv() function initialises the satrecord object

  twoline2rv(tle_line1, tle_line2, 'v', 'm', 'i', GRAV_CONSTS, startmfe, stopmfe, deltamin, satrecord);
  // Again, check whether these are the inputs we want.


  // Propagate to new state
  *rvtime = readClock(clockfile);
  sgp4(GRAV_CONSTS, satrecord, 1440.0*(*rvtime - satrecord.jdsatepoch), posn, vel);

  // rvtime, posn, vel will be stored in the pointers as outputs, but we'll write to file as well.
  writeRV(rvfile, *rvtime, posn, vel);

}

/*
  Orbit Propagator Simulation

  Copyright (c) 2015 WatSat-ADCS
  Licensed under the MIT license.

  authors: Jason Pye (j2pye@uwaterloo.ca)

  Change log:
  2015-12-04 (JP) - Initial release
*/

#include <stdio.h>

#include "satPosition.h"
#include "clock.h"

#include "sgp4ext.h" // For invjday(...)


const char clock_filename[] = "dat/jdate.txt";
const char inittime_filename[] = "dat/init_time.txt";
const char rv_filename[] = "dat/rv_est.txt";
const char initTLE_filename[] = "dat/tle_init.txt";

const char csvout_filename[] = "simulation_validation/simulation_data.csv";


int main() {

  // Initialise
  resetClock(clock_filename, inittime_filename);
  resetRV(rv_filename, initTLE_filename);

  // Prepare output file
  FILE *csvptr;
  csvptr = fopen( csvout_filename, "w" );
  if ( csvptr == NULL ) {
    printf("There was an error opening file: %s\n", csvout_filename);
    return -1;
  }

  fprintf(csvptr, "YEAR,MONTH,DAY,HOUR,MINUTE,SECOND,JULIAN_DATE,POSN_X,POSN_Y,POSN_Z,VEL_X,VEL_Y,VEL_Z\n");


  // Simulation

  double init_time = readClock(clock_filename);
  double total_time = 0/1440.0;
//  double total_time = 1*(365); // One year in jdate
  double incr_time = 1/1440.0; // One minute in jdate

  double rvtime, posn[3], vel[3];
  int year, mon, day, hr, minute;
  double sec;

  while ( rvtime - init_time < total_time ) {

    // Gets current orbit state and stores in rvtime, posn, vel
    currentOrbitState(rv_filename, initTLE_filename, clock_filename, &rvtime, posn, vel);

    // Write data to output file
    invjday(rvtime, year, mon, day, hr, minute, sec);
    fprintf(csvptr, "%d,%d,%d,%d,%d,%.5lf", year, mon, day, hr, minute, sec);
    fprintf(csvptr, ",%.5lf", rvtime);
    int i;
    for (i = 0; i < 3; i++)
      fprintf(csvptr, ",%.5lf", posn[i]);
    for (i = 0; i < 3; i++)
      fprintf(csvptr, ",%.5lf", vel[i]);
    fprintf(csvptr, "\n");

    // Ticks clock
    tickClock(clock_filename, incr_time);

  }

  fclose(csvptr);

  return 0;
}

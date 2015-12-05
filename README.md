# Orbit_Propagator
Candidate on-board orbit propagator and simulation thereof.

To run the simulation, put the initial tle file in dat/ and name it tle_init.txt.
Then, from the Orbit\ Propagator/ directory, type
	make
	make run
The output of the simulation will be stored in simulation_validation/simulation_data.csv
The simulation_validation folder contains the script convert_simulation_data.m which will convert the data in simulation_data.csv from ECI (TEME) coordinates to LLA (Lat/Lon/Alt). (Note: this transformation first converts the ECI to ECEF and then from ECEF to LLA.)




OUTLINE
=======

Clock fxns: just because I don't know how to interface with the on-board clock yet...
- readClock()
- writeClock(new_jdate)
- resetClock()
- tickClock(dt)

Propagator fxns: interface with SGP4 package and I/O
- readTLE(filename)
- writeRV(filename, RV)
- writeCOE(filename, COE)
- currentOrbitState()
	- uses the SGP4 package


Data files: storage of date, initial state (in TLE format), current estimate of state (in RV and COE format)
- jdate.txt
- tle_init.txt
- rv_est.txt
- coe_est.txt


================================================================================
Directory structure:

lib/
  propagator.so (include my satPosition interface as well as necessary SGP4 object files)
  clock.so (keep this separate since will work differently on satellite)
  SGP4/ (include this in any distributions as well)
  tests/
  makefile (remake library if anything in subdirs changes)

.
  propagator_simulation.c

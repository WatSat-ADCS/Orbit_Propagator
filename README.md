# Orbit_Propagator
Candidate on-board orbit propagator and simulation thereof.



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

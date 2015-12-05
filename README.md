# Orbit_Propagator
Candidate on-board orbit propagator and simulation thereof.

The custom libraries needed to run the simulation are libclock.so to interface with a dummy clock and libsatPosition.so to interface with the SGP4 code. To prepare these libraries, cd to the lib/ directory and run "make" and "make check".

The simulation requires a TLE file in dat/ called tle_init.txt in order to acquire the initial state of the satellite for the simulation. The init_tle/ folder contains a MATLAB script capable of converting LAT/LON/ALT data to a TLE file, as well as a test program in init_tle/tests/ to check whether the TLE file is valid for the simulation.

To run the simulation, put the initial tle file in dat/ and name it tle_init.txt.
Then, from the Orbit\ Propagator/ directory, type
	make
	make run
The output of the simulation will be stored in simulation_validation/simulation_data.csv
The simulation_validation folder contains the script convert_simulation_data.m which will convert the data in simulation_data.csv from ECI (TEME) coordinates to LLA (Lat/Lon/Alt). (Note: this transformation first converts the ECI to ECEF and then from ECEF to LLA.)
The simulation data can then be validated against the information contained in:
	simulation_validation/WatSat1\ LLA\ Position\ -\ Sept2015-Aug2016_600km.xlsx


This repo contains many programs not required on board the satellite for the ADCS software nor required for the Control Simulation. All that is required for these are the files in dat/ as well as the libraries in lib/ (though they will have to be altered for different clock implementations).

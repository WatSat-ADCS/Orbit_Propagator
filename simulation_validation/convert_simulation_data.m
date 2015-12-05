% Program to convert the data output from the Orbit Propagator simulation
% from ECI (TEME) coordinates to LAT/LON/ALT so it can be validated against
% the STK data.
% Currently reads input data from sim_datfile and outputs to converted_sim_datfile
%===================================================================================================================
%
% Copyright (c) 2015 WatSat-ADCS
% Licensed under the MIT license.
%
% authors: Jason Pye (j2pye@uwaterloo.ca)
%
% Change log:
% 2015-12-04 (JP) - Initial release
%
%===================================================================================================================

clear all
close all

addpath ./ECI2ECEF % Include the ECI2ECEF function
addpath ./csvwrite_with_headers % Include the csvwrite_with_headers function

% I/O Data files
sim_datfile = 'simulation_data.csv';
converted_sim_datfile = 'converted_simulation_data.csv';

% Read in and store simulation data in appropriate variables.
% There is a nicer way of doing this using structures...
% ... should do that at some point.
csv_data = csvread(sim_datfile,1,0);

YEAR = csv_data(:,1);
MONTH = csv_data(:,2);
DAY = csv_data(:,3);
HOUR = csv_data(:,4);
MINUTE = csv_data(:,5);
SECOND = csv_data(:,6);

JDATE = csv_data(:,7);

POSN_X = csv_data(:,8);
POSN_Y = csv_data(:,9);
POSN_Z = csv_data(:,10);

VEL_X = csv_data(:,11);
VEL_Y = csv_data(:,12);
VEL_Z = csv_data(:,13);


posn_eci = [ POSN_X'; POSN_Y'; POSN_Z' ];
vel_eci = [ VEL_X'; VEL_Y'; VEL_Z' ];
accel_eci = zeros(size(posn_eci));


% Convert ECI to ECEF
[ posn_ecef, vel_ecef, accel_ecef ] = ECItoECEF( JDATE, posn_eci, vel_eci, accel_eci );


% Convert ECEF to LLA

num_rows = numel(POSN_X);
LAT = zeros([num_rows,1]);
LON = zeros([num_rows,1]);
ALT = zeros([num_rows,1]);

for ix = 1:num_rows
  [LAT(ix),LON(ix),ALT(ix)] = ecef2lla( posn_ecef(1,ix), posn_ecef(2,ix), posn_ecef(3,ix) );
end

% Convert units to radians and kilometres
LAT = LAT*180/pi;
LON = LON*180/pi;
ALT = ALT/1000;


% Write output

csvwrite_with_headers(converted_sim_datfile, [YEAR,MONTH,DAY,HOUR,MINUTE,SECOND, LAT, LON, ALT], {'YEAR', 'MONTH', 'DAY', 'HOUR', 'MINUTE', 'SECOND', 'LAT (deg)', 'LON (deg)', 'ALT (km)'});

rmpath ./ECI2ECEF
rmpath ./csvwrite_with_headers

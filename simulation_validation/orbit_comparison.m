% Program to convert the data output from the Orbit Propagator simulation
% from ECI (TEME) coordinates to LAT/LON/ALT so it can be validated against
% the STK data.
% Currently reads input data from sim_datfile and outputs to converted_sim_datfile
% Program that compares the simulated orbit stored in
%===================================================================================================================
%
% Copyright (c) 2015 WatSat-ADCS
% Licensed under the MIT license.
%
% authors: Jason Pye (j2pye@uwaterloo.ca)
%
% Change log:
% 2015-12-07 (JP) - Initial release
%
%===================================================================================================================

clear all;
close all;

% Run the data conversion script.
convert_simulation_data;
clear all;

% Data files
simulated_datfile = 'converted_simulation_data.csv';
verification_datfile = 'WatSat_LLA_Position_600km.mat';

% Read in data
sim_data = csvread(simulated_datfile, 1,0);
ver_data = load(verification_datfile);

sim_jdate = sim_data(:,7);
sim_lat = sim_data(:,8);
sim_lon = sim_data(:,9);
sim_alt = sim_data(:,10);

num_simdat = size(sim_jdate,1);
ver_utc = ver_data.data(1:num_simdat,1);
ver_lat = ver_data.data(1:num_simdat,2);
ver_lon = ver_data.data(1:num_simdat,3);
ver_alt = ver_data.data(1:num_simdat,4);

ver_latrate = ver_data.data(1:num_simdat,5);
ver_lonrate = ver_data.data(1:num_simdat,6);
ver_altrate = ver_data.data(1:num_simdat,7);


% Plot data
figure(1)

subplot(3,1,1)
plot(sim_jdate, sim_lat,'b-', 'Linewidth',2)
hold on;
plot(sim_jdate, ver_lat,'r-', 'Linewidth',2)
ylabel('Latitude (deg)')
xlabel('JDate / UTC Code')
legend('Simulation Data', 'Verification Data');

subplot(3,1,2)
plot(sim_jdate, mod(sim_lon, 360),'b-', 'Linewidth',2)
hold on;
plot(sim_jdate, mod(ver_lon, 360),'r-', 'Linewidth',2)
ylabel('Longitude (deg)')
xlabel('JDate / UTC Code')
legend('Simulation Data', 'Verification Data');

subplot(3,1,3)
plot(sim_jdate, sim_alt,'b-', 'Linewidth',2)
hold on;
plot(sim_jdate, ver_alt,'r-', 'Linewidth',2)
ylabel('Altitude (km)')
xlabel('JDate / UTC Code')
legend('Simulation Data', 'Verification Data');


figure(2)

subplot(3,1,1)
plot(sim_jdate, sim_lat - ver_lat,'g-', 'Linewidth',2)
ylabel('Latitude Error (deg)')
xlabel('JDate / UTC Code')
title('LLA Error')

subplot(3,1,2)
plot(sim_jdate, mod(sim_lon - ver_lon, 360),'g-', 'Linewidth',2)
ylabel('Longitude Error (deg)')
xlabel('JDate / UTC Code')

subplot(3,1,3)
plot(sim_jdate, sim_alt - ver_lat,'g-', 'Linewidth',2)
ylabel('Altitude Error (km)')
xlabel('JDate / UTC Code')



figure(3)

R_earth = 6371;
lat_base = 0:0.1:pi;
lon_base = 0:0.1:2*pi;
earth_lats = kron( lat_base, ones(size(lon_base)) );
earth_lons = kron( ones(size(lat_base)), lon_base );
plot3( R_earth*sin(earth_lats).*cos(earth_lons), R_earth*sin(earth_lats).*sin(earth_lons), R_earth*cos(earth_lats), 'k-' )
hold on;

sim_lat_rad = (90 - sim_lat) * (pi/180);
sim_lon_rad = sim_lon * (pi/180);
ver_lat_rad = (90 - ver_lat) * (pi/180);
ver_lon_rad = ver_lon * (pi/180);

sim_X = (sim_alt+R_earth).*sin(sim_lat_rad).*cos(sim_lon_rad);
sim_Y = (sim_alt+R_earth).*sin(sim_lat_rad).*sin(sim_lon_rad);
sim_Z = (sim_alt+R_earth).*cos(sim_lat_rad);
plot3( sim_X, sim_Y, sim_Z, 'b-');

ver_X = (ver_alt+R_earth).*sin(ver_lat_rad).*cos(ver_lon_rad);
ver_Y = (ver_alt+R_earth).*sin(ver_lat_rad).*sin(ver_lon_rad);
ver_Z = (ver_alt+R_earth).*cos(ver_lat_rad);
plot3( ver_X, ver_Y, ver_Z, 'r-');



figure(4)

subplot(3,1,1)
plot(sim_jdate, sim_X - ver_X,'g-', 'Linewidth',2)
ylabel('X Position (km)')
xlabel('JDate / UTC Code')
title('Position Error (km)')

subplot(3,1,2)
plot(sim_jdate, sim_Y - ver_Y,'g-', 'Linewidth',2)
ylabel('Y Position (km)')
xlabel('JDate / UTC Code')

subplot(3,1,3)
plot(sim_jdate, sim_Z - ver_Z,'g-', 'Linewidth',2)
ylabel('Z Position (km)')
xlabel('JDate / UTC Code')


overall_error = sum( (sim_X - ver_X).^2 + (sim_Y - ver_Y).^2 + (sim_Z - ver_Z).^2 ) / numel(sim_X);



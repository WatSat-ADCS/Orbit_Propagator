% A script which takes LAT/LON/ALT data (all hard-coded below for now) and generates a TLE file called tle_file.
% At the moment this is a complete mess because I'm just blindly following the csystems.m script
% in init_tle/csystems which is not terribly well documented.
%===================================================================================================================
%
% Copyright (c) 2015 WatSat-ADCS
% Licensed under the MIT license.
%
% authors: Jason Pye (j2pye@uwaterloo.ca)
%
% Change log:
% 2015-12-04 (JP) - Initial release
% 2015-12-07 (JP) - Updated initial conditions
%
%===================================================================================================================

clear all
close all

format long

addpath ./csystems

global dtr rtd mu inutate omega
om_constants;
readleap;
inutate = 1;


%%%%% New TLE file
tle_file = 'tle_init.txt';



%%%%% LLA data
utc_year = 2015;
utc_month = 09;
utc_day = 01;
utc_hour = 16;
utc_minute = 01;
utc_sec = 00;

lat = 3.705 * (pi/180); % radians
lon = 138.732 * (pi/180); % radians
alt = 600.091606; % km

% Second set to calculate velocity
utc_year2 = 2015;
utc_month2 = 09;
utc_day2 = 01;
utc_hour2 = 16;
utc_minute2 = 01;
utc_sec2 = 01;

lat2 = 3.766824 * (pi/180); % radians
lon2 = 138.71915 * (pi/180); % radians
alt2 = 600.094559;




%%%%% Much of this is following the csystems.m script...
%%%%% ... I don't really understand what this does, so I
%%%%% apologise for the lack of comments.


%%%%% UTC to JD
jdate = julian(utc_month, utc_day, utc_year);
jdate = jdate + utc_hour/24.0 + utc_minute/1440.0 + utc_sec/86400.0;

jdate2 = julian(utc_month2, utc_day2, utc_year2);
jdate2 = jdate2 + utc_hour2/24.0 + utc_minute2/1440.0 + utc_sec2/86400.0;

%%%%% JD to Greenwich apparent sidereal time (GAST)
gast = gast4(fix(jdate), jdate - fix(jdate), 1);
gast2 = gast4(fix(jdate2), jdate2 - fix(jdate2), 1);

[month, day, iytle] = gdate(jdate);
jdate0 = julian(1, 0.0d0, iytle);
tledoy = jdate - jdate0;
[cdstr, utstr] = jd2str(jdate);
tledoy_string = num2str(tledoy, 12);
ci = strfind(tledoy_string, '.');




%%%%% LLA to ECI
posn_eci = lla2eci (gast, lat, lon, alt);
posn_eci_2 = lla2eci (gast2, lat2, lon2, alt2);
vel_eci = (posn_eci_2 - posn_eci) / ( 86400 *(jdate2-jdate) );

%%%%% ECI to TLE data
[eo, xno, xmo, xincl, omegao, xnodeo] = rv2tle(posn_eci, vel_eci);
coev = eci2orb2( mu, gast, omega, 0.0, posn_eci, vel_eci );




%%%%% Write TLE file

% Dummy TLE data
satnum = '00001';


if (iytle < 2000)
  tle_line1 = sprintf( '1 %sU XXXXXX   %2.2i%3.3i.%s -.00000000  00000-0 -00000-0 0  XXX', satnum, iytle-1900, fix(tledoy), tledoy_string(ci + 1:ci + 8) );
else
  tle_line1 = sprintf( '1 %sU XXXXXX   %2.2i%3.3i.%s -.00000000  00000-0 -00000-0 0  XXX', satnum, iytle-2000, fix(tledoy), tledoy_string(ci + 1:ci + 8) );
end

tle_line2 = sprintf( '2 %s %8.4f %08.4f %7.7i %08.4f %8.4f %11.8f00001', satnum, rtd * xincl, rtd * xnodeo, fix(eo * 1.0d7), rtd * omegao, rtd * xmo, xno );


% Checksums
tle1_ck = 0; tle2_ck = 0;

for ix = 1:length(tle_line1)
  if ( length(str2num( tle_line1(ix) )) == 1 )
    tle1_ck = tle1_ck + str2num( tle_line1(ix) );
  elseif ( tle_line1(ix) == '-' )
    tle1_ck = tle1_ck + 1;
  end
end

for ix = 1:length(tle_line2)
  if ( length(str2num( tle_line2(ix) )) == 1 )
    tle2_ck = tle2_ck + str2num( tle_line2(ix) );
  elseif ( tle_line2(ix) == '-' )
    tle2_ck = tle2_ck + 1;
  end
end

tle_line1 = [tle_line1, num2str( mod(tle1_ck,10) )];
tle_line2 = [tle_line2, num2str( mod(tle2_ck,10) )];


fileID = fopen(tle_file,'w');

fprintf(fileID, tle_line1);
fprintf(fileID, '\n');
fprintf(fileID, tle_line2);

fclose(fileID);


rmpath ./csystems

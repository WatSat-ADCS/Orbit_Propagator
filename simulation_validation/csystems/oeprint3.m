function oeprint3(mu, oev, ittype)

% print complete set of orbital elements

% input

%  oev(1)  = semimajor axis (kilometers)
%  oev(2)  = orbital eccentricity (non-dimensional)
%            (0 <= eccentricity < 1)
%  oev(3)  = orbital inclination (radians)
%            (0 <= inclination <= pi)
%  oev(4)  = argument of perigee (radians)
%            (0 <= argument of perigee <= 2 pi)
%  oev(5)  = right ascension of ascending node (radians)
%            (0 <= raan <= 2 pi)
%  oev(6)  = true anomaly (radians)
%            (0 <= true anomaly <= 2 pi)
%  oev(7)  = orbital period (seconds)
%  oev(8)  = argument of latitude (radians)
%            (0 <= argument of latitude <= 2 pi)
%  oev(9)  = east longitude of ascending node (radians)
%            (0 <= east longitude <= 2 pi)
%  oev(10) = specific orbital energy (kilometer^2/second^2)
%  oev(11) = flight path angle (radians)
%            (-0.5 pi <= fpa <= 0.5 pi)
%  oev(12) = right ascension (radians)
%            (-2 pi <= right ascension <= 2 pi)
%  oev(13) = declination (radians)
%            (-0.5 pi <= declination <= 0.5 pi)
%  oev(14) = geodetic latitude of subpoint (radians)
%            (-0.5 pi <= latitude <= 0.5 pi)
%  oev(15) = east longitude of subpoint (radians)
%            (-2 pi <= latitude <= 2 pi)
%  oev(16) = geodetic altitude (kilometers)
%  oev(17) = geocentric radius of perigee (kilometers)
%  oev(18) = geocentric radius of apogee (kilometers)
%  oev(19) = perigee velocity (kilometers/second)
%  oev(20) = apogee velocity (kilometers/second)
%  oev(21) = geodetic altitude of perigee (kilometers)
%  oev(22) = geodetic altitude of apogee (kilometers)
%  oev(23) = geodetic latitude of perigee (radians)
%            (-0.5 pi <= latitude <= 0.5 pi)
%  oev(24) = geodetic latitude of apogee (radians)
%            (-0.5 pi <= latitude <= 0.5 pi)
%  ittype  = time unit for orbital period
%            1 = minutes, 2 = hours, 3 = days

% Orbital Mechanics with MATLAB

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rtd = 180.0 / pi;

% unload orbital elements array

sma = oev(1);
ecc = oev(2);
inc = oev(3);
argper = oev(4);
raan = oev(5);
tanom = oev(6);
period = oev(7);
arglat = oev(8);
lan = oev(9);
energy = oev(10);
fpa = oev(11);
ras = oev(12);
dec = oev(13);
lat = oev(14);
elong = oev(15);
altitude = oev(16);
rperigee = oev(17);
rapogee = oev(18);
vperigee = oev(19);
vapogee = oev(20);
altper = oev(21);
altapo = oev(22);
latper = oev(23);
latapo = oev(24);

% print orbital elements

fprintf ('\n        sma (km)              eccentricity          inclination (deg)         argper (deg)');

fprintf ('\n %+16.14e  %+16.14e  %+16.14e  %+16.14e \n', sma, ecc, inc * rtd, argper * rtd);

if (sma > 0.0)
    
    period = 2.0d0 * pi * sma * sqrt(sma / mu);
    
    if (ittype == 1)
        
        fprintf ('\n       raan (deg)          true anomaly (deg)         arglat (deg)            period (min)');
        
        fprintf ('\n %+16.14e  %+16.14e  %+16.14e  %+16.14e \n', raan * rtd, tanom * rtd, arglat * rtd, period / 60.0);
        
    elseif (ittype == 2)
        
        fprintf ('\n       raan (deg)          true anomaly (deg)         arglat (deg)            period (hrs)');
        
        fprintf ('\n %+16.14e  %+16.14e  %+16.14e  %+16.14e \n', raan * rtd, tanom * rtd, arglat * rtd, period / 3600.0);
        
    else
        
        fprintf ('\n       raan (deg)          true anomaly (deg)         arglat (deg)            period (days)');
        
        fprintf ('\n %+16.14e  %+16.14e  %+16.14e  %+16.14e \n', raan * rtd, tanom * rtd, arglat * rtd, period / 86400.0);
        
    end
    
else
    
    fprintf ('\n       raan (deg)          true anomaly (deg)         arglat (deg)');
    
    fprintf ('\n %+16.14e  %+16.14e  %+16.14e \n', raan * rtd, tanom * rtd, arglat * rtd);
    
end

fprintf ('\n        lan (deg)          energy (km^2/sec^2)           fpa (deg)             rasc (deg)');

fprintf ('\n %+16.14e  %+16.14e  %+16.14e  %+16.14e \n', lan * rtd, energy, fpa * rtd, ras * rtd);

fprintf ('\n    declination (deg)        latitude (deg)        east longitude (deg)       altitude (km)');

fprintf ('\n %+16.14e  %+16.14e  %+16.14e  %+16.14e \n', dec * rtd, lat * rtd, elong * rtd, altitude);

if (sma > 0.0)
    
    % elliptical orbit
    
    fprintf ('\n      r-perigee (km)          r-apogee (km)           v-perigee (kps)         v-apogee (kps)');
    
    fprintf ('\n %+16.14e  %+16.14e  %+16.14e  %+16.14e \n', rperigee, rapogee, vperigee, vapogee);
    
    fprintf ('\n      h-perigee (km)          h-apogee (km)          lat-perigee (deg)       lat-apogee (deg)');
    
    fprintf ('\n %+16.14e  %+16.14e  %+16.14e  %+16.14e \n', altper, altapo, latper * rtd, latapo * rtd);
    
else
    
    % hyperbolic orbit
    
    fprintf ('\n      r-perigee (km)         v-perigee (kps)          h-perigee (km)        lat-perigee (deg)');
    
    fprintf ('\n %+16.14e  %+16.14e  %+16.14e  %+16.14e \n', rperigee, vperigee, altper, latper * rtd);
    
    [rsc, vsc] = orb2eci(mu, oev);
    
    [c3, rla, dla] = rv2hyper (mu, rsc, vsc);
    
    fprintf ('\n     C3 (km^2/sec^2)         rasc-asy (deg)           decl-asy (deg)');
    
    fprintf ('\n %+16.14e  %+16.14e  %+16.14e \n', c3, rla * rtd, dla * rtd);
    
    ta_infinity = acos(-1.0 / oev(2));
    
    vinfinity = sqrt(-mu / oev(1));
    
    fprintf ('\n    ta-infinity (deg)       v-infinity (kps)');
    
    fprintf ('\n %+16.14e  %+16.14e \n', ta_infinity * rtd, vinfinity);
    
end




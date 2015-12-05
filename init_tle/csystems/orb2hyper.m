function [shat, rasc_asy, decl_asy] = orb2hyper(oev)

% this function converts classical orbital elements
% of a hyperbolic orbit to asymptote coordinates

% input

%  oev(1) = semimajor axis (kilometers)
%  oev(2) = orbital eccentricity (non-dimensional)
%           (0 <= eccentricity < 1)
%  oev(3) = orbital inclination (radians)
%           (0 <= inclination <= pi)
%  oev(4) = argument of perigee (radians)
%           (0 <= argument of perigee <= 2 pi)
%  oev(5) = right ascension of ascending node (radians)
%           (0 <= raan <= 2 pi)
%  oev(6) = true anomaly (radians)
%           (0 <= true anomaly <= 2 pi)

% output

%  shat     = asymptote unit vector
%  rasc_asy = right ascension of asymptote (radians)
%  decl_asy = declination of asymptote (radians)

% Orbital Mechanics with MATLAB

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% extract orbital elements

ecc = oev(2);

inc = oev(3);

argper = oev(4);

raan = oev(5);

tanom = oev(6);

% argument of latitude (radians)

arglat = mod(argper + tanom, 2.0 * pi);

if (ecc < 1.0)
   fprintf ('\nfunction orb2hyper - orbit is not hyperbolic\n');
   return
end

% compute components of unit asymptote vector

shat(1) = cos(raan) * cos(arglat) - sin(raan) * sin(arglat) * cos(inc);

shat(2) = sin(raan) * cos(arglat) + cos(raan) * sin(arglat) * cos(inc);

shat(3) = sin(arglat) * sin(inc);

% true anomaly at infinity (radians)

tanomi = acos(-1.0 / ecc);

% argument of latitude at infinity (radians)

arglati = mod(argper + tanomi, 2.0 * pi);

% declination of asymptote (radians)

decl_asy = asin(sin(arglati) * sin(inc));

% right ascension of asymptote (radians)

rasc_asy = mod(raan + atan3(tan(decl_asy) / tan(inc), cos(arglati) ...
    / cos(decl_asy)), 2.0 * pi);



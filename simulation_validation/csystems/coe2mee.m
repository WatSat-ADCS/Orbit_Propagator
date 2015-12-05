function mee = coe2mee(mu, coe)

% convert classical orbital elements to modified equinoctial orbital elements

% input

%  mu     = gravitational constant (km**3/sec**2)
%  coe(1) = semimajor axis (kilometers)
%  coe(2) = orbital eccentricity (non-dimensional)
%           (0 <= eccentricity < 1)
%  coe(3) = orbital inclination (radians)
%           (0 <= inclination <= pi)
%  coe(4) = argument of perigee (radians)
%           (0 <= argument of perigee <= 2 pi)
%  coe(5) = right ascension of ascending node (radians)
%           (0 <= raan <= 2 pi)
%  coe(6) = true anomaly (radians)
%           (0 <= true anomaly <= 2 pi)

% output

%  mee(1) = semiparameter (kilometers)
%  mee(2) = f equinoctial element
%  mee(3) = g equinoctial element
%  mee(4) = h equinoctial element
%  mee(5) = k equinoctial element
%  mee(6) = true longitude (radians)

% Orbital Mechanics with MATLAB

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% compute eci state vector

[reci, veci] = orb2eci(mu, coe);

% compute modified equinoctial elements

mee = eci2mee(mu, reci, veci);
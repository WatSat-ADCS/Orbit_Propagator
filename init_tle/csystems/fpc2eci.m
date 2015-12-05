function [reci, veci] = fpc2eci(gst, fpc)

% convert relative flight path coordinates to inertial state vector

% input

%  gst    = greenwich apparent sidereal time (radians)
%  fpc(1) = east longitude (radians)
%  fpc(2) = geocentric declination (radians)
%  fpc(3) = relative flight path angle (radians)
%  fpc(4) = relative azimuth (radians)
%  fpc(5) = position magnitude (kilometers)
%  fpc(6) = relative velocity magnitude (kilometers/second)

% output

%  reci = inertial position vector (kilometers)
%  veci = inertial velocity vector (kilometers/second)

% Orbital Mechanics with MATLAB

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% compute ecf state vector

[recf, vecf] = fpc2ecf(fpc);

% compute eci state vector

[reci, veci] = ecf2eci(gst, recf, vecf);

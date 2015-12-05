function fpc = rv2fpc (r, v)

% transform from cartesian coordinates
% to flight path coordinates

% input

%  r = eci or ecf position vector
%  v = eci or ecf velocity vector

% output

%  fpc(1) = geocentric right ascension or east longitude (radians)
%  fpc(2) = geocentric declination (radians)
%  fpc(3) = flight path angle (radians)
%  fpc(4) = azimuth (radians)
%  fpc(5) = position magnitude (kilometers)
%  fpc(6) = velocity magnitude (kilometers/second)

% NOTE: if ECI input, output is inertial
%       if ECF input, output is Earth relative

% Orbital Mechanics with MATLAB

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% position and velocity magnitudes

rmag = norm(r);

vmag = norm(v);

% geocentric declination (radians)

decl = asin(r(3) / rmag);

% flight path angle (radians)

rdotv = dot(r, v);

fpa = asin(rdotv / (rmag * vmag));

% east longitude or right ascension (radians)

alpha = atan3(r(2), r(1));

% azimuth angle (radians)

azimuth = atan3(rmag * (r(1) * v(2) - r(2) * v(1)), ...
          r(2) * (r(2) * v(3) - r(3) * v(2)) - r(1) * ...
          (r(3) * v(1) - r(1) * v(3)));

% load flight path coordinates array

fpc(1) = alpha;
fpc(2) = decl;
fpc(3) = fpa;
fpc(4) = azimuth;
fpc(5) = rmag;
fpc(6) = vmag;

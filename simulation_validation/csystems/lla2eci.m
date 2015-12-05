function reci = lla2eci (gast, lat, long, alt)

% convert geodetic altitude, latitude and longitude to eci position vector
   
% input

%  gast = apparent sidereal time (radians)
%         (0 <= gast <= 2 pi)
%  lat  = geodetic latitude (radians)
%  long = geographic longitude (radians)
%  alt  = geodetic altitude (kilometers)

% output

%  reci = eci position vector (kilometers)

% Orbital Mechanics with MATLAB

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% compute geocentric distance and declination

[rmag, decl] = geodet4 (lat, alt);

% compute right ascension (radians)

rasc = mod(gast + long, 2.0 * pi);

% compute eci position vector (kilometers)

reci(1) = rmag * cos(decl) * cos(rasc);

reci(2) = rmag * cos(decl) * sin(rasc);

reci(3) = rmag * sin(decl);


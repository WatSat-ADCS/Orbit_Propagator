function oev = eci2orb2 (mu, gst0, omega, ut, r, v)

% convert eci state vector to complete set of classical orbital elements

% input

%  mu    = Earth gravitational constant (km^2/sec^3)
%  gst0  = Greenwich sidereal time at 0 hours UTC (radians)
%  omega = Earth sidereal rotation rate (radians/second)
%  ut    = Universal Coordinated Time (seconds)
%          (0 <= ut <= 86400)
%  r     = eci position vector (kilometers)
%  v     = eci velocity vector (kilometers/second)

% output

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

% Orbital Mechanics with MATLAB

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pi2 = 2.0 * pi;

% position and velocity magnitude

rmag = norm(r);

vmag = norm(v);

% position and velocity unit vectors

rhat = r / norm(r);

vhat = v / vmag;

% angular momentum vectors

hv = cross(r, v);

hhat = hv / norm(hv);

% eccentricity vector

vtmp = v / mu;

ecc = cross(vtmp, hv);

ecc = ecc - rhat;

% semimajor axis

sma = 1.0 / (2.0 / rmag - vmag^2 / mu);

% keplerian period (seconds)

if (sma > 0.0)
    
    period = pi2 * sqrt((sma * sma * sma) / mu);
    
else
    
    period = 0.0;
    
end

p = hhat(1) / (1.0 + hhat(3));

q = -hhat(2) / (1.0 + hhat(3));

const1 = 1.0 / (1.0 + p^2 + q^2);

fhat(1) = const1 * (1.0 - p^2 + q^2);

fhat(2) = const1 * 2.0 * p * q;

fhat(3) = -const1 * 2.0 * p;

ghat(1) = const1 * 2.0 * p * q;

ghat(2) = const1 * (1.0 + p^2 - q^2);

ghat(3) = const1 * 2.0 * q;

h = dot(ecc, ghat);

xk = dot(ecc, fhat);

x1 = dot(r, fhat);

y1 = dot(r, ghat);

% orbital eccentricity

eccm = sqrt(h * h + xk * xk);

% orbital inclination (radians)

inc = 2.0 * atan(sqrt(p * p + q * q));

% true longitude

xlambdat = atan3(y1, x1);

% compute raan and lan (radians)

if (inc > 0.0000000001)
    
    % check for equatorial orbit
    
    raan = atan3(p, q);
    
    xlan = mod(raan - (gst0 + omega * ut), 2.0 * pi);
    
else
    
    raan = 0.0;
    
    xlan = mod(gst0 + omega * ut, 2.0 * pi);
    
end

% check for circular orbit

if (eccm > 0.0000000001)
    
    argper = mod(atan3(h, xk) - raan, pi2);
    
else
    
    argper = 0.0;
    
end

% true anomaly (radians)

tanom = mod(xlambdat - raan - argper, pi2);

% east longitude of subpoint (radians)

a = mod(gst0 + omega * ut, pi2);

bx = sin(a);

cx = cos(a);

c1 = cx * r(1) + bx * r(2);

c2 = cx * r(2) - bx * r(1);

elong = atan3(c2, c1);

% specific orbital energy (km^2/sec^2)

energy = 0.5 * vmag * vmag - mu / rmag;

% radius of perigee and apogee

rperigee = sma * (1.0 - eccm);

rapogee = sma * (1.0 + eccm);

% velocity of perigee and apogee

vperigee = sqrt(2.0 * mu * rapogee / (rperigee * (rapogee + rperigee)));

vapogee = sqrt(2.0 * mu * rperigee / (rapogee * (rapogee + rperigee)));

% geocentric declination of perigee

decper = asin(sin(inc) * sin(argper));

% geodetic altitude and latitude of perigee

[altper, xlatper] = geodet1(rperigee, decper);

% geocentric declination of apogee

decapo = asin(sin(inc) * sin(pi + argper));

% geodetic altitude and latitude of apogee

[altapo, xlatapo] = geodet1(rapogee, decapo);

rdotv = dot(r, v);

% flight path angle (radians)

fpa = asin(rdotv / rmag / vmag);

% geocentric declination of subpoint (radians)

dec = asin(r(3) / rmag);

% geodetic altitude and latitude of subpoint

[alt, xlat] = geodet1(rmag, dec);

% right ascension of spacecraft (radians)

ras = atan3(r(2), r(1));

oev(1) = sma;
oev(2) = eccm;
oev(3) = inc;
oev(4) = argper;
oev(5) = raan;
oev(6) = tanom;
oev(7) = period;
oev(8) = mod(tanom + argper, 2.0 * pi);
oev(9) = xlan;
oev(10) = energy;
oev(11) = fpa;
oev(12) = ras;
oev(13) = dec;
oev(14) = xlat;
oev(15) = elong;
oev(16) = alt;
oev(17) = rperigee;
oev(18) = rapogee;
oev(19) = vperigee;
oev(20) = vapogee;
oev(21) = altper;
oev(22) = altapo;
oev(23) = xlatper;
oev(24) = xlatapo;





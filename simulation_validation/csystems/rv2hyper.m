function [c3, rla, dla] = rv2hyper (mu, rsc, vsc)

% convert position and velocity vectors to
% hyperbolic c3, rla and dla

% input

%  mu   = gravitational constant (km**3/sec**2)
%  rsc  = spacecraft position vector (kilometers)
%  vsc  = spacecraft velocity vector (kilometers/second)

% output

%  c3  = specific orbital energy (km/sec)**2
%  rla = right ascension of asymptote (radians)
%  dla = declination of asymptote (radians)

% Orbital Mechanics with MATLAB

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

zmu = 1.0d0 / mu;

% position magnitude (kilometers)

rmag = norm(rsc);

% velocity magnitude (kilometers/second)

vmag = norm(vsc);

% twice specific orbital energy (km/sec)**2

c3 = vmag * vmag - 2.0d0 * mu / rmag;

if (c3 < 0.0d0)
   fprintf ('\nfunction rv2hyper - orbit is not hyperbolic\n');
   return
end

% angular momentum vector

hv = cross(rsc, vsc);

hmag = norm(hv);

vxh = cross(vsc, hv);

% compute unit position and eccentricity vectors

rhat = rsc / rmag;

ev = zmu * vxh - rhat;

fac1 = 1.0d0 / (1.0d0 + c3 * hmag * hmag / mu / mu);

fac2 = sqrt(c3) / mu;

hxe = cross(hv, ev);

% compute components of c3-scaled unit asymptote vector

shat(1) = fac1 * (fac2 * hxe(1) - ev(1));

shat(2) = fac1 * (fac2 * hxe(2) - ev(2));

shat(3) = fac1 * (fac2 * hxe(3) - ev(3));

% compute declination of asymptote (radians)

dla = asin(shat(3));

% compute right ascension of asymptote (radians)

rla = atan3(shat(2), shat(1));


function eqoe = coe2eqoe(coe)

% convert classical orbital elements to
% equinoctial orbital elements

% convert classical orbital elements to
% equinoctial orbital elements

% input

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

%  eqoe(1) = semimajor axis (kilometers)
%  eqoe(2) = e * sin(argument of perigee + raan)
%  eqoe(3) = e * cos(argument of perigee + raan)
%  eqoe(4) = tan(i/2) * sin(raan)
%  eqoe(5) = tan(i/2) * cos(raan)
%  eqoe(6) = mean anomaly + raan + argument of perigee 

% Orbital Mechanics with MATLAB

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global retro

% compute mean anomaly

a = sin(coe(6)) * sqrt(1 - coe(2) * coe(2));

b = coe(2) + cos(coe(6));

eanom = atan3(a, b);

manom = mod(eanom - coe(2) * sin(eanom), 2.0 * pi);

if (coe(3) > 0.5 * pi)
   retro = -1;
else
   retro = 1;
end

eqoe(1) = coe(1);
eqoe(2) = coe(2) * sin(coe(4) + coe(5) * retro);
eqoe(3) = coe(2) * cos(coe(4) + coe(5) * retro);
    
if (retro == 1)
   eqoe(4) = tan(0.5 * coe(3)) * sin(coe(5));
   eqoe(5) = tan(0.5 * coe(3)) * cos(coe(5));
else
   if (coe(3) >= pi)
      eqoe(4) = 0;
      eqoe(5) = 0;
   else
      eqoe(4) = sin(coe(5)) / tan(0.5 * coe(3));
      eqoe(5) = cos(coe(5)) / tan(0.5 * coe(3));
   end
end
      
eqoe(6) = mod(manom + coe(4) + coe(5) * retro, 2.0 * pi);

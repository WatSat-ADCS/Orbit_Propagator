function [recf, vecf] = fpc2ecf (fpc)

% transform relative flight path coordinates
% to ECF position and velocity vectors

% input

%  fpc(1) = east longitude (radians)
%  fpc(2) = geocentric declination (radians)
%  fpc(3) = relative flight path angle (radians)
%  fpc(4) = relative azimuth (radians)
%  fpc(5) = position magnitude
%  fpc(6) = relative velocity magnitude

% output

%  recf = ecf position vector (kilometers)
%  vecf = ecf velocity vector (kilometers/second)

% Orbital Mechanics with MATLAB

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

alpha = fpc(1);

beta = 0.5 * pi - fpc(3);

delta = fpc(2);
      
azimuth = fpc(4);
      
rmag = fpc(5);
vmag = fpc(6);
      
ca = cos(azimuth);
sa = sin(azimuth);
      
cal = cos(alpha);
sal = sin(alpha);
      
cb = cos(beta);
sb = sin(beta);
      
cd = cos(delta);
sd = sin(delta);
     
% check for spacecraft at either pole

if (delta ~= 0.5 * pi)
    
   tmp1 = -ca * sb * sd + cb * cd;
   tmp2 = -sa * sb * sal;
   tmp3 = sa * sb * cal;
   tmp4 = cb * sd;

   % ecf position vector

   recf(1) = rmag * cd * cal;
   recf(2) = rmag * cd * sal;
   recf(3) = rmag * sd;

   % ecf velocity vector

   vecf(1) = vmag * (tmp1 * cal + tmp2);
   vecf(2) = vmag * (tmp1 * sal + tmp3);
   vecf(3) = vmag * (ca * sb * cd + tmp4);
   
else
    
   % satellite at north or south pole --> rx = ry = 0
         
   recf(1) = 0;
   recf(2) = 0;
   recf(3) = rmag * sd;
         
   vecf(1) = vmag * sb * cal;
   vecf(2) = vmag * sb * sal;
   vecf(3) = vmag * cb;
   
end



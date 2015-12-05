function [recf, vecf] = eci2ecf (gast, reci, veci)

% eci-to-ecf transformation
   
% input

%  gast = apparent sidereal time (radians)
%         (0 <= gast <= 2 pi)
%  reci = position vector (kilometers)
%  veci = velocity vector (kilometers/second)

% output

%  recf = position vector (kilometers)
%  vecf = velocity vector (kilometers/second)

% global constants

%  omega = earth rotation rate (radians/second)

% Orbital Mechanics with MATLAB

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global omega

% calculate eci-to-ecf transformation matrix

tm(1, 1) = cos(gast);
tm(1, 2) = sin(gast);
tm(1, 3) = 0.0;
tm(2, 1) = -sin(gast);
tm(2, 2) = cos(gast);
tm(2, 3) = 0.0;
tm(3, 1) = 0.0;
tm(3, 2) = 0.0;
tm(3, 3) = 1.0;

% calculate derivative of transformation matrix

tmdot(1, 1) = -omega * sin(gast);
tmdot(1, 2) = omega * cos(gast);
tmdot(1, 3) = 0.0;
tmdot(2, 1) = -omega * cos(gast);
tmdot(2, 2) = -omega * sin(gast);
tmdot(2, 3) = 0.0;
tmdot(3, 1) = 0.0;
tmdot(3, 2) = 0.0;
tmdot(3, 3) = 0.0;

recf = tm * reci';

vecf = tm * veci';

% perform velocity vector transformation

vtmp = tmdot * reci';

% compute ecf velocity vector

vecf = vecf + vtmp;


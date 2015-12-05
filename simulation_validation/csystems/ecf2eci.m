function [reci, veci] = ecf2eci (gast, recf, vecf)

% ecf-to-eci transformation
   
% input

%  gast = apparent sidereal time (radians)
%         (0 <= gast <= 2 pi)
%  recf = position vector (kilometers)
%  vecf = velocity vector (kilometers/second)

% output

%  reci = position vector (kilometers)
%  veci = velocity vector (kilometers/second)

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

% compute eci position vector

reci = tm' * recf';

veci = tm' * vecf';

% perform velocity vector transformation

vtmp = tmdot' * recf';

% compute eci velocity vector

veci = veci + vtmp;





function [fid, oev] = readoe1(filename)

% read classical orbital elements data file

% input

%  filename = name of orbital elements data file

% output

%  fid = file id

%  oev(1) = semimajor axis
%  oev(2) = orbital eccentricity
%  oev(3) = orbital inclination
%  oev(4) = argument of perigee
%  oev(5) = right ascension of the ascending node
%  oev(6) = true anomaly

% NOTE: all angular elements are returned in radians

% Orbital Mechanics with MATLAB

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dtr = pi / 180.0;

% open data file

fid = fopen(filename, 'r');

% check for file open error

if (fid == -1)
    
    clc; home;
    
    fprintf('\n\n  error: cannot find this file!!');
    
    return;
    
end

% read 27 lines of data file

for i = 1:1:27
    
    cline = fgetl(fid);
    
    switch i
        
        case 7
            
            oev(1) = str2double(cline);
            
        case 11
            
            oev(2) = str2double(cline);
            
        case 15
            
            oev(3) = dtr * str2double(cline);
            
        case 19
            
            oev(4) = dtr * str2double(cline);
            
        case 23
            
            oev(5) = dtr * str2double(cline);
            
        case 27
            
            oev(6) = dtr * str2double(cline);
    end
    
end

status = fclose(fid);


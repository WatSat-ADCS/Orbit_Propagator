function [fid, meev] = readmee1(filename)

% read modified equinoctial orbital elements data file

% input

%  filename = name of modified equinoctial orbital elements data file

% output

%  fid = file id

%  meev(1) = semiparameter (kilometers)
%  meev(2) = f equinoctial element
%  meev(3) = g equinoctial element
%  meev(4) = h equinoctial element
%  meev(5) = k equinoctial element
%  meev(6) = true longitude (radians)

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

% read 23 lines of data file

for i = 1:1:23
    
    cline = fgetl(fid);
    
    switch i
        
        case 7
            
            meev(1) = str2double(cline);
            
        case 10
            
            meev(2) = str2double(cline);
            
        case 13
            
            meev(3) = str2double(cline);
            
        case 16
            
            meev(4) = str2double(cline);
            
        case 19
            
            meev(5) = str2double(cline);
            
        case 23
            
            meev(6) = dtr * str2double(cline);
    end
    
end

status = fclose(fid);


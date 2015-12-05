function [fid, fpc, jdate, gast] = readfpc1(filename)

% read flight path coordinates data file

% input

%  filename = name of flight path coordinates data file

% output

%  fid = file id

%  fpc(1) = east longitude (radians)
%  fpc(2) = geocentric declination (radians)
%  fpc(3) = flight path angle (radians)
%  fpc(4) = azimuth (radians)
%  fpc(5) = position magnitude (kilometers)
%  fpc(6) = velocity magnitude (kilometers/second)
%  jdate  = UTC julian date
%  gast   = Greenwich apparent sidereal time (radians)

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

% read 31 lines of data file

for i = 1:1:31
    
    cline = fgetl(fid);
    
    switch i
        
        case 6
            
            % UTC calendar date
            
            cdstr = cline;
            
            tl = size(cdstr);
            
            ci = findstr(cdstr, ',');
            
            % extract month, day and year
            
            month = str2double(cdstr(1:ci(1)-1));
            
            day = str2double(cdstr(ci(1)+1:ci(2)-1));
            
            year = str2double(cdstr(ci(2)+1:tl(2)));
            
        case 9
            
            % UTC epoch
            
            utstr = cline;
            
            tl = size(utstr);
            
            ci = findstr(utstr, ',');
            
            % extract hours, minutes and seconds
            
            utc_hr = str2double(utstr(1:ci(1)-1));
            
            utc_min = str2double(utstr(ci(1)+1:ci(2)-1));
            
            utc_sec = str2double(utstr(ci(2)+1:tl(2)));
            
        case 13
            
            % east longitude
            
            fpc(1) = dtr * str2double(cline);
            
        case 17
            
            % geocentric declination
            
            fpc(2) = dtr * str2double(cline);
            
        case 21
            
            % flight path angle
            
            fpc(3) = dtr * str2double(cline);
            
        case 25
            
            % azimuth
            
            fpc(4) = dtr * str2double(cline);
            
        case 28
            
            % position magnitude
            
            fpc(5) = str2double(cline);
            
        case 31
            
            % velocity magnitude
            
            fpc(6) = str2double(cline);
    end
    
end

fclose(fid);

% compute UTC julian date

day = day + utc_hr / 24 + utc_min / 1440.0 + utc_sec / 86400.0;

jdate = julian (month, day, year);

% compute Greenwich apparent sidereal time

tjdh = fix(jdate);

tjdl = jdate - tjdh;

k = 1;

gast = gast4 (tjdh, tjdl, k);
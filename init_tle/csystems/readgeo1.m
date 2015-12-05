function [fid, lat, long, alt, jdate, gast] = readgeo1(filename)

% read geodetic coordinates data file

% input

%  filename = name of data file

% output

%  fid = file id

%  lat   = geodetic latitude (radians)
%  long  = east longitude (radians)
%  alt   = geodetic altitude (kilometers)
%  jdate = UTC Julian date
%  gast  = Greenwich apparent sidereal time (radians)

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

% read 21 lines of data file

for i = 1:1:21
    
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
            
            lat = dtr * str2double(cline);
            
        case 17
            
            long = dtr * str2double(cline);
            
        case 21
            
            alt = str2double(cline);
            
    end
    
end

status = fclose(fid);

% compute UTC julian date

day = day + utc_hr / 24 + utc_min / 1440.0 + utc_sec / 86400.0;

jdate = julian (month, day, year);

% compute Greenwich apparent sidereal time

tjdh = fix(jdate);

tjdl = jdate - tjdh;

gast = gast4 (tjdh, tjdl, 1);

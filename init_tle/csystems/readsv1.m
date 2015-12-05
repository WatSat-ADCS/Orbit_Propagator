function [fid, reci, veci, jdate, gast] = readsv1(filename)

% read eci state vector data file

% input

%  filename = name of orbital elements data file

% output

%  fid = file id

%  reci(1) = x-component of eci position vector
%  reci(2) = y-component of eci position vector
%  reci(3) = z-component of eci position vector
%  veci(1) = x-component of eci velocity vector
%  veci(2) = y-component of eci velocity vector
%  veci(3) = z-component of eci velocity vector
%  jdate   = UTC JUlian date
%  gast    = Greenwich apparent sidereal time (radians)

% Orbital Mechanics with MATLAB

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
            
            reci(1) = str2double(cline);
            
        case 14
            
            reci(2) = str2double(cline);
            
        case 15
            
            reci(3) = str2double(cline);
            
        case 19
            
            veci(1) = str2double(cline);
            
        case 20
            
            veci(2) = str2double(cline);
            
        case 21
            
            veci(3) = str2double(cline);
    end
    
end

status = fclose(fid);

% compute UTC julian date

day = day + utc_hr / 24 + utc_min / 1440.0 + utc_sec / 86400.0;

jdate = julian (month, day, year);

% compute Greenwich apparent sidereal time

tjdh = fix(jdate);

tjdl = jdate - tjdh;

k = 1;

gast = gast4 (tjdh, tjdl, k);

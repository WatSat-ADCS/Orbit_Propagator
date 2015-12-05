function [tdb_hr, tdb_min, tdb_sec] = get_tdb_time

% interactive request and input of Barycentric Dynamical Time

% output

%  tdb_hr  = TDB (hours)
%  tdb_min = TDB (minutes)
%  tdb_sec = TDB time (seconds)

% Orbital Mechanics with MATLAB

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for itry = 1:1:5
    
    fprintf('\nplease input the Barycentric Dynamical Time (TDB)');

    fprintf('\n(0 <= hours <= 24, 0 <= minutes <= 60, 0 <= seconds <= 60)\n');

    tdbstr = input('? ', 's');

    tl = size(tdbstr);

    ci = findstr(tdbstr, ',');

    % extract hours, minutes and seconds

    tdb_hr = str2double(tdbstr(1:ci(1)-1));

    tdb_min = str2double(tdbstr(ci(1)+1:ci(2)-1));

    tdb_sec = str2double(tdbstr(ci(2)+1:tl(2)));

    % check for valid inputs

    if (tdb_hr >= 0 && tdb_hr <= 24 && tdb_min >= 0 && tdb_min <= 60 ...
            && tdb_sec >= 0 && tdb_sec <= 60)
        
        break;
        
    end
    
end

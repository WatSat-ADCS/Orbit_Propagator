function [utc_hr, utc_min, utc_sec] = get_utc_time

% interactive request and input of universal coordinated time

% output

%  utc_hr  = universal time (hours)
%  utc_min = universal time (minutes)
%  utc_sec = universal time (seconds)

% Orbital Mechanics with MATLAB

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for itry = 1:1:5
    
    fprintf('\nplease input the Universal Coordinated Time (UTC)');

    fprintf('\n(0 <= hours <= 24, 0 <= minutes <= 60, 0 <= seconds <= 60)\n');

    utstr = input('? ', 's');

    tl = size(utstr);

    ci = findstr(utstr, ',');

    % extract hours, minutes and seconds

    utc_hr = str2double(utstr(1:ci(1)-1));

    utc_min = str2double(utstr(ci(1)+1:ci(2)-1));

    utc_sec = str2double(utstr(ci(2)+1:tl(2)));

    % check for valid inputs

    if (utc_hr >= 0 && utc_hr <= 24 && utc_min >= 0 && utc_min <= 60 ...
            && utc_sec >= 0 && utc_sec <= 60)
        
        break;
        
    end
    
end

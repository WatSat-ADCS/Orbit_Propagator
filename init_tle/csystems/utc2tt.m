function jdtt = utc2tt (jdutc)

% convert UTC julian date to TT julian date

% input

%  jdutc   = UTC julian date

% output

%  jdtt = Terrestrial Time (TT) julian date 

% Reference Frames in Astronomy and Geophysics
% J. Kovalevsky et al., 1989, pp. 439-442

% Orbital Mechanics with MATLAB

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% find current number of leap seconds

leapsecond = findleap(jdutc);

% TT julian date
    
corr = (leapsecond + 32.184) / 86400.0;
    
jdtt = jdutc + corr;
    

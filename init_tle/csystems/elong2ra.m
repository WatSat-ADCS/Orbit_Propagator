% elong2ra.m         May 22, 2008

% convert east longitude to right ascension

% Orbital Mechanics with MATLAB

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;

dtr = pi / 180;

rtd = 180 / pi;

clc; home;
   
fprintf('\n                program elong2ra\n');
   
fprintf('\n < convert east longitude to right ascension >\n\n');

% request calendar date and ut

[month, day, year] = getdate;

[uthr, utmin, utsec] = gettime;

% compute julian date

jdate = julian(month, day, year) ...
         + uthr / 24 + utmin / 1440 + utsec / 86400;

% request east longitude

for itry = 1:1:5
    fprintf('\n\nplease input the east longitude (degrees)\n');
    fprintf('(0 <= east longitude <= 360)\n');

    elong = input('? ');
   
    if (elong >= 0 && elong <= 360)
       break;
    end   
end

% compute greenwich apparent sidereal time

gst = gast1(jdate);

rasc = mod(gst + elong * dtr, 2.0 * pi);

% print results

[cdstr, utstr] = jd2str(jdate);
   
fprintf('\n                program elong2ra\n');
   
fprintf('\n < convert east longitude to right ascension >\n\n');

fprintf('\ncalendar date       ');

disp(cdstr);

fprintf('\nuniversal time      ');

disp(utstr);

fprintf('\n\neast longitude   %14.8f  degrees \n', elong);

fprintf('\nright ascension  %14.8f  degrees \n', rasc * rtd);

fprintf('\ngst              %14.8f  degrees \n', rtd * gst);

fprintf('\n right ascension = gst + east longitude\n\n');



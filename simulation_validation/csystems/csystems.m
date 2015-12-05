% csystems.m          May 8, 2013

% time and coordinate calculations

% Orbital Mechanics with MATLAB

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;

global dtr rtd mu inutate omega

% read astrodynamic and utility constants

om_constants;

% read leap seconds data file

readleap;

% initialize nut2000b nutation algorithm

inutate = 1;

clc; home;

fprintf('\n\n TIME AND COORDINATE CALCULATIONS');
fprintf('\n --------------------------------\n');

while (1)
    
    fprintf('\n\n TYPE OF CALCULATION MENU\n');
    
    fprintf('\n  <1> time\n');
    
    fprintf('\n  <2> coordinates\n');
    
    fprintf('\n  <3> quit\n');
    
    fprintf('\n selection');
    
    calc_type = input('? ');
    
    if (calc_type == 3)
        
        break;
        
    end
    
    if (calc_type == 1)
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%
        % time system calculations
        %%%%%%%%%%%%%%%%%%%%%%%%%%
        
        while (1)
            
            fprintf('\n\n TIME CALCULATION MENU\n');
            
            fprintf('\n  <1> convert UTC calendar date and time to UTC Julian date\n');
            
            fprintf('\n  <2> convert UTC Julian date to UTC calendar date and time\n');
            
            fprintf('\n  <3> Greenwich apparent sidereal time\n');
            
            fprintf('\n  <4> convert Universal Coordinated Time (UTC) to Terrestrial Time (TT)\n');
            
            fprintf('\n  <5> convert Universal Coordinated Time (UTC) to Barycentric Dynamical Time (TDB)\n');
            
            fprintf('\n  <6> convert Barycentric Dynamical Time (TDB) to Universal Coordinated Time (UTC)\n');
            
            fprintf('\n selection');
            
            time_slct = input('? ');
            
            if (time_slct >= 1 && time_slct <= 6)
                
                break;
                
            end
            
        end
        
        while (1)
            
            fprintf('\n\n DATA SOURCE MENU\n');
            
            fprintf('\n  <1> user input\n');
            
            fprintf('\n  <2> internal data\n\n');
            
            fprintf('\n selection');
            
            data_slct = input('? ');
            
            if (data_slct == 1 || data_slct == 2)
                
                break;
                
            end
            
        end
        
        switch time_slct
            
            case 1
                
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                % convert UTC calendar date and time to Julian date
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                fprintf('\n\nconvert UTC calendar date and time to UTC Julian date');
                fprintf('\n-----------------------------------------------------\n');
                
                if (data_slct == 1)
                    
                    % user input
                    
                    [month, day, year] = getdate;
                    
                    [utc_hr, utc_min, utc_sec] = get_utc_time;
                    
                    day = day + utc_hr / 24.0 + utc_min / 1440.0 + utc_sec / 86400.0;
                    
                    jdate_utc = julian (month, day, year);
                    
                    [cdstr, utstr] = jd2str(jdate_utc);
                    
                    fprintf('\nUTC calendar date         ');
                    
                    disp(cdstr);
                    
                    fprintf('\nUTC time                  ');
                    
                    disp(utstr);
                    
                    fprintf('\nUTC Julian date           %16.8f \n', jdate_utc);
                    
                end
                
                if (data_slct == 2)
                    
                    % internal data (jdate_utc)
                    
                    [cdstr, utstr] = jd2str(jdate_utc);
                    
                    fprintf('\nUTC calendar date         ');
                    
                    disp(cdstr);
                    
                    fprintf('\nUTC time                  ');
                    
                    disp(utstr);
                    
                    fprintf('\nUTC Julian date           %16.8f \n', jdate_utc);
                    
                end
                
            case 2
                
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                % convert UTC Julian date to calendar date and time
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                fprintf('\n\nconvert UTC Julian date to UTC calendar date and time');
                fprintf('\n-----------------------------------------------------\n');
                
                if (data_slct == 1)
                    
                    % user input
                    
                    fprintf('\nplease input the UTC Julian date\n');
                    
                    jdate_utc = input('? ');
                    
                    [cdstr, utstr] = jd2str(jdate_utc);
                    
                    fprintf('\nUTC calendar date         ');
                    
                    disp(cdstr);
                    
                    fprintf('\nUTC time                  ');
                    
                    disp(utstr);
                    
                    fprintf('\nUTC Julian date           %16.8f \n', jdate_utc);
                    
                end
                
                if (data_slct == 2)
                    
                    % internal data (jdate_utc)
                    
                    [cdstr, utstr] = jd2str(jdate_utc);
                    
                    fprintf('\nUTC calendar date         ');
                    
                    disp(cdstr);
                    
                    fprintf('\nUTC time                  ');
                    
                    disp(utstr);
                    
                    fprintf('\nUTC Julian date           %16.8f \n', jdate_utc);
                    
                end
                
            case 3
                
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                % Greenwich apparent sidereal time from UTC calendar date and time
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                fprintf('\n\nGreenwich apparent sidereal time from UTC calendar date and time');
                fprintf('\n----------------------------------------------------------------\n');
                
                if (data_slct == 1)
                    
                    % user input
                    
                    [month, day, year] = getdate;
                    
                    [utc_hr, utc_min, utc_sec] = get_utc_time;
                    
                    day = day + utc_hr / 24 + utc_min / 1440.0 + utc_sec / 86400.0;
                    
                    jdate_utc = julian (month, day, year);
                    
                    tjdh = fix(jdate_utc);
                    
                    tjdl = jdate_utc - tjdh;
                    
                    gast = gast4 (tjdh, tjdl, 1);
                    
                    [cdstr, utstr] = jd2str(jdate_utc);
                    
                    [h, m, s, hmsstr] = hrs2hms ( 24.0 * gast / (2.0 * pi));
                    
                    fprintf('\nUTC calendar date         ');
                    
                    disp(cdstr);
                    
                    fprintf('\nUTC time                  ');
                    
                    disp(utstr);
                    
                    fprintf('\nUTC Julian date           %16.8f \n', jdate_utc);
                    
                    fprintf('\nGreenwich apparent sidereal time    ');
                    
                    disp(hmsstr);
                    
                    fprintf('\nGreenwich apparent sidereal time  %14.8f degrees\n', rtd * gast);
                    
                end
                
                if (data_slct == 2)
                    
                    % internal data (jdate_utc)
                    
                    tjdh = fix(jdate_utc);
                    
                    tjdl = jdate_utc - tjdh;
                    
                    gast = gast4 (tjdh, tjdl, 1);
                    
                    [cdstr, utstr] = jd2str(jdate_utc);
                    
                    [h, m, s, hmsstr] = hrs2hms (24.0 * gast / (2.0 * pi));
                    
                    fprintf('\nUTC calendar date         ');
                    
                    disp(cdstr);
                    
                    fprintf('\nUTC time                  ');
                    
                    disp(utstr);
                    
                    fprintf('\nUTC Julian date           %16.8f \n', jdate_utc);
                    
                    fprintf('\nGreenwich apparent sidereal time    ');
                    
                    disp(hmsstr);
                    
                    fprintf('\nGreenwich apparent sidereal time  %14.8f degrees\n', rtd * gast);
                    
                end
                
            case 4
                
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                % convert Universal Coordinated Time (UTC) to Terrestrial Time (TT)
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                fprintf('\n\nUniversal Coordinated Time (UTC) to Terrestrial Time (TT)');
                fprintf('\n---------------------------------------------------------\n');
                
                if (data_slct == 1)
                    
                    % user input
                    
                    [month, day, year] = getdate;
                    
                    [utc_hr, utc_min, utc_sec] = get_utc_time;
                    
                    day = day + utc_hr / 24 + utc_min / 1440.0 + utc_sec / 86400.0;
                    
                    jdate_utc = julian (month, day, year);
                    
                end
                
                if (data_slct == 2)
                    
                    % internal data (jdate_utc)
                    
                end
                
                [cdstr, utstr] = jd2str(jdate_utc);
                
                fprintf('\nUTC calendar date         ');
                
                disp(cdstr);
                
                fprintf('\nUTC time                  ');
                
                disp(utstr);
                
                fprintf('\nUTC Julian date           %16.8f \n', jdate_utc);
                
                jdate_tt = utc2tt (jdate_utc);
                
                [cdstr, utstr] = jd2str(jdate_tt);
                
                fprintf('\nTT calendar date          ');
                
                disp(cdstr);
                
                fprintf('\nTT time                   ');
                
                disp(utstr);
                
                fprintf('\nTT Julian date            %16.8f \n', jdate_tt);
                
            case 5
                
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                % convert Universal Coordinated Time (UTC) to Barycentric Dynamical Time (TDB)
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                fprintf('\n\nUniversal Coordinated Time (UTC) to Barycentric Dynamical Time (TDB)');
                fprintf('\n--------------------------------------------------------------------\n');
                
                if (data_slct == 1)
                    
                    % user input
                    
                    [month, day, year] = getdate;
                    
                    [utc_hr, utc_min, utc_sec] = get_utc_time;
                    
                    day = day + utc_hr / 24.0 + utc_min / 1440.0 + utc_sec / 86400.0;
                    
                    jdate_utc = julian (month, day, year);
                    
                end
                
                if (data_slct == 2)
                    
                    % internal data (jdate_utc)
                    
                end
                
                [cdstr, utstr] = jd2str(jdate_utc);
                
                fprintf('\nUTC calendar date         ');
                
                disp(cdstr);
                
                fprintf('\nUTC time                  ');
                
                disp(utstr);
                
                fprintf('\nUTC Julian date           %16.8f \n', jdate_utc);
                
                jdate_tdb = utc2tdb (jdate_utc);
                
                [cdstr, utstr] = jd2str(jdate_tdb);
                
                fprintf('\nTDB calendar date         ');
                
                disp(cdstr);
                
                fprintf('\nTDB time                  ');
                
                disp(utstr);
                
                fprintf('\nTDB Julian date           %16.8f \n', jdate_tdb);
                
            case 6
                
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                % convert Barycentric Dynamical Time (TDB) to Universal Coordinated Time (UTC)
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                fprintf('\n\nBarycentric Dynamical Time (TDB) to Universal Coordinated Time (UTC)');
                fprintf('\n--------------------------------------------------------------------\n');
                
                if (data_slct == 1)
                    
                    % user input
                    
                    [month, day, year] = getdate;
                    
                    [tdb_hr, tdb_min, tdb_sec] = get_tdb_time;
                    
                    day = day + tdb_hr / 24 + tdb_min / 1440.0 + tdb_sec / 86400.0;
                    
                    jdate_tdb = julian (month, day, year);
                    
                end
                               
                jdate_utc = tdb2utc (jdate_tdb);
                
                [cdstr, utstr] = jd2str(jdate_utc);
                
                fprintf('\nUTC calendar date         ');
                
                disp(cdstr);
                
                fprintf('\nUTC time                  ');
                
                disp(utstr);
                
                fprintf('\nUTC Julian date           %16.8f \n', jdate_utc);
                
                [cdstr, utstr] = jd2str(jdate_tdb);
                
                fprintf('\nTDB calendar date         ');
                
                disp(cdstr);
                
                fprintf('\nTDB time                  ');
                
                disp(utstr);
                
                fprintf('\nTDB Julian date           %16.8f \n', jdate_tdb);
                
        end
        
        fprintf('\n\n');
        
        pause;
        
    end
    
    if (calc_type == 2)
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % coordinate system calculations
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        while (1)
            
            fprintf('\n\n COORDINATE CALCULATION MENU\n');
            
            fprintf('\n  <1>  convert geodetic coordinates to eci position vector\n');
            
            fprintf('\n  <2>  convert eci state vector to ecf state vector\n');
            
            fprintf('\n  <3>  convert eci state vector to classical orbital elements\n');
            
            fprintf('\n  <4>  convert classical orbital elements to eci state vector\n');
            
            fprintf('\n  <5>  convert flight path coordinates to eci state vector\n');
            
            fprintf('\n  <6>  convert eci state vector to relative flight path coordinates\n');
            
            fprintf('\n  <7>  convert classical orbital elements to modified equinoctial elements\n');
            
            fprintf('\n  <8>  convert modified equinoctial elements to classical orbital elements\n');
            
            fprintf('\n  <9>  convert osculating orbital elements to mean elements\n');
            
            fprintf('\n  <10> convert eci state vector to Two Line Elements (TLE)\n');
            
            fprintf('\n selection');
            
            coord_slct = input('? ');
            
            if (coord_slct >= 1 && coord_slct <= 10)
                
                break;
                
            end
            
        end
        
        while (1)
            
            fprintf('\n\n DATA SOURCE MENU\n');
            
            fprintf('\n  <1> user input\n');
            
            fprintf('\n  <2> data file\n');

            fprintf('\n  <3> internal data\n\n');
                        
            fprintf('\n selection');
            
            data_slct = input('? ');
            
            if (data_slct >= 1 && data_slct <= 3)
                
                break;
                
            end
            
        end
        
        switch coord_slct
            
            case 1
                
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                % convert geodetic coordinates to eci position vector
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                fprintf('\n\nconvert geodetic coordinates to eci position vector');
                fprintf('\n---------------------------------------------------\n');
                
                if (data_slct == 1)
                    
                    % user input
                    
                    [month, day, year] = getdate;
                    
                    [utc_hr, utc_min, utc_sec] = get_utc_time;
                    
                    day = day + utc_hr / 24.0 + utc_min / 1440.0 + utc_sec / 86400.0;
                    
                    jdate_utc = julian (month, day, year);
                    
                    % compute Greenwich apparent sidereal time
                    
                    tjdh = fix(jdate_utc);
                    
                    tjdl = jdate_utc - tjdh;
                    
                    gast = gast4 (tjdh, tjdl, 1);
                    
                    fprintf('\nplease input the geodetic latitude (degrees)');
                    fprintf('\n(-90 <= latitude <= +90)\n');
                    
                    lat = input('? ');
                    
                    fprintf('\nplease input the east longitude (degrees)');
                    fprintf('\n(0 <= east longitude <= 360)\n');
                    
                    long = input('? ');
                    
                    fprintf('\nplease input the geodetic altitude (kilometers)');
                    fprintf('\n(-90 <= flight path angle <= +90)\n');
                    
                    alt = input('? ');
                    
                    lat = dtr * lat;
                    
                    long = dtr * long;
                    
                end
                
                if (data_slct == 2)
                    
                    % read data file
                    
                    [filename, pathname] = uigetfile('*.dat', 'Please select the data file to read');
                    
                    [fid, lat, long, alt, jdate_utc, gast] = readgeo1(filename);
                    
                end
                
                [cdstr, utstr] = jd2str(jdate_utc);
                
                fprintf('\nUTC calendar date         ');
                
                disp(cdstr);
                
                fprintf('\nUTC time                  ');
                
                disp(utstr);
                
                fprintf('\ngeodetic latitude       %14.8f degrees\n', rtd * lat);
                
                fprintf('\ngeographic longitude    %14.8f degrees\n', rtd * long);
                
                fprintf('\ngeodetic altitude       %14.8f kilometers\n', alt);
                
                % compute eci position vector (kilometers)
                
                reci = lla2eci (gast, lat, long, alt);
                
                fprintf('\neci position vector\n');
                
                fprintf ('\n        rx (km)                 ry (km)                rz (km)                rmag (km)');
                
                fprintf ('\n %+16.14e  %+16.14e  %+16.14e  %+16.14e  \n', reci(1), reci(2), reci(3), norm(reci));
                
            case 2
                
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                % convert eci state vector to ecf state vector
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                fprintf('\n\nconvert eci state vector to ecf state vector');
                fprintf('\n--------------------------------------------\n');
                
                if (data_slct == 1)
                    
                    % user input
                    
                    [month, day, year] = getdate;
                    
                    [utc_hr, utc_min, utc_sec] = get_utc_time;
                    
                    day = day + utc_hr / 24.0 + utc_min / 1440.0 + utc_sec / 86400.0;
                    
                    jdate_utc = julian (month, day, year);
                    
                    tjdh = fix(jdate_utc);
                    
                    tjdl = jdate_utc - tjdh;
                    
                    gast = gast4 (tjdh, tjdl, 1);
                    
                    [reci, veci] = getsv;
                    
                end
                
                if (data_slct == 2)
                    
                    % read data file
                    
                    [filename, pathname] = uigetfile('*.dat', 'Please select the data file to read');
                    
                    [fid, reci, veci, jdate_utc, gast] = readsv1(filename);
                    
                end
                
                [recf, vecf] = eci2ecf (gast, reci, veci);
                   
                fprintf('\neci position vector\n');
                
                svprint(reci, veci);
                                
                fprintf('\necf position vector\n');
                                
                svprint(recf, vecf);
                
            case 3
                
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                % convert eci state vector to classical orbital elements
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                fprintf('\n\nconvert eci state vector to classical orbital elements');
                fprintf('\n------------------------------------------------------\n');
                
                if (data_slct == 1)
                    
                    % user input
                    
                    [month, day, year] = getdate;
                    
                    [utc_hr, utc_min, utc_sec] = get_utc_time;
                    
                    day = day + utc_hr / 24.0 + utc_min / 1440.0 + utc_sec / 86400.0;
                    
                    jdate_utc = julian (month, day, year);
                    
                    tjdh = fix(jdate_utc);
                    
                    tjdl = jdate_utc - tjdh;
                    
                    gast = gast4 (tjdh, tjdl, 1);
                    
                    [reci, veci] = getsv;
                    
                end
                
                if (data_slct == 2)
                    
                    % read data file
                    
                    [filename, pathname] = uigetfile('*.dat', 'Please select the data file to read');
                    
                    [fid, reci, veci, jdate_utc, gast] = readsv1(filename);
                    
                end
                
                coev = eci2orb2 (mu, gast, omega, 0.0, reci, veci);
                
                [cdstr, utstr] = jd2str(jdate_utc);
                
                fprintf('\nUTC calendar date         ');
                
                disp(cdstr);
                
                fprintf('\nUTC time                  ');
                
                disp(utstr);
                
                fprintf('\nGreenwich apparent sidereal time  %12.8f degrees\n', rtd * gast);
                
                fprintf('\n\neci state vector\n');
                
                svprint (reci, veci);
                
                fprintf('\nclassical orbital elements\n');
                
                oeprint3(mu, coev, 2);
                
            case 4
                
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                % convert classical orbital elements to eci state vector
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                fprintf('\n\nconvert classical orbital elements to eci state vector');
                fprintf('\n------------------------------------------------------\n');
                
                if (data_slct == 1)
                    
                    % user input
                    
                    coev = getoe([1; 1; 1; 1; 1; 1]);
                    
                end
                
                if (data_slct == 2)
                    
                    % read data file
                    
                    [filename, pathname] = uigetfile('*.dat', 'Please select the data file to read');
                    
                    [fid, coev] = readoe1(filename);
                    
                end
                
                [reci, veci] = orb2eci(mu, coev);
                
                fprintf('\neci state vector\n');
                
                svprint (reci, veci);
                
                fprintf('\nclassical orbital elements\n');
                
                oeprint1(mu, coev, 2);
                
            case 5
                
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                % convert flight path coordinates to eci state vector
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                fprintf('\n\nconvert flight path coordinates to eci state vector');
                fprintf('\n---------------------------------------------------\n');
                
                if (data_slct == 1)
                    
                    % user input
                    
                    [month, day, year] = getdate;
                    
                    [utc_hr, utc_min, utc_sec] = get_utc_time;
                    
                    day = day + utc_hr / 24.0 + utc_min / 1440.0 + utc_sec / 86400.0;
                    
                    jdate_utc = julian (month, day, year);
                    
                    tjdh = fix(jdate_utc);
                    
                    tjdl = jdate_utc - tjdh;
                    
                    gast = gast4 (tjdh, tjdl, 1);
                    
                    fprintf('\nplease input the east longitude (degrees)');
                    fprintf('\n(0 <= east longitude <= 360)\n');
                    
                    elong = input('? ');
                    
                    fprintf('\nplease input the geocentric declination (degrees)');
                    fprintf('\n(-90 <= declination <= +90)\n');
                    
                    decl = input('? ');
                    
                    fprintf('\nplease input the relative flight path angle (degrees)');
                    fprintf('\n(-90 <= flight path angle <= +90)\n');
                    
                    fpa = input('? ');
                    
                    fprintf('\nplease input the relative azimuth angle (degrees)');
                    fprintf('\n(0 <= azimuth <= 360\n');
                    
                    azimuth = input('? ');
                    
                    fprintf('\nplease input the position magnitude (kilometers)\n');
                    
                    fpc(5) = input('? ');
                    
                    fprintf('\nplease input the relative velocity magnitude (kilometers/second)\n');
                    
                    fpc(6) = input('? ');
                    
                    fpc(1) = elong * dtr;
                    
                    fpc(2) = decl * dtr;
                    
                    fpc(3) = fpa * dtr;
                    
                    fpc(4) = azimuth * dtr;
                    
                end
                
                if (data_slct == 2)
                    
                    % read data file
                    
                    [filename, pathname] = uigetfile('*.dat', 'Please select the data file to read');
                    
                    [fid, fpc, jdate_utc, gast] = readfpc1(filename);
                    
                end
                
                [reci, veci] = fpc2eci(gast, fpc);
                
                [cdstr, utstr] = jd2str(jdate_utc);
                
                fprintf('\nUTC calendar date         ');
                
                disp(cdstr);
                
                fprintf('\nUTC time                  ');
                
                disp(utstr);
                
                fprintf('\nGreenwich apparent sidereal time  %12.8f degrees\n', rtd * gast);
                
                fprintf('\neci state vector\n');
                
                svprint (reci, veci);
                
                fprintf('\nflight path coordinates\n\n');
                
                fprintf('east longitude        %14.8f degrees\n', rtd * fpc(1));
                fprintf('declination           %14.8f degrees\n', rtd * fpc(2));
                fprintf('flight path angle     %14.8f degrees\n', rtd * fpc(3));
                fprintf('azimuth               %14.8f degrees\n', rtd * fpc(4));
                fprintf('position magnitude    %14.8f kilometers\n', fpc(5));
                fprintf('velocity magnitude    %14.8f kilometers/second\n', fpc(6));
                
            case 6
                
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                % convert eci state vector to flight path coordinates
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                fprintf('\n\nconvert eci state vector to flight path coordinates');
                fprintf('\n---------------------------------------------------\n');
                
                if (data_slct == 1)
                    
                    % user input
                    
                    [month, day, year] = getdate;
                    
                    [utc_hr, utc_min, utc_sec] = get_utc_time;
                    
                    day = day + utc_hr / 24.0 + utc_min / 1440.0 + utc_sec / 86400.0;
                    
                    jdate_utc = julian (month, day, year);
                    
                    tjdh = fix(jdate_utc);
                    
                    tjdl = jdate_utc - tjdh;
                    
                    gast = gast4 (tjdh, tjdl, 1);
                    
                    [reci, veci] = getsv;
                    
                end
                
                if (data_slct == 2)
                    
                    % read data file
                    
                    [filename, pathname] = uigetfile('*.dat', 'Please select the data file to read');
                    
                    [fid, reci, veci, jdate_utc, gast] = readsv1(filename);
                    
                end
                
                [cdstr, utstr] = jd2str(jdate_utc);
                
                fprintf('\nUTC calendar date         ');
                
                disp(cdstr);
                
                fprintf('\nUTC time                  ');
                
                disp(utstr);
                
                fprintf('\nGreenwich apparent sidereal time  %12.8f degrees\n', rtd * gast);
                
                fpc = eci2fpc1(gast, reci, veci);
                
                fprintf('\neci state vector\n');
                
                svprint (reci, veci);
                
                fprintf('\nrelative flight path coordinates\n\n');
                
                fprintf('east longitude         %14.8f degrees\n', rtd * fpc(1));
                fprintf('declination            %14.8f degrees\n', rtd * fpc(2));
                fprintf('flight path angle      %14.8f degrees\n', rtd * fpc(3));
                fprintf('relative azimuth       %14.8f degrees\n', rtd * fpc(4));
                fprintf('position magnitude     %14.8f kilometers\n', fpc(5));
                fprintf('velocity magnitude     %14.8f kilometers/second\n', fpc(6));
                
            case 7
                
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %  convert classical orbital elements to modified equinoctial elements
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                fprintf('\n\nconvert classical orbital elements to modified equinoctial elements');
                fprintf('\n-------------------------------------------------------------------\n');
                
                if (data_slct == 1)
                    
                    % user input
                    
                    coev = getoe([1; 1; 1; 1; 1; 1]);
                    
                end
                
                if (data_slct == 2)
                    
                    % read orbital elements data file
                    
                    [filename, pathname] = uigetfile('*.dat', 'Please select the data file to read');
                    
                    [fid, coev] = readoe1(filename);
                    
                end
                
                meev = coe2mee(mu, coev);
                
                fprintf('\nclassical orbital elements\n');
                
                oeprint1(mu, coev, 2);
                
                fprintf('\nmodified equinoctial orbital elements\n\n');
                
                fprintf('semiparameter    %14.8f kilometers\n', meev(1));
                fprintf('f element        %14.8f \n', meev(2));
                fprintf('g element        %14.8f \n', meev(3));
                fprintf('h element        %14.8f \n', meev(4));
                fprintf('k element        %14.8f \n', meev(5));
                fprintf('true longitude   %14.8f degrees\n', rtd * meev(6));
                
            case 8
                
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                % convert modified equinoctial elements to classical orbital elements
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                fprintf('\n\nconvert modified equinoctial elements to classical orbital elements');
                fprintf('\n-------------------------------------------------------------------\n');
                
                if (data_slct == 1)
                    
                    % user input
                    
                    fprintf('\nplease input the semiparameter (kilometers)\n');
                    
                    p = input('? ');
                    
                    fprintf('\nplease input the f element\n');
                    
                    f = input('? ');
                    
                    fprintf('\nplease input the g element\n');
                    
                    g = input('? ');
                    
                    fprintf('\nplease input h\n');
                    
                    h = input('? ');
                    
                    fprintf('\nplease input k\n');
                    
                    k = input('? ');
                    
                    fprintf('\nplease input the true longitude (degrees)\n');
                    
                    lambda = input('? ');
                    
                    meev(1) = p;
                    meev(2) = f;
                    meev(3) = g;
                    meev(4) = h;
                    meev(5) = k;
                    meev(6) = dtr * lambda;
                    
                end
                
                if (data_slct == 2)
                    
                    % read data file
                    
                    [filename, pathname] = uigetfile('*.dat', 'Please select the data file to read');
                    
                    [fid, meev] = readmee1(filename);
                    
                end
                
                coev = mee2coe(meev);
                
                fprintf('\nclassical orbital elements\n');
                
                oeprint1(mu, coev, 2);
                
                fprintf('\nmodified equinoctial orbital elements\n\n');
                
                fprintf('semiparameter    %14.8f kilometers\n', meev(1));
                fprintf('f element        %14.8f \n', meev(2));
                fprintf('g element        %14.8f \n', meev(3));
                fprintf('h element        %14.8f \n', meev(4));
                fprintf('k element        %14.8f \n', meev(5));
                fprintf('true longitude   %14.8f degrees\n', rtd * meev(6));
                
            case 9
                
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                % convert osculating orbital elements to mean elements
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                fprintf('\n\nconvert osculating orbital elements to mean orbital elements');
                fprintf('\n------------------------------------------------------------\n');
                
                if (data_slct == 1)
                    
                    % user input
                    
                    coev = getoe([1; 1; 1; 1; 1; 1]);
                    
                end
                
                if (data_slct == 2)
                    
                    % read orbital elements data file
                    
                    [filename, pathname] = uigetfile('*.dat', 'Please select the data file to read');
                    
                    [fid, coev] = readoe1(filename);
                    
                end
                
                mcoev = osc2mean (coev);
                
                fprintf('\nclassical osculating orbital elements\n');
                
                oeprint1(mu, coev, 2);
                
                fprintf('\n\nclassical mean orbital elements\n');
                
                oeprint1(mu, mcoev, 2);
                
            case 10
                
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                % convert eci state vector to Two Line Elements
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                fprintf('\n\nconvert eci state vector to Two Line Elements (TLE)');
                fprintf('\n---------------------------------------------------\n');
                
                if (data_slct == 1)
                    
                    % user input
                    
                    [month, day, year] = getdate;
                    
                    [utc_hr, utc_min, utc_sec] = get_utc_time;
                    
                    day = day + utc_hr / 24.0 + utc_min / 1440.0 + utc_sec / 86400.0;
                    
                    jdate_utc = julian (month, day, year);
                    
                    [reci, veci] = getsv;
                    
                end
                
                if (data_slct == 2)
                    
                    % read data file
                    
                    [filename, pathname] = uigetfile('*.dat', 'Please select the data file to read');
                    
                    [fid, reci, veci, jdate_utc] = read_rv2tle(filename);
                    
                end
                
                % compute Greenwich apparent sidereal time (radians)
                
                tjdh = fix(jdate_utc);
                
                tjdl = jdate_utc - tjdh;
                
                gast = gast4 (tjdh, tjdl, 1);
                
                % set TLE julian date
                
                jdate_tle = jdate_utc;
                
                [month, day, iytle] = gdate (jdate_tle);
                
                % compute TLE day-of-year
                
                jdate0 = julian(1, 0.0d0, iytle);
                
                tledoy = jdate_tle - jdate0;
                
                % compute components of TLE
                
                [eo, xno, xmo, xincl, omegao, xnodeo] = rv2tle(reci, veci);
                
                coev = eci2orb2 (mu, gast, omega, 0.0, reci, veci);
                
                [cdstr, utstr] = jd2str(jdate_utc);
                
                fprintf('\nUTC calendar date         ');
                
                disp(cdstr);
                
                fprintf('\nUTC time                  ');
                
                disp(utstr);
                
                fprintf('\n\neci state vector');
                fprintf('\n-----------------\n');
                
                svprint (reci, veci)
                
                fprintf('\nclassical orbital elements');
                fprintf('\n--------------------------\n');
                
                oeprint3 (mu, coev, 2);
                
                fprintf('\ncomponents of the TLE');
                fprintf('\n---------------------\n');
                
                fprintf('\neccentricity    %14.8f', eo);
                fprintf('\nmean motion     %14.8f  orbits per day', xno);
                fprintf('\nmean anomaly    %14.8f  degrees', rtd * xmo);
                fprintf('\ninclination     %14.8f  degrees', rtd * xincl);
                fprintf('\nargper          %14.8f  degrees', rtd * omegao);
                fprintf('\nraan            %14.8f  degrees\n', rtd * xnodeo);
                
                % display line 1
                
                tledoy_string = num2str(tledoy, 12);
                
                ci = strfind(tledoy_string, '.');
                
                fprintf('\nTwo Line Elements');
                fprintf('\n-----------------\n');
                
                if (iytle < 2000)
                    
                    fprintf('\n1 XXXXXU XXXXXXXX %2.2i%3.3i.%s .00000000   00000-0  00000-0', ...
                        iytle-1900, fix(tledoy), tledoy_string(ci + 1:ci + 8));
                    
                else
                    
                    fprintf('\n1 XXXXXU XXXXXXXX %2.2i%3.3i.%s .00000000   00000-0  00000-0', ...
                        iytle-2000, fix(tledoy), tledoy_string(ci + 1:ci + 8));
                    
                end
                
                % display line 2
                
                fprintf('\n2 XXXXX %8.4f %8.4f %7.7i %8.4f %8.4f %11.8f\n\n', ...
                    rtd * xincl, rtd * xnodeo, fix(eo * 1.0d7), rtd * omegao, rtd * xmo, xno);
                
        end
        
        fprintf('\n\n');
        
        pause;
        
    end
    
end

fprintf('\n\n');


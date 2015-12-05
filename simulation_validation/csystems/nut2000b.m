function [dpsi, deps] = nut2000b (jdate)

% nutation based on iau 2000b theory

% input

%  jdate = tt julian date 

% output

%  dpsi = nutation in longitude in arc seconds

%  deps = nutation in obliquity in arc seconds

% reference

%  An Abridged Model of the Precession-Nutation
%  of the Celestial Pole, D. McCarthy and B. Luzum,
%  Celestial Mechanics and Dynamical Astronomy, 85: 37-49, 2003.

% Orbital Mechanics with MATLAB

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global inutate xnut

if (inutate == 1)
    
    % initialize
    
    xnut = [0,   0,   0,   0,   1, -172064161,  -174666, 92052331,  9086,  33386, 15377; ...
            0,   0,   2,  -2,   2,  -13170906,    -1675,  5730336, -3015, -13696, -4587; ...
            0,   0,   2,   0,   2,   -2276413,     -234,   978459,  -485,   2796,  1374; ...
            0,   0,   0,   0,   2,    2074554,      207,  -897492,   470,   -698,  -291; ...
            0,   1,   0,   0,   0,    1475877,    -3633,    73871,  -184,  11817, -1924; ...
            0,   1,   2,  -2,   2,    -516821,     1226,   224386,  -677,   -524,  -174; ...
            1,   0,   0,   0,   0,     711159,       73,    -6750,     0,   -872,   358; ...
            0,   0,   2,   0,   1,    -387298,     -367,   200728,    18,    380,   318; ...
            1,   0,   2,   0,   2,    -301461,      -36,   129025,   -63,    816,   367; ...
            0,  -1,   2,  -2,   2,     215829,     -494,   -95929,   299,    111,   132; ...
            0,   0,   2,  -2,   1,     128227,      137,   -68982,    -9,    181,    39; ...
           -1,   0,   2,   0,   2,     123457,       11,   -53311,    32,     19,    -4; ...
           -1,   0,   0,   2,   0,     156994,       10,    -1235,     0,   -168,    82; ...
            1,   0,   0,   0,   1,      63110,       63,   -33228,     0,     27,    -9; ...
           -1,   0,   0,   0,   1,     -57976,      -63,    31429,     0,   -189,   -75; ...
           -1,   0,   2,   2,   2,     -59641,      -11,    25543,   -11,    149,    66; ...
            1,   0,   2,   0,   1,     -51613,      -42,    26366,     0,    129,    78; ...
           -2,   0,   2,   0,   1,      45893,       50,   -24236,   -10,     31,    20; ...
            0,   0,   0,   2,   0,      63384,       11,    -1220,     0,   -150,    29; ...
            0,   0,   2,   2,   2,     -38571,       -1,    16452,   -11,    158,    68; ...
           -2,   0,   0,   2,   0,     -47722,        0,      477,     0,    -18,   -25; ...
            2,   0,   2,   0,   2,     -31046,       -1,    13238,   -11,    131,    59; ...
            1,   0,   2,  -2,   2,      28593,        0,   -12338,    10,     -1,    -3; ...
           -1,   0,   2,   0,   1,      20441,       21,   -10758,     0,     10,    -3; ...
            2,   0,   0,   0,   0,      29243,        0,     -609,     0,    -74,    13; ...
            0,   0,   2,   0,   0,      25887,        0,     -550,     0,    -66,    11; ...
            0,   1,   0,   0,   1,     -14053,      -25,     8551,    -2,     79,   -45; ...
           -1,   0,   0,   2,   1,      15164,       10,    -8001,     0,     11,    -1; ...
            0,   2,   2,  -2,   2,     -15794,       72,     6850,   -42,    -16,    -5; ...
            0,   0,  -2,   2,   0,      21783,        0,     -167,     0,     13,    13; ...
            1,   0,   0,  -2,   1,     -12873,      -10,     6953,     0,    -37,   -14; ...
            0,  -1,   0,   0,   1,     -12654,       11,     6415,     0,     63,    26; ...
           -1,   0,   2,   2,   1,     -10204,        0,     5222,     0,     25,    15; ...
            0,   2,   0,   0,   0,      16707,      -85,      168,    -1,    -10,    10; ...
            1,   0,   2,   2,   2,      -7691,        0,     3268,     0,     44,    19; ...
           -2,   0,   2,   0,   0,     -11024,        0,      104,     0,    -14,     2; ...
            0,   1,   2,   0,   2,       7566,      -21,    -3250,     0,    -11,    -5; ...
            0,   0,   2,   2,   1,      -6637,      -11,     3353,     0,     25,    14; ...
            0,  -1,   2,   0,   2,      -7141,       21,     3070,     0,      8,     4; ...
            0,   0,   0,   2,   1,      -6302,      -11,     3272,     0,      2,     4; ...
            1,   0,   2,  -2,   1,       5800,       10,    -3045,     0,      2,    -1; ...
            2,   0,   2,  -2,   2,       6443,        0,    -2768,     0,     -7,    -4; ...
           -2,   0,   0,   2,   1,      -5774,      -11,     3041,     0,    -15,    -5; ...
            2,   0,   2,   0,   1,      -5350,        0,     2695,     0,     21,    12; ...
            0,  -1,   2,  -2,   1,      -4752,      -11,     2719,     0,     -3,    -3; ...
            0,   0,   0,  -2,   1,      -4940,      -11,     2720,     0,    -21,    -9; ...
           -1,  -1,   0,   2,   0,       7350,        0,      -51,     0,     -8,     4; ...
            2,   0,   0,  -2,   1,       4065,        0,    -2206,     0,      6,     1; ...
            1,   0,   0,   2,   0,       6579,        0,     -199,     0,    -24,     2; ...
            0,   1,   2,  -2,   1,       3579,        0,    -1900,     0,      5,     1; ...
            1,  -1,   0,   0,   0,       4725,        0,      -41,     0,     -6,     3; ...
           -2,   0,   2,   0,   2,      -3075,        0,     1313,     0,     -2,    -1; ...
            3,   0,   2,   0,   2,      -2904,        0,     1233,     0,     15,     7; ...
            0,  -1,   0,   2,   0,       4348,        0,      -81,     0,    -10,     2; ...
            1,  -1,   2,   0,   2,      -2878,        0,     1232,     0,      8,     4; ...
            0,   0,   0,   1,   0,      -4230,        0,      -20,     0,      5,    -2; ...
           -1,  -1,   2,   2,   2,      -2819,        0,     1207,     0,      7,     3; ...
           -1,   0,   2,   0,   0,      -4056,        0,       40,     0,      5,    -2; ...
            0,  -1,   2,   2,   2,      -2647,        0,     1129,     0,     11,     5; ...
           -2,   0,   0,   0,   1,      -2294,        0,     1266,     0,    -10,    -4; ...
            1,   1,   2,   0,   2,       2481,        0,    -1062,     0,     -7,    -3; ...
            2,   0,   0,   0,   1,       2179,        0,    -1129,     0,     -2,    -2; ...
           -1,   1,   0,   1,   0,       3276,        0,       -9,     0,      1,     0; ...
            1,   1,   0,   0,   0,      -3389,        0,       35,     0,      5,    -2; ...
            1,   0,   2,   0,   0,       3339,        0,     -107,     0,    -13,     1; ...
           -1,   0,   2,  -2,   1,      -1987,        0,     1073,     0,     -6,    -2; ...
            1,   0,   0,   0,   2,      -1981,        0,      854,     0,      0,     0; ...
           -1,   0,   0,   1,   0,       4026,        0,     -553,     0,   -353,  -139; ...
            0,   0,   2,   1,   2,       1660,        0,     -710,     0,     -5,    -2; ...
           -1,   0,   2,   4,   2,      -1521,        0,      647,     0,      9,     4; ...
           -1,   1,   0,   1,   1,       1314,        0,     -700,     0,      0,     0; ...
            0,  -2,   2,  -2,   1,      -1283,        0,      672,     0,      0,     0; ...
            1,   0,   2,   2,   1,      -1331,        0,      663,     0,      8,     4; ...
           -2,   0,   2,   2,   2,       1383,        0,     -594,     0,     -2,    -2; ...
           -1,   0,   0,   0,   2,       1405,        0,     -610,     0,      4,     2; ...
            1,   1,   2,  -2,   2,       1290,        0,     -556,     0,      0,     0; ...
           -2,   0,   2,   4,   2,      -1214,        0,      518,     0,      5,     2; ...
           -1,   0,   4,   0,   2,       1146,        0,     -490,     0,     -3,    -1];
    
    % transpose xnut matrix
    
    xnut = xnut';
    
    % reset flag
    
    inutate = 0;
    
end

% compute time argument in julian centuries since j2000

t = (jdate - 2451545.0) / 36525.0;

% compute fundamental trig arguments

[el, elp, f, d, om] = funarg (t);

dpsi = 0.0d0;

deps = 0.0d0;

% sum nutation series terms

for i = 78: -1: 1
    
    arg = xnut(1, i) * el ...
        + xnut(2, i) * elp ...
        + xnut(3, i) * f ...
        + xnut(4, i) * d ...
        + xnut(5, i) * om;
    
    dpsi = (xnut(6, i) + xnut(7, i) * t) * sin(arg) ...
        + xnut(10, i) * cos(arg) + dpsi;
    
    deps = (xnut(8, i) + xnut(9, i) * t) * cos(arg) ...
        + xnut(11, i) * sin(arg) + deps;
    
end

% convert nutations to arc seconds

dpsi = 1.0d-7 * dpsi;

deps = 1.0d-7 * deps;

% include planetary bias terms (arc seconds)

dpsi = dpsi - 0.0015835;

deps = deps + 0.0016339;



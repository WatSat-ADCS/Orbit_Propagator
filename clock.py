#
# Clock for Orbit propagator simulation
#
# Copyright (c) 2015 WatSat-ADCS
# Licensed under the MIT license.
#
# authors: Jason Pye (j2pye@uwaterloo.ca)
#
# Change log:
# 2015-10-02 (JP) - Initial release
#

from math import floor

clock_filename = "dat/jdate.txt"


def readClock():

  try:
    clock_file = open(clock_filename,'r')
  except IOError:
    print "Error opening for reading:", clock_filename
    return

  clock_time = float( clock_file.read() )
  clock_file.close()

  return clock_time


def writeClock(new_time):

  try:
    clock_file = open(clock_filename,'w')
  except IOError:
    print "Error opening for writing:", clock_filename
    return

  clock_file.write( '%.5f' % new_time )
  clock_file.close()

  return


def resetClock():
  writeClock(2451725.0349421296)
  return


def tickClock(dt):
  writeClock( readClock() + dt )
  return


def greg2jdate(year,month,day,hour,minute,second):

  # From Wikipedia
  a = floor((14-month)/12)
  y = year + 4800 - a
  m = month + 12*a - 3
  JDN = day + floor((153*m+2)/5) + 365*y + floor(y/4) - floor(y/100) + floor(y/400) - 32045
  JD = JDN + (hour-12.0)/24.0 + minute/1440.0 + second/86400.0

  return JD


def jdate2greg(jdate):

  # From Wikipedia
  y = 4716
  j = 1401
  m = 2
  n = 12
  r = 4
  p = 1461
  v = 3
  u = 5
  s = 153
  w = 2
  B = 274277
  C = -38

  JDN = floor(jdate)
  hour = int( floor( 24*( jdate - JDN ) ) + 12 )
  minute = int( floor( 1440*( jdate - JDN - (hour-12.0)/24.0 ) ) )
  second = int( floor( 86400*( jdate - JDN - (hour-12.0)/24.0 - minute/1440.0 ) ) )
  
  f = JDN + j + floor( ( floor((4*JDN + B)/146097) * 3 )/4 ) + C
  e = r*f + v
  g = floor( (e%p)/r )
  h = u*g + w

  day = int( floor( (h%s)/u ) + 1 )
  month = int( ( floor(h/s) + m )%(n) + 1 )
  year = int( floor(e/p) - y + floor( (n+m-month)/n ) )

  return {'year':year, 'month':month, 'day':day, 'hour':hour, 'minute':minute, 'second':second}


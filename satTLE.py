#
# Manages TLE data
#
# Copyright (c) 2015 WatSat-ADCS
# Licensed under the MIT license.
#
# authors: Jason Pye (j2pye@uwaterloo.ca)
#
# Change log:
# 2015-10-02 (JP) - Initial release
#

from clock import readClock, jdate2greg
from sgp4.earth_gravity import wgs72
from sgp4.io import twoline2rv

est_filename = "dat/tle_estimate.txt"
init_filename = "dat/tle_init.txt"

def readTLE(filename):

  try:
    tle_file = open(filename, 'r')
  except IOError:
    print "Error opening for reading:", tle_file
    return

  line1 = ''
  line2 = ''
  for line in tle_file:
    if (line[0] == '1'):
      line1 = line
    elif (line[0] == '2'):
      line2 = line
      if (line1 != ''):
        break

  tle_file.close()

  line1 = line1.rstrip('\n')
  line2 = line2.rstrip('\n')

  return line1, line2


def writeTLE(filename,line1,line2):

  try:
    tle_file = open(filename, 'w')
  except IOError:
    print "Error opening for writing:", tle_file
    return

  tle_file.write(line1)
  tle_file.write('\n')
  tle_file.write(line2)
  tle_file.write('\n')

  tle_file.close()

  return


def resetTLE():

  init_line1, init_line2 = readTLE(init_filename)
  writeTLE(est_filename, init_line1, init_line2)

  return


def currentOrbitState():

  jdate = readClock()
  gregdate = jdate2greg(jdate)

  init_line1, init_line2 = readTLE(est_filename)


  init_state = twoline2rv(init_line1, init_line2, wgs72)
  position, velocity = init_state.propagate(gregdate['year'],gregdate['month'],gregdate['day'],gregdate['hour'],gregdate['minute'],gregdate['second'])

  # todo: write new TLE to state estimate

  return position, velocity


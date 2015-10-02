#
# Tests for functions in clock.py
#
# Copyright (c) 2015 WatSat-ADCS
# Licensed under the MIT license.
#
# authors: Jason Pye (j2pye@uwaterloo.ca)
#
# Change log:
# 2015-10-02 (JP) - Initial release
#

import unittest
import clock

class testClock(unittest.TestCase):

  def test_readClock(self):
    self.assertIsNotNone( clock.readClock() )

  def test_writeClock(self):
    new_time = 1234.567890
    clock.writeClock(new_time)
    self.assertEqual(clock.readClock(), new_time)

  def test_resetClock(self):
    clock.resetClock()
    self.assertEqual(clock.readClock(), 2451725.03494)

  def test_tickClock(self):
    dt = 1
    init_time = clock.readClock()
    clock.tickClock(dt)
    self.assertEqual(clock.readClock(), init_time + dt)

  def test_greg2jdate(self):
    greg_year = 2000
    greg_month = 1
    greg_day = 1
    greg_hour = 12
    greg_minute = 00
    greg_second = 00
    jdate = 2451545.0
    self.assertEqual( '%.5f' % clock.greg2jdate(greg_year,greg_month,greg_day,greg_hour,greg_minute,greg_second), '%.5f' % jdate)

  def test_jdate2greg(self):
    greg_year = 2000
    greg_month = 1
    greg_day = 1
    greg_hour = 12
    greg_minute = 00
    greg_second = 00
    jdate = 2451545.0

    converted_greg = clock.jdate2greg(jdate)
    self.assertEqual(converted_greg['year'], greg_year)
    self.assertEqual(converted_greg['month'], greg_month)
    self.assertEqual(converted_greg['day'], greg_day)
    self.assertEqual(converted_greg['hour'], greg_hour)
    self.assertEqual(converted_greg['minute'], greg_minute)
    self.assertEqual(converted_greg['second'], greg_second)


if __name__ == '__main__':
  unittest.main()


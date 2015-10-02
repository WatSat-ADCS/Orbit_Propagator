#
# Tests for functions in satTLE.py
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
import satTLE

est_filename = "dat/tle_estimate.txt"
init_filename = "dat/tle_init.txt"

class testPropagator(unittest.TestCase):

  def test_readTLE(self):
    line1, line2 = satTLE.readTLE(est_filename)
    self.assertIsNotNone(line1)
    self.assertIsNotNone(line2)

  def test_writeTLE(self):
    init_line1, init_line2 = satTLE.readTLE(init_filename)
    satTLE.writeTLE(est_filename, init_line1, init_line2)
    new_line1, new_line2 = satTLE.readTLE(est_filename)
    self.assertEqual(new_line1, init_line1)
    self.assertEqual(new_line2, init_line2)

  def test_resetTLE(self):
    init_line1, init_line2 = satTLE.readTLE(init_filename)
    satTLE.writeTLE(est_filename, init_line1, init_line2)
    new_line1, new_line2 = satTLE.readTLE(est_filename)
    self.assertEqual(new_line1, init_line1)
    self.assertEqual(new_line2, init_line2)

  def test_currentOrbitState(self):
    clock_time = 2451725.03494
    position, velocity = satTLE.currentOrbitState()
    self.assertIsNotNone( position )
    self.assertIsNotNone( velocity )


if __name__ == '__main__':
  unittest.main()


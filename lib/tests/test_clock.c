/*
  Tests for functions in clock.c

  Copyright (c) 2015 WatSat-ADCS
  Licensed under the MIT license.

  authors: Jason Pye (j2pye@uwaterloo.ca)

  Change log:
  2015-12-02 (JP) - Initial release
*/

#include <check.h>
#include <stdio.h>
#include <stdlib.h>
#include "clock.h"

const char clock_filename[] = "../../dat/jdate.txt";

/*===== TESTS =====*/

START_TEST (test_readClock) {

  double jdate = -1;
  char str_jdate[100];

  jdate = readClock(clock_filename);
  sprintf( str_jdate, "%.5lf", jdate );

  ck_assert( jdate > 0 );
  ck_assert_str_ne( str_jdate, "" );

} END_TEST


START_TEST (test_writeClock) {

  double new_time = 12345.12345;
  writeClock(clock_filename, new_time);
  ck_assert( readClock(clock_filename) == new_time );

} END_TEST


START_TEST (test_resetClock) {

  double DEFAULT_TIME = 2451725.03494;
  resetClock(clock_filename);
  ck_assert( readClock(clock_filename) == DEFAULT_TIME );

} END_TEST


START_TEST (test_tickClock) {

  double dt = 1.;
  double init_time = readClock(clock_filename);
  tickClock(clock_filename, dt);
  ck_assert( readClock(clock_filename) == init_time + dt );

} END_TEST




/*===== SUITE =====*/

#define SUITE_NAME "Clock"

Suite * create_suite() {

  Suite *s = suite_create(SUITE_NAME);

  TCase *tc_core = tcase_create("Core");
  tcase_add_test(tc_core, test_readClock);
  tcase_add_test(tc_core, test_writeClock);
  tcase_add_test(tc_core, test_resetClock);
  tcase_add_test(tc_core, test_tickClock);
  suite_add_tcase(s, tc_core);

  return s;
}


int main() {

  int num_fail;
  Suite *s = create_suite();
  SRunner *sr = srunner_create(s);
  srunner_run_all(sr, CK_NORMAL);
  num_fail = srunner_ntests_failed(sr);
  srunner_free(sr);

  return (num_fail == 0) ? EXIT_SUCCESS : EXIT_FAILURE;

}

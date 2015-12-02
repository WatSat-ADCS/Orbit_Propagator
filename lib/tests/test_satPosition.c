/*
  Tests for functions in satPosition.c

  Copyright (c) 2015 WatSat-ADCS
  Licensed under the MIT license.

  authors: Jason Pye (j2pye@uwaterloo.ca)

  Change log:
  2015-12-02 (JP) - Initial release
*/

#include <check.h>
#include <stdio.h>
#include <stdlib.h>
#include "satPosition.h"

const char clock_filename[] = "../../dat/jdate.txt";
const char initTLE_filename[] = "../../dat/tle_init.txt";
const char estRV_filename[] = "../../dat/rv_est.txt";
const char estCOE_filename[] = "../../dat/coe_est.txt";

/*===== TESTS =====*/

START_TEST (test_readTLE) {

  char tleline1[130], tleline2[130];
  readTLE(initTLE_filename
  
} END_TEST


START_TEST (test_writeTLE) {

} END_TEST


START_TEST (test_resetTLE) {

} END_TEST


START_TEST (test_currentOrbitState) {

} END_TEST




/*===== SUITE =====*/

#define SUITE_NAME "Satellite Position"

Suite * create_suite() {

  Suite *s = suite_create(SUITE_NAME);

  TCase *tc_core = tcase_create("Core");
  tcase_add_test(tc_core, test_readTLE);
  tcase_add_test(tc_core, test_writeTLE);
  tcase_add_test(tc_core, test_resetTLE);
  tcase_add_test(tc_core, test_currentOrbitState);
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

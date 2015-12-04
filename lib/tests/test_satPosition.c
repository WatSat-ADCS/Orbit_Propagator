/*
  Tests for functions in satPosition.c

  Copyright (c) 2015 WatSat-ADCS
  Licensed under the MIT license.

  authors: Jason Pye (j2pye@uwaterloo.ca)

  Change log:
  2015-12-03 (JP) - Initial release
*/

#include <check.h>
#include <stdio.h>
#include <stdlib.h>
#include "satPosition.h"

const char clock_filename[] = "../../dat/jdate.txt";
const char initTLE_filename[] = "../../dat/tle_init.txt";
const char estRV_filename[] = "../../dat/rv_est.txt";

/*===== TESTS =====*/

START_TEST (test_readRV) {

  double rvtime, posn[3], vel[3];
  readRV(estRV_filename, &rvtime, posn, vel);


  char str_rvtime[100], str_posn[3][100], str_vel[3][100];

  sprintf( str_rvtime, "%.5lf", rvtime );
  int i;
  for (i = 0; i < 3; i++) {
    sprintf( str_posn[i], "%.5lf", posn[i] );
    sprintf( str_vel[i], "%.5lf", vel[i] );
  }

  ck_assert_str_ne( str_rvtime, "" );
  for (i = 0; i < 3; i++) {
    ck_assert_str_ne( str_posn[i], "" );
    ck_assert_str_ne( str_vel[i], "" );
  }

} END_TEST


START_TEST (test_writeRV) {

  double rvtime_w = (double) rand();
  double rvtime_r;
  double posn_w[3] = { (double) rand(), (double) rand(), (double) rand() };
  double posn_r[3];
  double vel_w[3] = { (double) rand(), (double) rand(), (double) rand() };
  double vel_r[3];

  writeRV(estRV_filename, rvtime_w, posn_w, vel_w);
  readRV(estRV_filename, &rvtime_r, posn_r, vel_r);

  ck_assert( rvtime_r == rvtime_w );
  int i;
  for (i = 0; i < 3; i++) {
    ck_assert( posn_r[i] == posn_w[i] );
    ck_assert( vel_r[i] == vel_w[i] );
  } 

} END_TEST


START_TEST (test_resetRV) {

  resetRV(estRV_filename, initTLE_filename);

} END_TEST


START_TEST (test_currentOrbitState) {

  double rvtime, posn[3], vel[3];


  currentOrbitState( estRV_filename, initTLE_filename, clock_filename, &rvtime, posn, vel );


  char str_rvtime[100], str_posn[3][100], str_vel[3][100];

  sprintf( str_rvtime, "%.5lf", rvtime );
  int i;
  for (i = 0; i < 3; i++) {
    sprintf( str_posn[i], "%.5lf", posn[i] );
    sprintf( str_vel[i], "%.5lf", vel[i] );
  }

  ck_assert_str_ne( str_rvtime, "" );
  for (i = 0; i < 3; i++) {
    ck_assert_str_ne( str_posn[i], "" );
    ck_assert_str_ne( str_vel[i], "" );
  }

} END_TEST




/*===== SUITE =====*/

#define SUITE_NAME "Satellite Position"

Suite * create_suite() {

  Suite *s = suite_create(SUITE_NAME);

  TCase *tc_core = tcase_create("Core");
  tcase_add_test(tc_core, test_readRV);
  tcase_add_test(tc_core, test_writeRV);
  tcase_add_test(tc_core, test_resetRV);
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

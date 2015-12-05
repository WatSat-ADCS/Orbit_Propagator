/*
  Tests for init_tle.m

  Copyright (c) 2015 WatSat-ADCS
  Licensed under the MIT license.

  authors: Jason Pye (j2pye@uwaterloo.ca)

  Change log:
  2015-12-04 (JP) - Initial release
*/

#include <check.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#include "sgp4unit.h"
#include "sgp4io.h"
#include "sgp4ext.h"


const char initTLE_filename[] = "../tle_init.txt";

/*===== TESTS =====*/

START_TEST (test_initTLE) {

  // Read data from TLE file
  FILE *tle_fptr;
  tle_fptr = fopen( initTLE_filename, "r" );
  ck_assert_ptr_ne( tle_fptr, NULL );

  char tle_line1[130], tle_line2[130];
  fgets(tle_line1, 130, tle_fptr);
  fgets(tle_line2, 130, tle_fptr);

  fclose(tle_fptr);


  // Convert TLE data to RV data

  const gravconsttype GRAV_CONSTS = wgs72;
  elsetrec satrecord;
  double startmfe, stopmfe, deltamin;

  twoline2rv(tle_line1, tle_line2, 'v', 'm', 'i', GRAV_CONSTS, startmfe, stopmfe, deltamin, satrecord);

  double rvtime, posn[3], vel[3];
  sgp4( GRAV_CONSTS, satrecord, 0.0, posn, vel);
  rvtime = satrecord.jdsatepoch;

  //printf("\n\n%f\n\n", rvtime);
  ck_assert( rvtime != NAN );
  int i;
  for (i = 0; i < 3; i++) {
    //printf("\n\n%f\n\n", posn[i]);
    ck_assert( posn[i] != NAN );
    //printf("\n\n%f\n\n", vel[i]);
    ck_assert( vel[i] != NAN );
  }

} END_TEST


/*===== SUITE =====*/

#define SUITE_NAME "Test TLE file"

Suite * create_suite() {

  Suite *s = suite_create(SUITE_NAME);

  TCase *tc_core = tcase_create("Core");
  tcase_add_test(tc_core, test_initTLE);
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

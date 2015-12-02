/*
  Tests for functions in satPosition.c

  Copyright (c) 2015 WatSat-ADCS
  Licensed under the MIT license.

  authors: Jason Pye (j2pye@uwaterloo.ca)

  Change log:
  2015-10-?? (JP) - Initial release
*/

#include <check.h>


START_TEST (test_clock) {


} END_TEST


Suite* str_suite(void) {
  Suite *suite = suite_create("clock");
  TCase *tcase = tcase_create("case");
  tcase_add_test(tcase, test_clock);
  suite_add_tcase(suite, tcase);
  return suite;
}

int main(int argc, char *argv[]) {
  int number_failed;
  Suite *suite = str_suite();
  SRunner *runner = srunner_create(suite);
  srunner_run_all(runner, CK_NORMAL);
  number_failed = srunner_ntests_failed(runner);
  srunner_free(runner);
  return number_failed;
}

#define MAIN
#include "../main.c"
#include "test_framework.h"


void exampleTestA() {
    assert_int_equals(add(1,1),2);
}
void exampleTestB() {
    assert_int_equals(add(1,1),1);
}

void register_tests() {
    register_test(exampleTestA);
    register_test(exampleTestB);
}

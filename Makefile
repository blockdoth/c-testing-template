CFLAGS = -g -Wall -Werror -Wextra -Wno-unused-parameter -Wno-unused-variable -pedantic
LDFLAGS += -lpthread -lrt
OBJS = main.c
TEST_OBJS = tests/test.c tests/test_framework.h
#FEATURES= "-DSEQUENTIAL"

.PHONY: test valgrind submit clean

default: main

# === Create build dir ===
builddir:
	@mkdir -p "build"

# === Main ===
main: compile
	@./build/main

compile : $(OBJS) builddir
	@gcc $(OBJS) $(LDFLAGS) $(CFLAGS) $(FEATURES) -o build/main

valgrind: compile
	@valgrind --tool=memcheck ./build/main

# === Tests ===
compile_test : $(TEST_OBJS) builddir
	@gcc $(TEST_OBJS) $(LDFLAGS) $(CFLAGS) $(FEATURES) -o build/test_suite

tests: compile_test
	@echo "\n\\033[1;4m[Output]\\033[0m"
	@./build/test_suite | egrep  "failed|passed"
	@echo "\n\\033[31;1;4m[Errors]\\033[0m "
	@egrep -i -B1 "fault|segmentation" | sed -- "s/--//g"
	@exit $(.SHELLSTATUS)

valgrind_test: compile_test
	@valgrind --tool=memcheck ./build/test

# === Clean ===
clean:
	@-rm -rf ./build
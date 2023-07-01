all:
	$(MAKE) run --no-print-directory

build_opt:
	gcc -Wall -Wextra -std=c99 -pedantic -O3 *.c -I. -o main.out

build_debug:
	gcc -Wall -Wextra -std=c99 -pedantic -ggdb3 -O0 *.c -I. -o main.out

run:
	$(MAKE) build_opt --no-print-directory
	./main.out

memcheck:
	$(MAKE) build_debug --no-print-directory
	valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes --error-exitcode=1 ./main.out

cachecheck:
	$(MAKE) build_debug --no-print-directory
	valgrind --tool=cachegrind --branch-sim=yes --log-file=cache_log.txt --cachegrind-out-file=cache_bin.txt ./main.out

callgrind_profiling:
	$(MAKE) build_debug --no-print-directory
	valgrind --tool=callgrind --cache-sim=yes --branch-sim=yes --simulate-wb=yes --simulate-hwpref=yes --cacheuse=yes  --callgrind-out-file=callgrind_bin.txt ./main.out

gprof_profiling:
	gcc -Wall -Wextra -std=c99 -pedantic -ggdb3 -O0 -pg *.c -I. -o main.out
	./main.out
	gprof main.out gmon.out > gprof_log.txt

test_coverage:
	gcc -Wall -Wextra -std=c99 -pedantic -ggdb3 -O0 -fprofile-arcs -ftest-coverage *.c -I. -o main.out
	./main.out
	gcovr -r . --html --html-details -o test_coverage_report.html

xanalyze:
	clang --analyze -Xanalyzer -analyzer-output=text main.c -I.

clang_tidy_analyze:
	clang-tidy -checks=bugprone-*,clang-analyzer-*,cert-*,concurrency-*,misc-*,modernize-*,performance-*,readability-* --extra-arg=-I. *.c --

sanitizer_address:
	clang *.c -o main.out -I./ -fsanitize=address  -g
	./main.out

sanitizer_thread:
	clang *.c -o main.out -I./ -fsanitize=thread  -g
	./main.out

sanitizer_memory:
	clang *.c -o main.out -I./ -fsanitize=memory  -g
	./main.out

sanitizer_ub:
	clang *.c -o main.out -I./ -fsanitize=undefined  -g
	./main.out

sanitizer_dataflow:
	clang *.c -o main.out -I./ -fsanitize=dataflow  -g
	./main.out

sanitizer_controlflow:
	clang *.c -o main.out -I./ -fsanitize=cfi -fvisibility=hidden  -g -flto
	./main.out

sanitizer_stack:
	clang *.c -o main.out -I./ -fsanitize=safe-stack  -g
	./main.out

sanitizer:
	$(MAKE) clean --no-print-directory
	$(MAKE) sanitizer_address --no-print-directory
	$(MAKE) clean --no-print-directory
	$(MAKE) sanitizer_thread --no-print-directory
	$(MAKE) clean --no-print-directory
	$(MAKE) sanitizer_memory --no-print-directory
	$(MAKE) clean --no-print-directory
	$(MAKE) sanitizer_ub --no-print-directory
	$(MAKE) clean --no-print-directory
	$(MAKE) sanitizer_dataflow --no-print-directory
	$(MAKE) clean --no-print-directory
	$(MAKE) sanitizer_controlflow --no-print-directory
	$(MAKE) clean --no-print-directory
	$(MAKE) sanitizer_stack --no-print-directory

clean:
	rm -rf main.out
	rm -rf *.txt
	rm -rf gmon.out
	rm -rf *.gcda *.gcno
	rm -rf *.html
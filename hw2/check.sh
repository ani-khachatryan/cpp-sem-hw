#!/bin/bash

sanitize_check() {
	make debug > /dev/null
	./debug_main > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "Sanitize check OK"
		return 0;
	fi
	./debug_main
	return 1;
}

codestyle_check() {
	git diff -U0 --no-color --staged HEAD | clang-format-diff -p1		
}


benchmark_time() {
	start=$(date +%s.%N)
	make release > /dev/null
	./release_main > /dev/null 2>&1
	end=$(date +%s.%N)
	runtime=$(echo $end - $start | bc)
	echo "Benchmark time $runtime"
}

function main() {
	echo "Check main.cpp..."
	sanitize_check
	if [ $? -eq 1 ]; then
		echo "Go fix your code!!"
		return 1
	fi
	codestyle_check
	benchmark_time
}

main

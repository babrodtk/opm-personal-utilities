#!/usr/bin/env bash

set +e
script_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $script_dir/set_environment.sh
log_file="$script_dir/tests_`date -Imin`.log"

# Runs tests
function run_tests() {
	local module=$1
	local build_dir="$opm_git_dir/$module-build"
	cd $build_dir

	echo "===== $module =====" >> $log_file

	if [ -f Makefile ]; then
		make_targets=`make -qp | awk -F':' '/^[a-zA-Z0-9][^$#\/\t=]*:([^=]|$)/ {split($1,A,/ /);for(i in A)print A[i]}'`
		if [[ $make_targets =~ "tests" ]]; then
			make tests 2>&1 | tee -a $log_file
			echo "Tests run" >> $log_file
		elif [[ $make_targets =~ "test" ]]; then
			make test 2>&1 | tee -a $log_file
			echo "Tests run" >> $log_file
		else
			echo "Test make target not found, skipping tests." >>   $log_file
		fi
	else
		echo "No makefile found, skipping test";
	fi
}



for module in $modules; do
	run_tests $module
done

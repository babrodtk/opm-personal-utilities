#!/usr/bin/env bash

set +e
script_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $script_dir/set_environment.sh
log_file="$script_dir/cmake_`date -Imin`.log"

#build directory, and builds using cmake/make
function run_cmake() {
	local module=$1
	local src_dir="$opm_git_dir/$module"
	local build_dir="$opm_git_dir/$module-build"

	echo "===== $module =====" >> $log_file

	if [ -f $src_dir/CMakeLists.txt ]; then
		mkdir -p $build_dir
		cd $build_dir

		cmake -C ../opm-options.cmake $src_dir
		echo "Makefile generated" >> $log_file
	else
		echo "No CMakeLists.txt found, skipping build";
	fi
}

#Fetch and compile all the OPM modules
for module in $modules; do
	run_cmake $module
done

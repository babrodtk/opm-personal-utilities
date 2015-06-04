#!/usr/bin/env bash

set +e
script_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $script_dir/set_environment.sh
log_file="$log_dir/setup_build`date -Imin`.log"

function setup_build() {
	local config=$1
	local config_dir="$build_dir/$config"
	mkdir -p "$config_dir"

	echo "Setting up $config (`date`)" >> $log_file

	#Soft-link source directory
	for module in $modules; do
		ln -s "$opm_git_dir/$module" "$config_dir/$module"
	done
	
	#Copy cmake configuration file
	cp "$script_dir/opm-options.cmake" "$config_dir"
	echo "SET(CMAKE_BUILD_TYPE \"$config\" CACHE STRING \"Build type\")" >> $config_dir/opm-options.cmake

	#Soft-link make-file
	ln -s "$script_dir/Makefile" "$config_dir/Makefile"

	#Soft-link ert
	ln -s "$ert_git_dir/install" "$config_dir/ert"

	#Soft-link script dir
	ln -s "$script_dir" "$config_dir/scripts"

	#Run cmake
	$config_dir/scripts/run_cmake.sh
	echo "Done with $config (`date`)" >> $log_file
}


for config in $build_configurations; do
	setup_build $config
done

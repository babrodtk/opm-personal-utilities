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
		if [ ! -e "$config_dir/$module" ]; then
			ln -s "$opm_git_dir/$module" "$config_dir/$module"
		fi
	done
	
	#Copy cmake configuration files
	if [ ! -e "$config_dir/opm-options.cmake" ]; then
		ln -s "$script_dir/opm-options-common.cmake" "$config_dir/opm-options-common.cmake"
		ln -s "$script_dir/opm-options-$config.cmake" "$config_dir/opm-options-build-specific.cmake"
		cat "$config_dir/opm-options-common.cmake" "$config_dir/opm-options-build-specific.cmake" > "$config_dir/opm-options.cmake"
	fi

	#Soft-link make-file
	if [ ! -e "$config_dir/Makefile" ]; then
		ln -s "$script_dir/Makefile" "$config_dir/Makefile"
	fi

	#Soft-link ert
	if [ ! -e "$config_dir/ert" ]; then
		ln -s "$ert_git_dir/install" "$config_dir/ert"
	fi

	#Soft-link script dir
	if [ ! -e "$config_dir/scripts" ]; then
		ln -s "$script_dir" "$config_dir/scripts"
	fi

	#Run cmake
	$config_dir/scripts/run_cmake.sh
	echo "Done with $config (`date`)" >> $log_file
}


#First build ERT
$script_dir/build_ert_from_git.sh

#Then clone/update everything
$script_dir/clone_or_update.sh

#Finally, build in all configurations
for config in $build_configurations; do
	setup_build $config
done

#!/usr/bin/env bash

set +e
script_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $script_dir/set_environment.sh
log_file="$log_dir/fetch_`date -Imin`.log"

function clone_or_update() {
	local module=$1
	local origin_url="$git_origin_base/$module"
	local upstream_url="$git_upstream_base/$module"
	local src_dir="$opm_git_dir/$module"

	echo "===== $module =====" >> $log_file

	#If repository exists, go there
	if [ -d $src_dir ]; then
		echo "** Pulling origin" >> $log_file
		cd $src_dir
	#Else clone and add upstream remote
	else
		echo "** Cloning origin, then pulling upstream" >> $log_file
		git clone --recursive $origin_url $src_dir
		cd $src_dir
		git remote add upstream $upstream_url
		git remote set-url --push upstream no-pushing-allowed
	fi

	#Update with upstream
	git checkout master
	git remote update
	git pull upstream master

	echo "** Git pull complete" >> $log_file
	git status 2>&1 | tee -a $log_file
}


for module in $modules; do
	clone_or_update $module
done

#!/usr/bin/env bash

script_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $script_dir/set_environment.sh
set +e
set +x

commands="status"

if [[ $# > 0 ]]; then
	echo "Received $# arguments: $@"
	commands="$@"
fi

GREEN="$(tput setaf 2)"
RESET="$(tput sgr0)"

echo "${GREEN}Executing 'git $commands' for { $modules }${RESET}"

for module in $modules; do
	echo " "
	echo "${GREEN}*******${RESET}"
	echo "${GREEN}MODULE: ${module}${RESET}"
	echo "${GREEN}*******${RESET}"
	
	git -C "$opm_git_dir/$module" $commands
done
	

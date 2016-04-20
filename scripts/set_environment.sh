#!/usr/bin/env bash

#Script that sets up the environment for us

#Make sure that script exits on failure, and that all commands are printed
set -e
set -x

#Find location of this script
script_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
base_dir=`dirname $script_dir`

#Set GCC version, and set colors to use
export GCC_COLORS=1
export CC=/usr/bin/gcc-4.9
export CXX=/usr/bin/g++-4.9

#Set the default opm directories to use
opm_git_dir="$base_dir"
mkdir -p $opm_git_dir

ert_git_dir="$base_dir/ert"
mkdir -p $ert_git_dir

#build directory
build_dir="$base_dir/build"
mkdir -p $build_dir

#log dir
log_dir="$base_dir/logs"
mkdir -p $log_dir

#Set number of parallel jobs to use with make
export MAKEFLAGS="-j 9"

#Set which modules to compile
modules="\
opm-common \
opm-parser \
opm-material \
opm-core \
opm-grid \
opm-output \
opm-simulators \
opm-upscaling \
ResInsight"
#opm-porsol \
#opm-benchmarks \

git_upstream_base="git@github.com:OPM"
git_origin_base="git@github.com:babrodtk"

build_configurations="\
Release \
Debug \
Profile"

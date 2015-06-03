#!/usr/bin/env bash

#Script that sets up the environment for us

#Make sure that script exits on failure, and that all commands are printed
set -e
set -x

#Find location of this script
script_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

#Set GCC version, and set colors to use
export GCC_COLORS=1
export CC=/usr/bin/gcc-4.9
export CXX=/usr/bin/g++-4.9

#Set the default opm directories to use
opm_git_dir="$script_dir/.."
mkdir -p $opm_git_dir

ert_git_dir="$script_dir/../ert"
mkdir -p $ert_git_dir

#Set number of parallel jobs to use with make
export MAKEFLAGS="-j 3"

#Set which modules to compile
modules="\
opm-cmake \
opm-parser \
opm-core \
dune-cornerpoint \
opm-autodiff \
opm-polymer \
opm-material \
opm-porsol \
opm-upscaling \
opm-benchmarks \
ResInsight"

git_upstream_base="git@github.com:OPM"
git_origin_base="git@github.com:babrodtk"


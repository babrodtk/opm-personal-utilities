all: \
opm-parser \
opm-core \
dune-cornerpoint \
opm-autodiff \
opm-polymer \
opm-material \
opm-upscaling \
opm-benchmarks \
ResInsight 

help:
	echo "Usage: make <target>"
	echo " prereqs - install prerequisites"
	echo " cmake   - Run cmake"
	echo " update  - Run git pull for all repositories"
	echo " tests   - Run tests"
	echo " all     - Compile all modules"

clean:
	rm -rf opm-parser-build \
		opm-core-build \
		dune-cornerpoint-build \
		opm-autodiff-build \
		opm-polymer-build \
		opm-material-build \
		opm-upscaling-build \
		opm-benchmarks-build \
		ResInsight-build 

prereqs: 
	scripts/install_packages.sh
	scripts/build_ert_from_git.sh
	touch prereqs.make

cmake: 
	scripts/run_cmake.sh

update: 
	scripts/clone_or_update.sh

tests: 
	scripts/run_tests.sh

FORCE:

opm-parser: FORCE
	$(MAKE) -C opm-parser-build

opm-core: FORCE
	$(MAKE) -C opm-core-build

dune-cornerpoint: FORCE
	$(MAKE) -C dune-cornerpoint-build

opm-autodiff: FORCE
	$(MAKE) -C opm-autodiff-build

opm-polymer: FORCE
	$(MAKE) -C opm-polymer-build

opm-material: FORCE
	$(MAKE) -C opm-material-build

opm-porsol: FORCE
	$(MAKE) -C opm-porsol-build

opm-upscaling: FORCE
	$(MAKE) -C opm-upscaling-build

opm-benchmarks: FORCE
	$(MAKE) -C opm-benchmarks-build

ResInsight: FORCE
	$(MAKE) -C ResInsight-build



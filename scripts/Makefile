all: FORCE
	$(MAKE) -C opm-common-build 
	$(MAKE) -C opm-parser-build 
	$(MAKE) -C opm-material-build 
	$(MAKE) -C opm-output-build 
	$(MAKE) -C opm-core-build 
	$(MAKE) -C opm-grid-build 
	$(MAKE) -C opm-simulators-build 
	$(MAKE) -C opm-upscaling-build 
	$(MAKE) -C ResInsight-build 

help:
	echo "Usage: make <target>"
	echo " prereqs - install prerequisites"
	echo " cmake   - Run cmake"
	echo " update  - Run git pull for all repositories"
	echo " tests   - Run tests"
	echo " all     - Compile all modules"

clean: FORCE
	$(MAKE) -C opm-common-build clean
	$(MAKE) -C opm-parser-build clean
	$(MAKE) -C opm-material-build clean
	$(MAKE) -C opm-output-build clean
	$(MAKE) -C opm-core-build clean
	$(MAKE) -C opm-grid-build clean
	$(MAKE) -C opm-simulators-build clean
	$(MAKE) -C opm-upscaling-build clean
	$(MAKE) -C ResInsight-build clean

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


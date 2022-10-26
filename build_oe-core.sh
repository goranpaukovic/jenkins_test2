#!/bin/bash
git clone git://git.openembedded.org/bitbake bitbake
git checkout hardknott
cd bitbake
git checkout 1.50
cd ..
source ./oe-init-build-env build_test_dir
# bitbake build
bitbake core-image-minimal

#!/bin/bash

. /gscratch/csde/spack/spack/share/spack/setup-env.sh
spack load gcc@8.2.0
spack install -j1 gcc %gcc@8.2.0

#!/bin/bash

. /gscratch/csde/sjenness/spack/share/spack/setup-env.sh
# spack install -j1 gcc %gcc@8.1.0
spack install -j1 r %gcc@8.2.0

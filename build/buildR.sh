#!/bin/bash

. /gscratch/csde/spack/spack/share/spack/setup-env.sh
spack load gcc@9.2.0
spack install -j1 r %gcc@9.2.0

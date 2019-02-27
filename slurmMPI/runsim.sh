#!/bin/bash

#SBATCH --nodes=6
#SBATCH --ntasks-per-node=16
#SBATCH --time=00:30:00
#SBATCH --mem=50G

# . /suppscr/csde/sjenness/spack/share/spack/setup-env.sh
# module load gcc-8.2.0-gcc-8.1.0-sh54wqg
# module load r-3.5.1-gcc-8.2.0-b5gmgmg
# module load mpich-3.3-gcc-8.2.0-m6nvwan

module load icc_18-ompi_1.8.8
module load r_3.2.5

# module load icc_19-ompi_3.1.2
# module load r_3.5.1

mpirun -np 1 Rscript sim.R

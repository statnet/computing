#!/bin/bash 

## Job Name 
#SBATCH --job-name=slurm-test

## Nodes
#SBATCH --nodes=1

## Tasks per node
#SBATCH --ntasks-per-node=16

## Walltime
#SBATCH --time=1:00:00 

## E-mail notification
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=sjennes@emory.edu

## Memory per node
#SBATCH --mem=50G

## Specify the working directory
#SBATCH --workdir=/suppscr/csde/sjenness/slurm

. /suppscr/csde/sjenness/spack/share/spack/setup-env.sh
module load r-3.5.0-gcc-8.1.0-bcqjjkd
module load gcc-8.1.0-gcc-4.4.7-eaajvcy

Rscript sim.R

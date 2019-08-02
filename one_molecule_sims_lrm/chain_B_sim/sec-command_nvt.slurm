#!/bin/sh

#SBATCH --time=30:30:00
#SBATCH --ntasks=32
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --job-name=nvt-run
#SBATCH --output=gromacs-nvt-%j.out
#SBATCH --error=gromacs-nvt-%j.err
#SBATCH --nodes=2

module load gromacs

mpirun gmx_mpi mdrun -v -deffnm nvt -stepout 100000

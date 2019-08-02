#!/bin/sh

#SBATCH --time=30:30:00
#SBATCH --ntasks=32
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --job-name=ber-run
#SBATCH --output=gromacs-ber-%j.out
#SBATCH --error=gromacs-ber-%j.err
#SBATCH --nodes=2

module load gromacs

mpirun gmx_mpi mdrun -v -deffnm ber -stepout 100000

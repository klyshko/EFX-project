#!/bin/sh

#SBATCH --time=35:30:00
#SBATCH --ntasks=32
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --job-name=pr9-chainB
#SBATCH --output=gromacs-pr9-%j.out
#SBATCH --error=gromacs-pr9-%j.err
#SBATCH --nodes=2

module load gromacs

mpirun gmx_mpi convert-tpr -s pr8.tpr -extend 75000 -o pr9.tpr 
mpirun gmx_mpi mdrun -v -s pr9.tpr -cpi pr2.cpt -deffnm pr2 -append -stepout 100000

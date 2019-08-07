#!/bin/sh

#SBATCH --time=35:30:00
#SBATCH --ntasks=32
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --job-name=pr3-chainB
#SBATCH --output=gromacs-pr3-%j.out
#SBATCH --error=gromacs-pr3-%j.err
#SBATCH --nodes=2

module load gromacs

mpirun gmx_mpi convert-tpr -s pr2.tpr -extend 75000 -o pr3.tpr 
mpirun gmx_mpi mdrun -v -s pr3.tpr -cpi pr2.cpt -deffnm pr2 -append -stepout 100000

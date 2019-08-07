#!/bin/sh

#SBATCH --time=35:30:00
#SBATCH --ntasks=32
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --job-name=pr16-tot
#SBATCH --output=gromacs-pr16-%j.out
#SBATCH --error=gromacs-pr16-%j.err
#SBATCH --nodes=2

module load gromacs/5.1.4-cuda-7.5+intelmpi-5.1+intel-16.0

mpirun gmx_mpi convert-tpr -s pr15.tpr -extend 75000 -o pr16.tpr 
mpirun gmx_mpi mdrun -v -s pr16.tpr -cpi state.cpt -append -stepout 100000

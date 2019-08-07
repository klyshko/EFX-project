#!/bin/sh

#SBATCH --time=35:30:00
#SBATCH --ntasks=32
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --job-name=pr2-protA
#SBATCH --output=gromacs-pr2-%j.out
#SBATCH --error=gromacs-pr2-%j.err
#SBATCH --nodes=2

module load gromacs

mpirun gmx_mpi grompp -f md_ParrinelloRahman.mdp -c pr.gro -r pr.gro -t pr.cpt -p init.top -o pr2.tpr
mpirun gmx_mpi mdrun -v -deffnm pr2 -stepout 100000

#!/bin/sh

#SBATCH --time=30:30:00
#SBATCH --ntasks=32
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --job-name=pr
#SBATCH --output=gromacs-pr-%j.out
#SBATCH --error=gromacs-pr-%j.err
#SBATCH --nodes=2

module load gromacs

mpirun gmx_mpi grompp -f md_equil_ParrinelloRahman2.mdp -c ber.gro -r ber.gro -t ber.cpt -p init.top -o pr.tpr
mpirun gmx_mpi mdrun -v -deffnm pr -stepout 100000

#!/bin/sh

#SBATCH --time=00:10:00
#SBATCH --ntasks=32
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --job-name=em
#SBATCH --output=gromacs-em-%j.out
#SBATCH --error=gromacs-em-%j.err
#SBATCH --nodes=2

module load gromacs

mpirun gmx_mpi grompp -f em.mdp -c solvate_genion.pdb -p topol.top -o em.tpr

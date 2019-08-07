#!/bin/sh

#SBATCH --time=00:10:00
#SBATCH --ntasks=32
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --job-name=nvt
#SBATCH --output=gromacs-nvt-%j.out
#SBATCH --error=gromacs-nvt-%j.err
#SBATCH --nodes=2

module load gromacs

mpirun gmx_mpi grompp -f md_NVT.mdp -c dpos.gro -r dpos.gro -t dpos.cpt -p init.top -o nvt.tpr

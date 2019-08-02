#!/bin/sh

#SBATCH --time=00:10:00
#SBATCH --ntasks=32
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --job-name=pr
#SBATCH --output=gromacs-pr-%j.out
#SBATCH --error=gromacs-pr-%j.err
#SBATCH --nodes=2

module load gromacs

mpirun gmx_mpi grompp -f md_equil_ParrilloRahman2.mdp -c ber.gro -r ber.gro -t ber.cpt -p topol.top -o pr.tpr

#!/bin/sh

#SBATCH --time=00:10:00
#SBATCH --ntasks=32
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --job-name=ber
#SBATCH --output=gromacs-ber-%j.out
#SBATCH --error=gromacs-ber-%j.err
#SBATCH --nodes=2

module load gromacs

mpirun gmx_mpi grompp -f md_equil_Berendsen.mdp -c nvt.gro -r nvt.gro -t nvt.cpt -p init.top -o ber.tpr

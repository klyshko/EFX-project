#!/bin/sh

#SBATCH --time=00:10:00
#SBATCH --ntasks=32
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --job-name=dpos-B
#SBATCH --output=gromacs-dpos-%j.out
#SBATCH --error=gromacs-dpos-%j.err
#SBATCH --nodes=2

module load gromacs/5.1.4-cuda-7.5+intelmpi-5.1+intel-16.0

mpirun gmx_mpi grompp -f md_DPOS_NVT.mdp -p init.top -c confout.gro -r confout.gro -o dpos.tpr

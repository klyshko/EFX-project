---
# Methods
---

## 1. Protein Crystal Preparation

### 1.1 Available structures

There are 4 pdb structures that are deposited to protein data bank as the result of the Rama's paper:
 - 5e11 (obtained at 289K with no E field - two alternative conformations A and B)
 - 5e22 (obtained at 289K with E field - two alternative conformations A and B as well as two assymetric units)
 - 5e21 (obtained at 277K with no E field - one single conformation)
 - 5e1y (obtained at 277K with no E field - three alternative conformations A, B and C (for only one residue))


> Note: Laue crystallography is the process when a stationary crystal is illuminated by a polychromatic X-Ray beam.
> Conventional crystallography is when the moving crystal is illuminated by a monochromatic beam of X-Rays.

Two structures at 277 where obtained at the other facility (at the Stanford Synchrotron Radiation Lightsource (SSRL, 11-1) using the PILATUS 6M PAD detector from a single crystal and indexed, integrated, scaled and merged in HKL2000). They were used as a reference to refine structures during EFX experiment, which are obtained at 289K (15C) with Laue crystallography.

### 1.2 Isolation of alternate conformations

Unfortunately, when analysing structural differences between all four pdbs, it's important to isolate alternative conformations, such as A and B. Overall I extracted 9 structures (index A, B or s indicate conformation A, B or single, respectively; E1, E2 or noE indicate the presence or absence of electric field and its direction):

- `277_noE_A`
- `277_noE_B`
- `277_noE_s`
- `289_noE_A`
- `289_noE_B`
- `289_E1_A`
- `289_E1_B`
- `289_E2_A`
- `289_E2_B`

### 1.3 Analysis of structural differences

 The RMSD analysis was performed in the jupyter notebook file [rmsd_analysis.ipynb](rmsd_analysis.ipynb). Here I look at the pairwise rmsd (in Å) between all nine structures taking into account common heavy atoms' positions. (All pdbs have different atom numbers and I had to find the set of common atoms)

 ![](pics/rmsd_heavy.png)

As expected, the biggest difference is between the conformation of two opposite electric field directions (1.1 Å). Although I expected much bigger difference. 

### 1.4 Choice of the structure for the simulation - `289_noE_A`

Further we decided to choose the structure collected in the absence of E-field at room temperature and use only alternate conformation A (it has higher occupancy 0.7 vs 0.3 of B); so we pick `289_noE_A` as initial structure for our equlibrium simulations. We assume that equilibration steps will eliminate any diffrence between A and B.

> Need to check it after we're done with the setup.


### 1.5 Design of the crystal

For the simulation of the crystal environment (in the presence and absence of E-field) we decided to use 3 systems: 


| One subunit of PDZ domain in water (Lauren)            |  The full 4-subunits crystal cell | 3x3x3 grid of 4-subunits crystal cells |
:-------------------------:|:-------------------------:|:-------------------------: 
![](pics/1_su.png) | ![](pics/1uc.png) | ![](pics/27uc.png) 


We need to analyze structural differences between all three approaches. The fixed protein in water is unlikely to behave as the protein in actual crystal since there are no crystal packing forces and flexible temini can move substantially. But it would be interesting to compare these results with the moren natural representation of the crystal - the system with water box dimensions of the same size as crystal unit cell's + periodic boundary conditions. This will presumably describe the protein crystal environment in greater details. 3x3x3 unit cells system is an attempt to describe a protein crystal in a way where the central unit cell doesn't see its periodic image and hencne is considered 'unbiased'. 

- The construction of the one crystal unit cell is done using [charm-gui](http://www.charmm-gui.org/) web-server. It allows to reconstruct the whole crystal cell from the pdb file and the symmetry group: all rotations and translations are applied automatically. The symmetry group for the `289_noE_A` structure in 5e11 is `C 1 2 1`.  
- The 3x3x3 crystal cell is constructed in the [uc_builder.ipynb](uc_builder.ipynb) script, by extending `a b c` crystallographic axes 3 times and conserving the $$ \alpha \beta \gamma $$ angles.



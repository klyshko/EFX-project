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

- '277_noE_A'
- '277_noE_B'
- '277_noE_s'
- '289_noE_A'
- '289_noE_B'
- '289_E1_A'
- '289_E1_B'
- '289_E2_A'
- '289_E2_B'

### 1.3 Analysis of structural differences

 The RMSD analysis was performed in the jupyter notebook file 'rmsd_analysis.ipynb'. Here I look at the pairwise rmsd (in Å) between all nine structures taking into account common heavy atoms' positions.

 ![](https://doc-0s-20-docs.googleusercontent.com/docs/securesc/l7mhmodi13shvjugmqegmp60593u1skd/onlsjb8d63uc58300ou22k98cab93m34/1563573600000/17081007517431872113/17081007517431872113/1Jh2NUkPl2ADhsSQIPPt8eKWIUkAP_n2s)

As expected, the biggest difference is between the conformation of two opposite electric field directions (1.1 Å). Although I expected much bigger difference. 

### 1.4 Choice of the structure for the simulation - '289_noE_A'

Further we decided to choose the structure collected in the absence of E-field in room temperature and use only conformation A (it has higher occupancy 0.7 vs 0.3); so we pick '289_noE_A' as initial structure for our equlibrium simulations. We assume that equilibration steps will eliminate any diffrence between A and B.

> Need to check it after we're done with the setup.


### 1.5 Design of the crystal


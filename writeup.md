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

- Single PDZ subunit is extracted from a pdb file by just leaving one of the subunits in a text editor.
- The construction of the one crystal unit cell is done using [charm-gui](http://www.charmm-gui.org/) web-server. It allows to reconstruct the whole crystal cell from the pdb file and the symmetry group: all rotations and translations are applied automatically. The symmetry group for the `289_noE_A` structure in 5e11 is `C 1 2 1`.
- The 3x3x3 crystal cell is then constructed in the [uc_builder.ipynb](uc_builder.ipynb) script, by extending `a, b, c` crystallographic axes 3 times and conserving the $\alpha, \beta, \gamma$ angles in the the full 4-subunits crystal cell file.  

> NB: VMD will not represent secondary structures for the pdb files that contain more than 77,000 atoms. Examples are these: [VMD-no-ss](charm-gui/78000_at_noss.pdb) and [VMD-ss](charm-gui/76000_at_ss.pdb). Using different visualizers (NGLView, PyMOL, Chimera) can solve the problem.

### 1.6 Importance of pdb hydrogens

Citation from Lauren's email: 

> By the way, I'm told that the hydrogens in the pdb are known as "riding hydrogens" - it's standard practice in crystallography to include them, as we "kind of know where they should be" and they explain some aspects of the electron density. And they are not entirely invisible to X-ray crystallography. (These are essentially direct quotes from Doeke, first author of the 2016 paper.) 
I think it's ok to ignore the riding hydrogens in the PDB and use the hydrogens which are automatically added in the simulation preparation since we minimize the structure before simulating anyway.


### 1.7 Importance of using crystal waters

Lauren and Mike Socolich, a research scientist in their lab who has done a lot with EFX, suggested to use the positions of crystal waters (i.e those oxygens resoved in the X-Ray crystallography and contained in pdb files) when building the crystal models. We assumed that their importance will be evident from the simulations and conducted a quantitative test where we looked at the positions occupied by crystal oxygens in the original pdb over the equlibrium simulation. Analysis of occupancy of these cites over the course of simulations is performed in [`crystal_water.ipynb`](crystal_water.ipynb) file. 

> **Algorithm description:** Firstly, I load the inital coordinates of crystal oxygens and memorise them. Secondly, at every time step I align current protein structure to the initial one and use these translation vector and rotational matrix to recalculate the positions of crystal water sites. Thirdly, I look at all bulk water oxygens and estimate how many of them are within the cutoff distance to crystal water sites. This will give me a percent of occupied crystal cites out of possible 376 for specific cutoff distance and specific time. The same procedure can be used for analysis how often some random bulk water sites (from initial gro file) are occupied. Lastly, we can compare how much often crystal water sites are occupied in comparison to random averaged over time... More details are in comment section of [`crystal_water.ipynb`](crystal_water.ipynb) file.

**Main results:**

- Occupancy of the crystal water sites vs random water sites (using alignment to initial structure and recalculating of the water coordinates, see the jupyter notebook comments) for a specific cutoff distance [1.0 Å]:

| Occupancy for each time step for each water site  - cutoff 1.0 Å |  Occupancy for each time step - cutoff 1.0 Å|
:-------------------------:|:-------------------------:
![](pics/timeseries.png) | ![](pics/occ1a.png) 

- Occupancy of the crystal water sites vs random water sites averaged over time for a range of cutoff distances:

![](pics/occupancy.png)  



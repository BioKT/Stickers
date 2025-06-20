## Scripts for the analysis of PHE/TYR peptide condensates:
This repository includes code required to replicate the results
on amino acid sticker strenghts within peptide condensates.

Publication: 
* David De Sancho, Xabier López (2025). **Crossover in Aromatic Amino Acid Interaction Strength: Tyrosine vs. Phenylalanine in Biomolecular Condensates**. *eLife* **14**:RP104950 DOI: [10.7554/eLife.104950.1](https://doi.org/10.7554/eLife.104950.1)

### Analysis scripts
#### SASA
* `calc_sasa.sh`

#### Density profiles
* `calc_density_replicates.sh`: Calculates density profiles in
GSY/GSF condensates.

#### Dipoles
* `calc_dipole.sh`: Calculates dipole constant in different solutions.
* `analysis_dipoles.sh`: Plots dipole convergence from simulations. 

### Other analysis and visualization
* `analysis_dense_revision.ipynb`: Notebook for analysis of density
profiles and torsion angles in GSY/GSF condensates.
* `analysis_interactions.ipynb`:
* `analysis_remd_setup.ipynb`: Notebook for the analysis of equilibration of REMD for GSY and GSF condensates.
* `analysis_remd.ipynb`: Notebook for the analysis of REMD results for GSY and GSF condensates.
* `analysis_solvents.ipynb`: Notebook for analysis of equilibration of pure solvents.

### Structure and topology files
#### Amino acids
* `gly_amber99sb-star-ildnTRUE.itp`
* `gly_amber99sb-star-ildnTRUE.top`
* `gly_amber99sb-star-ildnTRUE_posre.itp`
* `phe_amber99sb-star-ildnTRUE.itp`
* `phe_amber99sb-star-ildnTRUE.top`
* `phe_amber99sb-star-ildnTRUE_posre.itp`
* `ser_amber99sb-star-ildnTRUE.itp`
* `ser_amber99sb-star-ildnTRUE.top`
* `ser_amber99sb-star-ildnTRUE_posre.itp`
* `tyr_amber99sb-star-ildnTRUE.itp`
* `tyr_amber99sb-star-ildnTRUE.top`
* `tyr_amber99sb-star-ildnTRUE_posre.itp`

#### GSY condensate
* `GGFGG_soupF_XXXL_amber99sb-star-ildnTRUE.top`
* `GGFGG_soupF_XXXL_amber99sb-star-ildnTRUE_tip3p_rep0.top`
* `GGFGG_soupF_XXXL_amber99sb-star-ildnTRUE_tip3p_rep1.top`
* `GGFGG_soupF_XXXL_amber99sb-star-ildnTRUE_tip3p_rep2.top`

#### GSF condensate
* `GGFGG_soup_XXXL_amber99sb-star-ildnTRUE.top`
* `GGFGG_soup_XXXL_amber99sb-star-ildnTRUE_tip3p_rep0.top`
* `GGFGG_soup_XXXL_amber99sb-star-ildnTRUE_tip3p_rep1.top`
* `GGFGG_soup_XXXL_amber99sb-star-ildnTRUE_tip3p_rep2.top`

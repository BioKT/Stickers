# Stickers: Arginine vs Lysine sticker strength in LLPS

This repository contains the input files and analysis notebooks associated with our study of the relative strength of arginine (Arg) and lysine (Lys) as "sticker" residues in the context of liquid–liquid phase separation (LLPS).

## Reference

Armentia, L., López, X. and De Sancho, D. *Arginine versus Lysine: Molecular Determinants of Cation–π Interactions in Biomolecular Condensates*. bioRxiv 2025.10.01.679751. https://doi.org/10.1101/2025.10.01.679751

## Overview

We use alchemical free energy simulations (Lys → Arg mutations via PMX) to quantify the differential cation–π interaction strength of each residue with aromatic partners (Phe, Tyr). Simulations are run in multiple media — water and organic solvents of varying polarity — as well as in multi-peptide slab boxes to directly probe condensate-like environments.

## Repository Contents

### Topology files

Alchemical hybrid topologies for the `GGKGG` pentapeptide (Lys → Arg mutation):

- `GGKGG_amber99sb-star-ildn_mut.top` / `_posre.itp` — hybrid topology in vacuum
- `GGKGG_amber99sb-star-ildn_tip3p_mut.top` — in TIP3P water
- `GGKGG_amber99sb-star-ildn_tip3p_mut_neutral.top` / `_phys.top` — net-neutral and physiological (0.15 M NaCl) ion conditions
- `GGKGG_amber99sb-star-ildn_octanol.top` / `_acetone.top` / `_cyclohexane.top` — in organic solvents

Multi-peptide slab topologies:

- `GGKGG_soup_XXXL_amber99sb-star-ildn*.top` — slab of GGKGG peptides (without aromatic partner)
- `GGKGG_soupF_XXXL_amber99sb-star-ildn*.top` — slab of GGKGG peptides with Phe aromatic partner; available for vacuum, TIP3P water, neutral and physiological conditions

Individual amino acid reference topologies (`amber99sb-star-ildn`): Gly, Phe, Tyr, Ser (`.itp`, `.top`, `_posre.itp`).

Solvent molecule parameters: `octanol.itp`, `acetone.itp`, `cyclohexane.itp`.

### Setup script

`setup_amber_pdb2gmx.sh` — generates GROMACS topologies from PDB structures using `gmx pdb2gmx` with the `amber99sb-star-ildn` force field.

### QM structures

`structures/` — PDB and XYZ files of optimised geometries for Arg–Phe, Arg–Tyr, Lys–Phe, and Lys–Tyr interaction pairs (T-shaped and parallel stacking configurations).

### Jupyter notebooks

| Notebook | Contents |
|---|---|
| `analysis_interactions.ipynb` | Quantify Arg/Lys–Phe/Tyr cation–π contacts and geometry from MD |
| `analysis_interactions_qm.ipynb` | Combine QM interaction energies with MD structural data |
| `analysis_rdf.ipynb` | Radial distribution functions between residue pairs |
| `qmanalysis.ipynb` | Parse and analyse Gaussian output files |
| `xyzconverter.ipynb` | Convert QM-optimised structures (XYZ) to PDB format |

### Data

`contacts_qm_df.csv` — compiled QM interaction energies and MD contact geometries for all residue pairs.

## Dependencies

- [GROMACS](https://www.gromacs.org/) — MD simulations
- [PMX](https://github.com/deGrootLab/pmx) — Lys → Arg alchemical mutation
- [Gaussian](https://gaussian.com/) — QM calculations
- Python (NumPy, MDTraj, matplotlib, pandas) — analysis notebooks

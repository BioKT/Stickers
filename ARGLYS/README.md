# Stickers: Arginine vs Lysine sticker strength in LLPS

This repository contains the input files, setup scripts, and analysis notebooks associated with our study of the relative strength of arginine (Arg) and lysine (Lys) as "sticker" residues in the context of liquid–liquid phase separation (LLPS).

## Reference

De Sancho, D. *Arginine, not lysine, is the stronger sticker residue in biomolecular condensates*. bioRxiv (2024). https://doi.org/10.1101/2024.10.18.619001

## Overview

We use alchemical free energy simulations (Lys → Arg mutations via PMX) to quantify the differential interaction strength of each residue with aromatic partners (Phe, Tyr). Simulations are run in multiple media — water, organic solvents of varying polarity, and multi-peptide slab boxes — to decompose the transfer and interaction components of sticker strength.

**Peptide systems:**
- `GG{K/R}GG` — single cationic residue flanked by Gly, used for solvent-transfer and alchemical free energy calculations
- `G{K/R}GG{F/Y}` — cationic residue paired with an aromatic partner, used in slab and REMD simulations

## Repository Contents

### Force field

`amber99sb-star-ildn-mut.ff/` — PMX-patched version of the `amber99sb-star-ildn` force field required for the hybrid Lys/Arg alchemical topology.

### Structure files

PDB structures for all simulated peptides (`GGKGG.pdb`, `GGRGG.pdb`, `GKGGF.pdb`, `GKGGY.pdb`, `GRGGF.pdb`, `GRGGY.pdb`) and individual amino acid reference structures (`lys.pdb`, `arg.pdb`).

### Topology files

Pre-built GROMACS topology files (`.top`, `.itp`) for all systems covering:
- Aqueous solvent (TIP3P water, physiological and net-neutral ion conditions)
- Organic solvents (octanol, benzene, cyclohexane, acetone, ethanol, methanol, hexanol, toluene)
- Biphasic coexistence boxes (`*COEX*`)
- Multi-peptide slab boxes (`*soup*`, `*soupF*`)

Solvent molecules are provided as standalone `.itp` files (`octanol.itp`, `benzene.itp`, `cyclohexane.itp`, `acetone.itp`).

### Setup scripts

| Script | Purpose |
|---|---|
| `setup_amber_pdb2gmx.sh` | Generate GROMACS topologies from PDB using `amber99sb-star-ildn` |
| `mutate.sh` | Apply Lys → Arg PMX mutation and regenerate hybrid topology |
| `setup_amber_equil.sh` | Equilibrate mutated peptide in water (EM → NVT → NPT) |
| `setup_amber_solvents.sh` | Solvate and equilibrate in organic solvents; build biphasic boxes |
| `setup_amber_soups.sh` | Set up multi-peptide slab boxes from PACKMOL structures |
| `setup_amber_replex.sh` | Prepare H-REMD runs across a temperature ladder |
| `setup_amber_tetra_equil.sh` | Equilibrate tetrapeptide systems with collective variables |
| `setup_amber_switch.sh` | Extract frames and run alchemical switching simulations |

### Analysis scripts

| Script | Purpose |
|---|---|
| `process.sh` | Post-process trajectories (`gmx trjconv`, PBC correction, decimation) |
| `calc_density.sh` / `calc_density_replex.sh` | Compute density profiles along the slab axis |
| `calc_sasa.sh` / `calc_sasa_replex.sh` | Compute solvent-accessible surface areas |
| `calc_gr.sh` | Compute radial distribution functions |
| `analysis_switch.sh` | Parse dhdl files from switching runs |

### Jupyter notebooks

| Notebook | Contents |
|---|---|
| `analysis_switch.ipynb` | Parse dhdl files; compute ΔG via BAR, Crooks, and Jarzynski estimators |
| `analysis_dense.ipynb` | Density profiles for slab simulations; identify phase boundaries |
| `analysis_replex.ipynb` | REMD trajectory analysis and SASA |
| `analysis_interactions.ipynb` | Quantify Arg/Lys–Phe/Tyr contacts and geometry from MD |
| `analysis_interactions_qm.ipynb` | Combine QM interaction energies with MD structural data |
| `analysis_rdf.ipynb` | Radial distribution functions between residue pairs |
| `qmanalysis.ipynb` | Parse and analyse Gaussian output files |
| `qm_fig_chargedneutral.ipynb` | Compare charged vs neutral QM calculations |
| `xyzconverter.ipynb` | Convert QM-optimised structures (xyz) to PDB format |

### QM input files

Gaussian input (`.gjf`) and output (`.log`) files for guanidinium geometry optimisations in vacuum and implicit solvent (PCM/SMD water) at multiple levels of theory (B3LYP, HF, wB97X-D / 6-311++G(d,p)).

### PACKMOL

`packmol/` — PACKMOL input files (`.inp`) and packed PDB structures for building the multi-peptide slab boxes.

### Colvars

`colvars.inp` / `colvars_template.inp` — NAMD Colvars input for metadynamics on the Cα contact number collective variable, used with the tetrapeptide slab systems.

### Results data

| File | Contents |
|---|---|
| `SOLVENTS.csv` | Dielectric constants and ΔG/ΔΔG values for each organic solvent (physiological) |
| `NEUTRAL_SOLVENTS.csv` | Same quantities for net-neutral ion conditions |
| `StickersKR_PHYS.csv` | ΔG and ΔΔG values for GSY and GSF slab systems (physiological) |
| `StickersKR_NEUTRAL.csv` | Same for net-neutral conditions |
| `DGt.dat` / `DGs.dat` / `DDGt.dat` | Transfer and solvation free energy tables |

### Figures

`figures/` — Publication-quality figures (PNG, SVG, EPS) covering the thermodynamic cycle, transfer free energies, density profiles, interaction geometries, and QM results.

## Dependencies

- [GROMACS](https://www.gromacs.org/) (tested with 2018+)
- [PMX](https://github.com/deGrootLab/pmx) — for Lys → Arg alchemical mutation
- [PACKMOL](http://leandro.iqm.unicamp.br/m3g/packmol/home.shtml) — for building multi-peptide boxes
- [Gaussian](https://gaussian.com/) — for QM calculations
- Python (NumPy, MDTraj, matplotlib) — for analysis notebooks

# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This project studies the relative sticker strengths of arginine (ARG) vs lysine (LYS) residues in the context of liquid-liquid phase separation (LLPS). The core scientific question is how well each residue interacts with aromatic "sticker" residues (Phe, Tyr). The approach uses alchemical free energy calculations (K→R mutations) in both aqueous and organic solvents, along with slab simulations of peptide "soups" for direct phase separation analysis.

**Key peptide systems:**
- `GG{K/R}GG` — single residue flanked by Gly (used in solvent transfer and alchemical FE)
- `G{K/R}GG{F/Y}` — paired sticker systems (used in slab/REMD simulations)
- `soup{F/R/K}_XXL` — many-peptide slab boxes for LLPS analysis

**Force field:** `amber99sb-star-ildn` with a custom PMX mutation variant (`amber99sb-star-ildn-mut.ff/`) for alchemical transformations.

## Simulation Workflow

Setup scripts in the root directory follow this pipeline:

1. **`setup_amber_pdb2gmx.sh`** — Generate GROMACS topology from PDB using `gmx pdb2gmx` with `amber99sb-star-ildn` force field. `GMXLIB` must point to PMX mutff45 directory.

2. **`mutate.sh`** — Use PMX to perform K→R alchemical mutation, then regenerate topology with `gmx pdb2gmx -ff amber99sb-star-ildn-mut`. Requires the `pmx` conda environment.

3. **`setup_amber_equil.sh`** — Equilibrate the mutated system in water: `editconf` → `solvate` → `genion` → EM (lambda 0 and 1) → NVT → NPT (Berendsen) → NPT (SD integrator). Runs both lambda endpoints in parallel.

4. **`setup_amber_solvents.sh`** — Same pipeline but in organic solvents (octanol, benzene, etc.) for transfer free energy calculations. Also contains commented-out code for biphasic (COEX) boxes.

5. **`setup_amber_soups.sh`** — Build multi-peptide slab boxes using PACKMOL-generated PDBs, then equilibrate using the same EM→NVT→NPT chain.

6. **`setup_amber_replex.sh`** — Prepare H-REMD (replica exchange) runs. Generates per-replica mdp files by substituting temperatures into a template, then runs `gmx grompp` for each replica.

7. **`setup_amber_switch.sh`** — Extract frames from production trajectories and run alchemical switching (`ti_l${lambda}_gmx2018.mdp`) for free energy estimates via Crooks/BAR.

### Analysis scripts

- **`process.sh`** — Post-process trajectories: `gmx trjconv` with `-pbc whole` and decimation (`-dt 50`)
- **`calc_density.sh`** — Compute density profiles along X-axis (`gmx density`) for slab systems; supports binned time-window analysis
- **`calc_sasa.sh`** / **`calc_sasa_replex.sh`** — Compute SASA (`gmx sasa`) for single-chain and REMD systems
- **`calc_gr.sh`** — Radial distribution functions (`gmx rdf`)
- **`analysis_switch.sh`** — Post-processes dhdl files from alchemical switching runs

### Jupyter notebooks

| Notebook | Purpose |
|---|---|
| `analysis_switch.ipynb` | Parse dhdl files, compute ΔG via BAR/Crooks/Jarzynski |
| `analysis_dense.ipynb` | Analyze slab density profiles, identify phase boundaries |
| `analysis_replex.ipynb` | Process REMD trajectories and SASA |
| `analysis_interactions.ipynb` | Quantify ARG/LYS–Phe/Tyr contacts from MD |
| `analysis_interactions_qm.ipynb` | Combine QM and MD interaction geometry data |
| `analysis_rdf.ipynb` | Analyze radial distribution functions |
| `qmanalysis.ipynb` | Analyze Gaussian QM output files |
| `qm_fig_chargedneutral.ipynb` | Compare charged vs neutral QM calculations |
| `xyzconverter.ipynb` | Convert QM-optimised structures (xyz) to PDB |

### Key data files

- `SOLVENTS.csv` / `NEUTRAL_SOLVENTS.csv` — Computed dielectric constants and ΔG/ΔΔG values for each solvent
- `StickersKR_PHYS.csv` / `StickersKR_NEUTRAL.csv` — Compiled sticker strength results
- `colvars.inp` / `colvars_template.inp` — NAMD Colvars input for metadynamics on Cα contact number (used with GRGGY/GKGGF slab systems)
- `DGt.dat`, `DGs.dat`, `DDGt.dat` — Transfer and solvation free energy data tables

## Key Naming Conventions

- File names encode system identity: `{peptide}_{soup/variant}_{ff}_{water}_{charge}_{lambda}_{stage}`
- Lambda endpoints: `l0` = reference state, `l1` = alchemical end state
- Charge states: `phys` = physiological (0.15 M NaCl), `neutral` = net-neutral only
- Soup variants: `soup_XXXL` = pure Lys/Arg peptide slab; `soupF_XXXL` = peptide + Phe aromatic partner
- Output from switches lands in `../data/switch/`; analysis outputs go to `../analysis/`

## Environment Requirements

- `GMXLIB=/home/david/Research/Projects/Simulation/PMX/mutff45` — required for alchemical topologies
- PMX mutations require the `pmx` conda environment
- Gaussian QM jobs (`.gjf`/`.log` files) use B3LYP, HF, and wB97XD with 6-311++G(d,p), in vacuum, PCM water, or SMD water
- PACKMOL inputs live in `packmol/` for building multi-peptide boxes

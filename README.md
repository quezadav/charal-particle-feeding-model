# Charal minimal particle model

This folder contains the final MATLAB scripts for the minimal particle model used to explore spatial and temporal feeding patterns in *Chirostoma humboldtianum*.

## Core idea

The model separates two spatial mechanisms:

1. **Spatial diffusion**: food affects gut fullness but not movement. This is the diffusion-only/null model.
2. **Spatial taxis**: food affects gut fullness and particle movement responds to the food gradient.

Gut fullness is represented by a dimensionless variable `G`, constrained to `0 <= G <= 1`.

## How to run

Open MATLAB in this folder and execute:

```matlab
clear; clc; close all
main
```

The script will create a `results/` folder containing:

- `core_scenarios.mat`
- `spatial_sweep_summary.csv`
- PNG figures for the core scenarios
- PNG figures for the spatial sweep

## Definitive sweep configuration

The definitive sweep uses:

```matlab
nRep = 30;
modes = {'diffusion','taxis'};
Hscale = [0 0.5 1 1.5 2 3];
sigma = [0.60 1.00 1.40];
```

Error bars in sweep figures correspond to one standard deviation across independent stochastic replicates.

## Obsolete file

Do not use `scenario_spatial_null.m`. It has been replaced by:

```matlab
scenario_spatial_diffusion.m
```

The term `null` was removed from the active workflow to avoid confusion with missing/null values in CSV files and to improve clarity.


Update v3: `update_particles.m` and `food_field.m` force particle arrays to column vectors to avoid row/column size incompatibilities across MATLAB versions.

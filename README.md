Charal minimal particle model
This repository contains the MATLAB scripts used to implement a minimal particle-based model for exploring spatial and temporal feeding mechanisms in Chirostoma humboldtianum.
The model was developed as a complementary computational framework inspired by an empirical study on the trophic ecology of the charal. It is not intended as a direct calibration or validation of the biological system, but as a minimal mechanistic model for comparing alternative movement and feeding assumptions.
Core idea
The model separates two spatial mechanisms:
Spatial diffusion: food affects gut fullness, but not movement.
Resource taxis: food affects gut fullness, and particle movement responds to the spatial gradient of the food field.
Gut fullness is represented by a dimensionless variable `G`, constrained to:
```matlab
0 <= G <= 1
```
Repository structure
The main scripts are organized as follows:
`main.m`: main execution script.
`default_parameters.m`: default model and simulation parameters.
`init_parameters.m`: initialization of particle states.
`scenario_control.m`: homogeneous control scenario.
`scenario_diurnal.m`: temporal forcing scenario.
`scenario_spatial_diffusion.m`: spatial diffusion scenario.
`scenario_spatial_taxis.m`: resource taxis scenario.
`scenario_spatial.m`: shared spatial scenario constructor.
`food_field.m`: trophic field definition.
`update_particles.m`: particle position and gut-fullness update.
`apply_boundary.m`: boundary condition handling.
`run_simulation.m`: single simulation runner.
`run_replicates.m`: stochastic replicate runner.
`run_spatial_sweep.m`: spatial parameter sweep.
`analyze_results.m`: core scenario analysis and figures.
`analyze_diurnal_vs_control.m`: diurnal-control comparison.
`analyze_spatial_sweep.m`: sweep analysis and figures.
`save_current_figure.m`: figure export utility.
How to run
Open MATLAB in this folder and execute:
```matlab
clear; clc; close all
main
```
The script creates a `results/` folder containing:
`core_scenarios.mat`
`spatial_sweep_summary.csv`
PNG figures for the core scenarios
PNG figures for the spatial parameter sweep
Parameter sweep configuration
The parameter sweep used in the manuscript is:
```matlab
nRep = 30;
modes = {'diffusion','taxis'};
Hscale = [0 0.5 1 1.5 2 3];
sigma = [0.60 1.00 1.40];
```
Error bars in the sweep figures correspond to one standard deviation across independent stochastic replicates.
Reproducibility note
The model includes stochastic particle motion. Therefore, small numerical differences may appear between runs if the random seed or MATLAB version changes. The qualitative patterns reported in the manuscript should remain stable under the provided configuration.
Associated manuscript
This code accompanies a manuscript on a minimal particle-based model for exploring spatial and temporal feeding mechanisms in Chirostoma humboldtianum.
Repository:
```text
https://github.com/quezadav/charal-particle-feeding-model
```
License
No license has been assigned yet. Reuse conditions should be defined before formal publication or archival release.

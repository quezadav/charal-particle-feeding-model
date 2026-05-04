%MAIN Run definitive simulations for the charal minimal particle model.
%
% This script runs:
%   1) core scenarios: control, diurnal, spatial diffusion, spatial taxis;
%   2) spatial parameter sweep with nRep = 30 stochastic replicates;
%   3) all diagnostic figures and summary CSV output.
%
% Before running, ensure MATLAB's current folder is this script folder.

clear; clc; close all;

fprintf('=== Charal minimal particle model ===\n');

if ~exist('results', 'dir')
    mkdir('results');
end

% -------------------------------------------------------------------------
% Core scenarios
% -------------------------------------------------------------------------
fprintf('Running core scenarios...\n');

sControl = scenario_control();
sControl.seed = 101;

sDiurnal = scenario_diurnal();
sDiurnal.seed = 101;

sSpatialDiffusion = scenario_spatial_diffusion();
sSpatialDiffusion.seed = 101;

sSpatialTaxis = scenario_spatial_taxis();
sSpatialTaxis.seed = 101;

R.control = run_simulation(sControl);
R.diurnal = run_simulation(sDiurnal);
R.spatial_diffusion = run_simulation(sSpatialDiffusion);
R.spatial_taxis = run_simulation(sSpatialTaxis);

save(fullfile('results', 'core_scenarios.mat'), 'R');
fprintf('Saved core scenarios to results/core_scenarios.mat\n');

analyze_diurnal_vs_control(R.control, R.diurnal);
analyze_results(R);

% -------------------------------------------------------------------------
% Spatial sweep
% -------------------------------------------------------------------------
nRep = 30;
fprintf('\nRunning spatial sweep with nRep = %d...\n', nRep);

sweepTable = run_spatial_sweep(nRep, {'diffusion','taxis'});
writetable(sweepTable, fullfile('results', 'spatial_sweep_summary.csv'));
fprintf('Saved sweep table to results/spatial_sweep_summary.csv\n');

analyze_spatial_sweep(sweepTable);

fprintf('\nDone. All output files are in the results/ folder.\n');

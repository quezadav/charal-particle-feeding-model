function s = scenario_spatial_diffusion()
%SCENARIO_SPATIAL_DIFFUSION Wrapper for the diffusion-only spatial model.
%
% The model includes spatial food heterogeneity, but movement remains purely
% diffusive. Food affects gut fullness but not particle motion.

s = scenario_spatial('diffusion');

end

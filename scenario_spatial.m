function s = scenario_spatial(mode)
%SCENARIO_SPATIAL Spatial food heterogeneity scenario.
%
% Syntax
% ------
% s = scenario_spatial('diffusion')
% s = scenario_spatial('taxis')
%
% Modes
% -----
% diffusion : food affects gut fullness but not movement. This is the
%             diffusion-only null model.
% taxis     : food affects gut fullness and movement responds to the spatial
%             food gradient via resource-directed taxis.

if nargin < 1 || isempty(mode)
    mode = 'diffusion';
end

s = default_parameters();
s.useSpatialFood  = true;
s.useTemporalFood = false;
s.temporalAmp = 0.0;

% Core scenario uses strong spatial heterogeneity. The sweep script overrides
% Hscale for parametric analysis.
s.Hscale = 3.0;

switch lower(mode)
    case 'diffusion'
        s.scenarioType = 'spatial_diffusion';
        s.name = 'spatial diffusion';
        s.useTaxis = false;

    case 'taxis'
        s.scenarioType = 'spatial_taxis';
        s.name = 'spatial taxis';
        s.useTaxis = true;

        % Publication-oriented moderate taxis coefficients.
        s.chi = [0.70 0.50 0.30];

    otherwise
        error('Unknown spatial mode. Use ''diffusion'' or ''taxis''.');
end

end

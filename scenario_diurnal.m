function s = scenario_diurnal()
%SCENARIO_DIURNAL Homogeneous domain with diurnal food forcing.
%
% This scenario tests whether periodic forcing of food availability can
% produce a bounded diurnal response in gut fullness. Movement remains purely
% diffusive and is not affected by the temporal forcing.

s = default_parameters();
s.scenarioType = 'diurnal';
s.name = 'diurnal forcing';
s.useSpatialFood  = false;
s.useTemporalFood = true;
s.useTaxis        = false;
s.Hscale = 0.0;

% Amplitude chosen to produce visible but bounded oscillations in G.
s.temporalAmp = 0.40;
s.diurnalPeak = 18.0;  % evening peak [h]

end

function s = scenario_control()
%SCENARIO_CONTROL Homogeneous, time-independent reference scenario.
%
% This scenario provides the baseline: no spatial heterogeneity, no diurnal
% forcing, and no resource-directed movement. Gut fullness should converge
% to the basal equilibrium value defined in default_parameters.

s = default_parameters();
s.scenarioType = 'control';
s.name = 'control';
s.useSpatialFood  = false;
s.useTemporalFood = false;
s.useTaxis        = false;
s.Hscale = 0.0;
s.temporalAmp = 0.0;

end

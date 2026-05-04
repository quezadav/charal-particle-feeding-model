function s = default_parameters()
%DEFAULT_PARAMETERS Return baseline parameters for the charal particle model.
%
% The model is intentionally minimal. It separates three mechanisms:
%   1) diffusive movement in a bounded two-dimensional domain;
%   2) gut-fullness dynamics driven by a food field;
%   3) optional resource-directed movement (taxis) in response to the food gradient.
%
% Gut fullness G is dimensionless and constrained to 0 <= G <= Gmax.
% The spatial domain is dimensionless; it should be interpreted as an idealized
% reservoir cross-section, not as a calibrated map of Las Tazas reservoir.

% --------------------------
% Domain and population
% --------------------------
s.Lx = 10.0;                  % domain length in x
s.Ly = 6.0;                   % domain length in y
s.N  = 450;                   % number of particles/individuals
s.sizeFractions = [1/3 1/3 1/3]; % small, medium, large

% --------------------------
% Time integration
% --------------------------
s.dt   = 0.10;                % time step [h]
s.tEnd = 72.0;                % final time [h]

% --------------------------
% Movement parameters
% --------------------------
% Baseline diffusive intensity by size class: [small medium large]
s.sigma = [0.60 0.60 0.60];

% Resource-directed movement coefficients by size class. These values are
% deliberately moderate for publication-oriented runs. They generate a clear
% taxis response without collapsing all particles into the food patch.
s.chi = [0.70 0.50 0.30];

% --------------------------
% Gut-fullness parameters
% --------------------------
s.Gmax = 1.0;                 % maximum dimensionless gut-fullness index
s.G0   = 0.58;                % initial and target basal gut fullness

% Ingestion and emptying parameters by size class.
% Units are model units; the model is qualitative/structural, not calibrated.
s.rho   = [1.00 0.92 0.84];   % ingestion gain coefficient
s.kappa = [0.72 0.65 0.58];   % gut-emptying coefficient

% --------------------------
% Food field parameters
% --------------------------
s.useSpatialFood  = false;
s.useTemporalFood = false;
s.useTaxis        = false;

s.Hscale = 0.0;               % spatial heterogeneity amplitude
s.patchCenter = [5.0 3.0];    % productive patch center
s.patchRadius = 1.10;         % circle used to measure patch occupancy
s.patchSigma  = 0.85;         % Gaussian width of food patch

% Diurnal forcing of food availability.
s.temporalAmp = 0.0;          % amplitude; set in scenario_diurnal
s.diurnalPeriod = 24.0;       % [h]
s.diurnalPeak   = 18.0;       % [h], approximate evening peak
s.minFoodFactor = 0.05;       % lower bound to avoid nonphysical negative food

% --------------------------
% Metadata and reproducibility
% --------------------------
s.scenarioType = 'base';
s.name = 'Base parameters';
s.baseSeed = 12345;
s.verbose = false;

end

function [F, gradFx, gradFy] = food_field(x, y, t, p, s)
%FOOD_FIELD Evaluate food availability and its spatial gradient.
%
% Syntax
% ------
% [F, gradFx, gradFy] = food_field(x, y, t, p, s)
%
% F is particle-specific because the basal food level is selected so that
% each size class has basal equilibrium at G = s.G0 when no spatial or
% temporal forcing is active.
%
% The field combines:
%   - a size-dependent basal food level;
%   - optional spatial heterogeneity represented by a Gaussian patch;
%   - optional temporal/diurnal modulation.
%
% All outputs are column vectors of length N.

x = x(:);
y = y(:);
p.size = p.size(:);
N = numel(x);

% Basal food level required to keep G0 at equilibrium:
% dG/dt = rho*F*(1 - G/Gmax) - kappa*G = 0 at G = G0.
FbaseBySize = s.kappa .* s.G0 ./ (s.rho .* (1 - s.G0 / s.Gmax));
Fbase = FbaseBySize(p.size);
Fbase = Fbase(:);

% Spatial heterogeneity.
if s.useSpatialFood && s.Hscale ~= 0
    dx = x - s.patchCenter(1);
    dy = y - s.patchCenter(2);
    r2 = dx.^2 + dy.^2;
    H = exp(-r2 ./ (2*s.patchSigma^2));

    spatialFactor = 1 + s.Hscale .* H;

    % Gradients of the spatial factor.
    dHdx = -(dx ./ (s.patchSigma^2)) .* H;
    dHdy = -(dy ./ (s.patchSigma^2)) .* H;
    gradSpatialX = s.Hscale .* dHdx;
    gradSpatialY = s.Hscale .* dHdy;
else
    spatialFactor = ones(N,1);
    gradSpatialX = zeros(N,1);
    gradSpatialY = zeros(N,1);
end

% Temporal forcing.
if s.useTemporalFood && s.temporalAmp ~= 0
    temporalFactor = 1 + s.temporalAmp * cos(2*pi*(t - s.diurnalPeak)/s.diurnalPeriod);
    temporalFactor = max(s.minFoodFactor, temporalFactor);
else
    temporalFactor = 1.0;
end

F = Fbase .* spatialFactor .* temporalFactor;

% Since temporal factor is spatially uniform, spatial gradients only come
% from the spatial field.
gradFx = Fbase .* temporalFactor .* gradSpatialX;
gradFy = Fbase .* temporalFactor .* gradSpatialY;

F      = F(:);
gradFx = gradFx(:);
gradFy = gradFy(:);

end

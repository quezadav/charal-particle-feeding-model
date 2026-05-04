function p = update_particles(p, t, s)
%UPDATE_PARTICLES Advance the particle system by one explicit time step.
%
% Movement model
% --------------
% dx = chi(size)*grad(log F)*dt + sigma(size)*sqrt(dt)*dW_x
% dy = chi(size)*grad(log F)*dt + sigma(size)*sqrt(dt)*dW_y
%
% The taxis term is activated only when s.useTaxis = true. Otherwise,
% movement is purely diffusive.
%
% Gut-fullness model
% ------------------
% dG/dt = rho(size)*F*(1 - G/Gmax) - kappa(size)*G
%
% All particle vectors are explicitly forced to column vectors. This avoids
% row/column implicit-expansion errors in MATLAB versions that are stricter
% about array sizes.

% Force particle state to column vectors for numerical safety.
p.x    = p.x(:);
p.y    = p.y(:);
p.size = p.size(:);
p.G    = p.G(:);

N  = numel(p.x);
dt = s.dt;

[F, gradFx, gradFy] = food_field(p.x, p.y, t, p, s);
F       = F(:);
gradFx  = gradFx(:);
gradFy  = gradFy(:);

sig = s.sigma(p.size);
chi = s.chi(p.size);
sig = sig(:);
chi = chi(:);

% Brownian/diffusive component.
dx = sig .* sqrt(dt) .* randn(N,1);
dy = sig .* sqrt(dt) .* randn(N,1);

% Resource-directed movement component.
if s.useTaxis
    % Use grad(log F) for scale stability. eps prevents division by zero.
    denom = max(F, eps);
    gradLogFx = gradFx ./ denom;
    gradLogFy = gradFy ./ denom;

    dx = dx + chi .* gradLogFx .* dt;
    dy = dy + chi .* gradLogFy .* dt;
end

p.x = p.x + dx;
p.y = p.y + dy;
[p.x, p.y] = apply_boundary(p.x, p.y, s);

% Gut-fullness dynamics.
rho   = s.rho(p.size);
kappa = s.kappa(p.size);
rho   = rho(:);
kappa = kappa(:);
G     = p.G(:);

dG = rho .* F .* (1 - G ./ s.Gmax) - kappa .* G;
G  = G + dt .* dG;

% Enforce physical bounds.
p.G = min(max(G, 0), s.Gmax);

end

function out = run_simulation(s)
%RUN_SIMULATION Simulate one realization of the particle model.
%
% Output structure
% ----------------
% out.s                 : scenario structure
% out.metrics.t          : time vector
% out.metrics.meanG      : mean gut fullness over all particles
% out.metrics.meanGBySize: mean gut fullness by size class
% out.metrics.patchFraction : fraction of particles inside productive patch
% out.final              : final particle state

if isfield(s, 'seed') && ~isempty(s.seed)
    rng(s.seed);
elseif isfield(s, 'baseSeed') && ~isempty(s.baseSeed)
    rng(s.baseSeed);
end

p = init_parameters(s);
t = 0:s.dt:s.tEnd;
nt = numel(t);

meanG = zeros(nt,1);
meanGBySize = nan(nt,3);
patchFraction = zeros(nt,1);

for n = 1:nt
    meanG(n) = mean(p.G);

    for k = 1:3
        idx = p.size == k;
        if any(idx)
            meanGBySize(n,k) = mean(p.G(idx));
        end
    end

    patchFraction(n) = compute_patch_fraction(p, s);

    if n < nt
        p = update_particles(p, t(n), s);
    end
end

out.s = s;
out.metrics.t = t(:);
out.metrics.meanG = meanG;
out.metrics.meanGBySize = meanGBySize;
out.metrics.patchFraction = patchFraction;
out.final = p;

end

function f = compute_patch_fraction(p, s)
dx = p.x - s.patchCenter(1);
dy = p.y - s.patchCenter(2);
f = mean(dx.^2 + dy.^2 <= s.patchRadius^2);
end

function summary = run_replicates(s, nRep)
%RUN_REPLICATES Run independent stochastic replicates for one scenario.
%
% Returns replicate-level final metrics and their mean/std summaries.

if nargin < 2 || isempty(nRep)
    nRep = 30;
end

meanGFinal = zeros(nRep,1);
patchFractionFinal = zeros(nRep,1);

for r = 1:nRep
    sr = s;
    sr.seed = s.baseSeed + 1000*r;
    out = run_simulation(sr);

    meanGFinal(r) = out.metrics.meanG(end);
    patchFractionFinal(r) = out.metrics.patchFraction(end);
end

summary.nRep = nRep;
summary.meanGFinal = meanGFinal;
summary.patchFractionFinal = patchFractionFinal;
summary.meanGFinal_mean = mean(meanGFinal);
summary.meanGFinal_std  = std(meanGFinal);
summary.patchFractionFinal_mean = mean(patchFractionFinal);
summary.patchFractionFinal_std  = std(patchFractionFinal);

end

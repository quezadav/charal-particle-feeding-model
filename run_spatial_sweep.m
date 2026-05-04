function sweepTable = run_spatial_sweep(nRep, modes)
%RUN_SPATIAL_SWEEP Run the spatial heterogeneity/diffusion sweep.
%
% Syntax
% ------
% sweepTable = run_spatial_sweep()
% sweepTable = run_spatial_sweep(30, {'diffusion','taxis'})
%
% The sweep compares two spatial mechanisms:
%   diffusion : spatial food heterogeneity affects gut fullness only.
%   taxis     : particles also move up the food gradient.

if nargin < 1 || isempty(nRep)
    nRep = 30;
end

if nargin < 2 || isempty(modes)
    modes = {'diffusion', 'taxis'};
end

HscaleVec = [0 0.5 1.0 1.5 2.0 3.0];
sigmaVec  = [0.60 1.00 1.40];

modeCol = {};
HCol = [];
sigmaCol = [];
nRepCol = [];
meanGMeanCol = [];
meanGStdCol = [];
patchMeanCol = [];
patchStdCol = [];

row = 0;
for m = 1:numel(modes)
    mode = modes{m};

    for h = 1:numel(HscaleVec)
        for q = 1:numel(sigmaVec)
            row = row + 1;

            Hscale = HscaleVec(h);
            sigmaLevel = sigmaVec(q);

            s = scenario_spatial(mode);
            s.Hscale = Hscale;
            s.sigma = sigmaLevel * ones(1,3);
            s.baseSeed = 12345 + 100000*m + 1000*h + 10*q;

            fprintf('Sweep: mode=%s, Hscale=%0.2f, sigma=%0.2f, nRep=%d\n', ...
                mode, Hscale, sigmaLevel, nRep);

            rep = run_replicates(s, nRep);

            modeCol{row,1} = mode; %#ok<AGROW>
            HCol(row,1) = Hscale; %#ok<AGROW>
            sigmaCol(row,1) = sigmaLevel; %#ok<AGROW>
            nRepCol(row,1) = nRep; %#ok<AGROW>
            meanGMeanCol(row,1) = rep.meanGFinal_mean; %#ok<AGROW>
            meanGStdCol(row,1) = rep.meanGFinal_std; %#ok<AGROW>
            patchMeanCol(row,1) = rep.patchFractionFinal_mean; %#ok<AGROW>
            patchStdCol(row,1) = rep.patchFractionFinal_std; %#ok<AGROW>
        end
    end
end

sweepTable = table(modeCol, HCol, sigmaCol, nRepCol, ...
    meanGMeanCol, meanGStdCol, patchMeanCol, patchStdCol, ...
    'VariableNames', {'mode','Hscale','sigmaLevel','nRep', ...
    'meanGFinal_mean','meanGFinal_std', ...
    'patchFractionFinal_mean','patchFractionFinal_std'});

end

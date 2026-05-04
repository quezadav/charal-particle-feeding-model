function analyze_results(R)
%ANALYZE_RESULTS Generate diagnostic figures for the core scenarios.
%
% Expected fields in R:
%   R.control
%   R.diurnal
%   R.spatial_diffusion
%   R.spatial_taxis

% -------------------------------------------------------------------------
% Mean gut fullness across core scenarios
% -------------------------------------------------------------------------
figure('Color','w'); hold on;
plot(R.control.metrics.t, R.control.metrics.meanG, 'LineWidth', 2.0);
plot(R.diurnal.metrics.t, R.diurnal.metrics.meanG, 'LineWidth', 2.0);
plot(R.spatial_diffusion.metrics.t, R.spatial_diffusion.metrics.meanG, 'LineWidth', 2.0);
plot(R.spatial_taxis.metrics.t, R.spatial_taxis.metrics.meanG, 'LineWidth', 2.0);
grid on; box on;
xlabel('Tiempo [h]');
ylabel('Llenado digestivo medio, G');
title('Llenado digestivo medio en escenarios principales');
legend({'control','diurno','difusión espacial','taxis espacial'}, 'Location', 'best');
save_current_figure('fig_mean_gut_all_scenarios');

% -------------------------------------------------------------------------
% Final positions for each scenario
% -------------------------------------------------------------------------
plot_final_positions(R.control, 'control', false);
plot_final_positions(R.diurnal, 'diurnal forcing', false);
plot_final_positions(R.spatial_diffusion, 'spatial diffusion', true);
plot_final_positions(R.spatial_taxis, 'spatial taxis', true);

% -------------------------------------------------------------------------
% Patch occupancy: diffusion-only vs taxis
% -------------------------------------------------------------------------
figure('Color','w'); hold on;
plot(R.spatial_diffusion.metrics.t, R.spatial_diffusion.metrics.patchFraction, 'LineWidth', 2.0);
plot(R.spatial_taxis.metrics.t, R.spatial_taxis.metrics.patchFraction, 'LineWidth', 2.0);
grid on; box on;
xlabel('Tiempo [h]');
ylabel('Fracción dentro del parche productivo');
title('Ocupación del parche: difusión pura vs taxis al recurso');
legend({'difusión espacial','taxis espacial'}, 'Location', 'best');
save_current_figure('fig_patch_occupancy_diffusion_vs_taxis');

end

function plot_final_positions(out, label, showPatch)
s = out.s;
p = out.final;

figure('Color','w'); hold on;

colors = lines(3);
labels = {'pequeño','mediano','grande'};
for k = 1:3
    idx = p.size == k;
    scatter(p.x(idx), p.y(idx), 28, colors(k,:), 'filled', ...
        'MarkerFaceAlpha', 0.75, 'MarkerEdgeAlpha', 0.75);
end

if showPatch
    th = linspace(0, 2*pi, 240);
    xC = s.patchCenter(1) + s.patchRadius*cos(th);
    yC = s.patchCenter(2) + s.patchRadius*sin(th);
    plot(xC, yC, 'k--', 'LineWidth', 2.0);
end

grid on; box on;
xlim([0 s.Lx]); ylim([0 s.Ly]);
pbaspect([s.Lx s.Ly 1]);
xlabel('x'); ylabel('y');
displayLabel = label;
switch label
    case 'diurnal forcing'
        displayLabel = 'forzamiento diurno';
    case 'spatial diffusion'
        displayLabel = 'difusión espacial';
    case 'spatial taxis'
        displayLabel = 'taxis espacial';
end
title(sprintf('Posiciones finales de partículas: %s', displayLabel));
legend(labels, 'Location', 'eastoutside');

safeLabel = regexprep(label, '[^a-zA-Z0-9]+', '_');
safeLabel = lower(strtrim(safeLabel));
save_current_figure(sprintf('fig_final_positions_%s', safeLabel));

end

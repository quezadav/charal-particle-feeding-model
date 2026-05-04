function analyze_diurnal_vs_control(results_control, results_diurnal)
%ANALYZE_DIURNAL_VS_CONTROL Plot control and diurnal forcing responses.

figure('Color','w');
plot(results_control.metrics.t, results_control.metrics.meanG, 'LineWidth', 2.0); hold on;
plot(results_diurnal.metrics.t, results_diurnal.metrics.meanG, 'LineWidth', 2.0);
grid on; box on;
xlabel('Tiempo [h]');
ylabel('Llenado digestivo medio, G');
title('Control vs forzamiento diurno');
legend({'control','diurno'}, 'Location', 'best');
save_current_figure('fig_diurnal_vs_control');

figure('Color','w');
plot(results_diurnal.metrics.t, results_diurnal.metrics.meanGBySize(:,1), 'LineWidth', 2.0); hold on;
plot(results_diurnal.metrics.t, results_diurnal.metrics.meanGBySize(:,2), 'LineWidth', 2.0);
plot(results_diurnal.metrics.t, results_diurnal.metrics.meanGBySize(:,3), 'LineWidth', 2.0);
grid on; box on;
xlabel('Tiempo [h]');
ylabel('Llenado digestivo medio, G');
title('Respuesta diurna por clase de talla');
legend({'pequeño','mediano','grande'}, 'Location', 'best');
save_current_figure('fig_diurnal_by_size');

end

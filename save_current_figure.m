function save_current_figure(filename)
%SAVE_CURRENT_FIGURE Save the current figure in the results folder.
%
% Syntax
% ------
% save_current_figure('figure_name')
% save_current_figure('figure_name.png')
%
% The function writes a 300-dpi PNG file by default. It also protects against
% filenames such as sigma_0.60, where MATLAB may incorrectly interpret ".60"
% as a file extension.

resultsDir = 'results';

if ~exist(resultsDir, 'dir')
    mkdir(resultsDir);
end

validExt = {'.png', '.jpg', '.jpeg', '.tif', '.tiff', '.pdf', '.eps', '.fig'};
[~, ~, ext] = fileparts(filename);

if isempty(ext) || ~any(strcmpi(ext, validExt))
    filename = [filename '.png'];
end

fullpath = fullfile(resultsDir, filename);

try
    exportgraphics(gcf, fullpath, 'Resolution', 300);
catch
    [~, ~, ext2] = fileparts(fullpath);
    if strcmpi(ext2, '.png')
        print(gcf, fullpath, '-dpng', '-r300');
    else
        saveas(gcf, fullpath);
    end
end

fprintf('Saved figure: %s\n', fullpath);

end

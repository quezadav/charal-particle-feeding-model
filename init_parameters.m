function p = init_parameters(s)
%INIT_PARAMETERS Initialize particle positions, sizes, and gut fullness.
%
% Output structure p contains:
%   p.x, p.y  : particle coordinates
%   p.size    : size class index, 1=small, 2=medium, 3=large
%   p.G       : dimensionless gut fullness

N = s.N;

p.x = s.Lx * rand(N,1);
p.y = s.Ly * rand(N,1);

% Assign size classes according to sizeFractions.
edges = [0 cumsum(s.sizeFractions(:)')];
edges(end) = 1;
u = rand(N,1);
p.size = zeros(N,1);
for k = 1:3
    p.size(u >= edges(k) & u < edges(k+1)) = k;
end
p.size(p.size == 0) = 3;

p.G = s.G0 * ones(N,1);

end

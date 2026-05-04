function [x, y] = apply_boundary(x, y, s)
%APPLY_BOUNDARY Reflect particles at rectangular domain boundaries.
%
% This function implements reflecting boundaries on [0,Lx] x [0,Ly].
% A modulo-based reflection is used so that even large stochastic jumps are
% mapped back into the domain robustly.

x = reflect_coordinate(x, s.Lx);
y = reflect_coordinate(y, s.Ly);

end

function z = reflect_coordinate(z, L)
% Map real-valued coordinate z into [0,L] with reflecting boundaries.
period = 2*L;
z = mod(z, period);
idx = z > L;
z(idx) = period - z(idx);
end

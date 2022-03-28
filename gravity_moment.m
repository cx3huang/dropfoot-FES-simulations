function [moment] = gravity_moment(theta)

% Inputs
% theta: angle of body segment (up from prone)

% Output
% moment about ankle due to force of gravity on body

m = 2; % body mass (kg; excluding feet)
% centre_of_mass_distance = 1; % distance from ankle to body segment centre of mass (m)
d_x = 0.03;
d_y = 0.04;
g = -9.81; % acceleration of gravity
tau_foot_x = sin(theta).*d_x*m*g;
tau_foot_y = cos(theta).*d_y*m*g;
moment = tau_foot_y + tau_foot_x;
end

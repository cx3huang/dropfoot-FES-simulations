function [x_dot] = dynamics2(t, x, tibialis)

% Inputs
%  x: state vector (ankle angle, angular velocity, TA normalized CE length)
% tibialis: tibialis anterior muscle (HillTypeModel)

% Output
% x_dot: derivative of state vector

% 20 Hz
% if t < 0.025
%     tibialis_activation = 1;
% elseif t < 0.05
%     tibialis_activation = 0;
% elseif t < 0.075
%     tibialis_activation = 1;
% elseif t < 0.1
%     tibialis_activation = 0;
% elseif t < 0.125
%     tibialis_activation = 1;
% elseif t < 0.15
%     tibialis_activation = 0;
% elseif t < 0.175
%     tibialis_activation = 1;
% elseif t < 0.2
%     tibialis_activation = 0;
% elseif t < 0.225
%     tibialis_activation = 1;
% elseif t < 0.25
%     tibialis_activation = 0;
% elseif t < 0.275
%     tibialis_activation = 1;
% elseif t < 0.3
%     tibialis_activation = 0;
% elseif t < 0.325
%     tibialis_activation = 1;
% elseif t < 0.35
%     tibialis_activation = 0;
% elseif t < 0.375
%     tibialis_activation = 1;
% elseif t < 0.4
%     tibialis_activation = 0;
% elseif t < 0.425
%     tibialis_activation = 1;
% elseif t < 0.45
%     tibialis_activation = 0;
% elseif t < 0.475
%     tibialis_activation = 1;
% elseif t < 0.5
%     tibialis_activation = 0;
% elseif t < 0.525
%     tibialis_activation = 1;
% elseif t < 0.55
%     tibialis_activation = 0;
% elseif t < 0.575
%     tibialis_activation = 1;
% else
%     tibialis_activation = 0;
% end

% 10 Hz
if t < 0.05
    tibialis_activation = 0.5;
elseif t < 0.1
    tibialis_activation = 0;
elseif t < 0.15
    tibialis_activation = 0.5;
elseif t < 0.2
    tibialis_activation = 0;
elseif t < 0.25
    tibialis_activation = 0.5;
elseif t < 0.3
    tibialis_activation = 0;
elseif t < 0.35
    tibialis_activation = 0.5;
elseif t < 0.4
    tibialis_activation = 0;
elseif t < 0.45
    tibialis_activation = 0.5;
elseif t < 0.5
    tibialis_activation = 0;
elseif t < 0.55
    tibialis_activation = 0.5;
else
    tibialis_activation = 0;
end

% tibialis_activation = exp(-5*t)/2;
% tibialis_activation = cos(1.3*t);
% if t < 0.1
%     tibialis_activation = 1;
% elseif t < 0.2
%     tibialis_activation = 0;
% elseif t < 0.3
%     tibialis_activation = 1;
% elseif t < 0.4
%     tibialis_activation = 0;
% elseif t < 0.5
%     tibialis_activation = 1;
% else
%     tibialis_activation = 0;
% end

% tibialis_activation = 0.25;

ankle_inertia = 90;

tibialis_moment_arm = 0.03;

%WRITE CODE HERE TO IMPLEMENT THE MODEL
tau_ta = force_length_tendon(tibialis.norm_tendon_length( ...
    tibialis_length(x(1)), x(3)))*tibialis_moment_arm*tibialis.f0M;
m = 2;
d_x = 0.03;
d_y = 0.04;
tau_foot_x = sin(x(1)).*d_x*m*9.81;
tau_foot_y = cos(x(1)).*d_y*m*9.81;

x1_dot = x(2);
x2_dot = (tau_ta-tau_foot_x-tau_foot_y)/ankle_inertia;
x3_dot = get_velocity(tibialis_activation, x(3), ...
    tibialis.norm_tendon_length(tibialis_length(x(1)), x(3)));


x_dot = [x1_dot, x2_dot, x3_dot]';

end


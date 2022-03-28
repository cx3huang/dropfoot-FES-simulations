% Test FES code

% set f_stim to 15
f_stim = ones(1, 30);
f_stim = 40.*f_stim;

% set U_stim to 1.2
U_stim = ones(1, 30);
U_stim = 1.7.*U_stim;
% U_stim = zeros(1, 30);
U_stim = [0 0 0 0 0 0 10 10 10 10 10 10 30 30 30 30 30 30 35 35 35 35 35 35 43 43 43 43 43 43];

Fs = 10;
dt = 1/Fs;
f1 = 10;
f2 = 20;
f3 = 35;
f4 = 50;
end_time = 10;
t = (0:dt:end_time-dt)';

% Test FES signals
% U_stim = sin(2*pi*f1*t);
% u_stim1_sin = u_stim1_sin*1.2 + 1;
% u_stim2_sin = sin(2*pi*f2*t);
% u_stim2_sin = u_stim2_sin*1.2 + 1;
% u_stim3_sin = sin(2*pi*f3*t);
% u_stim3_sin = u_stim3_sin*1.2 + 1;
% u_stim4_sin = sin(2*pi*f4*t);
% u_stim4_sin = u_stim4_sin*1.2 + 1;
% 
% u_stim1_sq = 1.2*(square(f1*t) + 1)';
% u_stim2_sq = 1.3*(square(f2*t) + 1)';
% u_stim3_sq = 1.5*(square(f3*t) + 1)';
% 
% u_stim4_sq = 1.7*(square(f4*t) + 1)'; % you can make them 1 column by removing '

time = uint32(1):uint32(30);

% f_stim = ones(1, length(u_stim4_sq));
% f_stim = 15*f_stim;

test_excitation = FES_to_excitation(U_stim, f_stim);

figure
plot(time, test_excitation)
%% 
activation2(test_excitation, 0.01)
% excitation_to_activation(test_excitation)
clear
clc

global force_length_regression force_velocity_regression
force_length_regression = get_muscle_force_length_regression(); 
force_velocity_regression = get_muscle_force_velocity_regression();

%% Section 1
% various freq, amp, wave shapes
default_amp = 1;
default_freq = 20;
default_wave = 1; %sinusoidal

a1 = a_from_FES(default_freq, 0, default_wave);
a2 = a_from_FES(default_freq, 0.5, default_wave);
a3 = a_from_FES(default_freq, default_amp, default_wave);

a4 = a_from_FES(default_freq, default_amp, default_wave);
a5 = a_from_FES(35, default_amp, default_wave);
a6 = a_from_FES(50, default_amp, default_wave);

a7 = a_from_FES(default_freq, default_amp, default_wave);
a8 = a_from_FES(default_freq, default_amp, 2); %square

%% Section 2
% a = 0
T1 = 5;
f0M = 100;
resting_length_muscle = 0.3;
resting_length_tendon = 0.1;

RelTol = 1e-5; %1e-3
AbsTol = 1e-8;

tic
simulate(T1, f0M, resting_length_muscle, resting_length_tendon, RelTol, AbsTol);
toc

% a = ???
% T2 = 10;
% tic
% simulate(T2, f0M, resting_length_muscle, resting_length_tendon, RelTol, AbsTol);
% toc
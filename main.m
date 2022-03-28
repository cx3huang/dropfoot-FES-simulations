clear
clc

global force_length_regression force_velocity_regression
force_length_regression = get_muscle_force_length_regression(); 
force_velocity_regression = get_muscle_force_velocity_regression();

T = 0.6;
simulate(T);
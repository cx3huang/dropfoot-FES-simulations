function simulate(T, f0M, resting_length_muscle, resting_length_tendon, RelTol, AbsTol)

% Input Parameters
% T: simulation time (seconds)
% f0M: maximum isometric force
% resting_length_muscle: actual length (m) of muscle (CE) that corresponds to normalized length of 1
% resting_length_tendon: actual length of tendon (m) that corresponds to normalized length of 1

tibialis_anterior = HillTypeMuscle(f0M, resting_length_muscle, resting_length_tendon);
L = resting_length_tendon + resting_length_muscle;

    function [output] = get_velocity_from_time(time, lm)
        lt = tibialis_anterior.norm_tendon_length(L, lm);
        if time < 0.6*T
            output = get_velocity(0, lm, lt);
        else
            output = get_velocity(1, lm, lt);
        end
    end

% the outputs of ode45 must be named "time" and "norm_lm"
options = odeset('RelTol',RelTol,'AbsTol',AbsTol);
[time,norm_lm] = ode45(@get_velocity_from_time, [0 T], 1, options);

% save the estimated forces in a vector called "forces"
forces = tibialis_anterior.get_force(L, norm_lm);

% Do not alter the rest (it should not be needed)
norm_lm = norm_lm * resting_length_muscle;

% Plot results
plot_normlm_forces(time, norm_lm, forces)
end
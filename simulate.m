function [] = simulate(T)

% Input Parameters
% T: simulation time (seconds)
% f0M: maximum isometric force
% resting_length_muscle: actual length (m) of muscle (CE) that corresponds to normalized length of 1
% resting_length_tendon: actual length of tendon (m) that corresponds to normalized length of 1

rest_length_tibialis = tibialis_length(pi/2);

tibialis_anterior = HillTypeMuscle(16000, 0.6*rest_length_tibialis, 0.4*rest_length_tibialis);
% L = resting_length_tendon + resting_length_muscle;

f = @(t,x) dynamics(t, x, tibialis_anterior);
tspan = [0 T];
ini_cond = [pi/2, 0, 1];
options = odeset('RelTol', 1e-6, 'AbsTol', 1e-8);
[time, y] = ode45(f, tspan, ini_cond, options);

f2 = @(t,x) dynamics2(t, x, tibialis_anterior);
[time2, y2] = ode45(f2, tspan, ini_cond, options);

f3 = @(t,x) dynamics3(t, x, tibialis_anterior);
[time3, y3] = ode45(f3, tspan, ini_cond, options);

% f4 = @(t,x) dynamics4(t, x, tibialis_anterior);
% [time4, y4] = ode45(f4, tspan, ini_cond, options);


theta = y(:,1);
tibialis_norm_length_muscle = y(:,3);
tibialis_moment_arm = 0.03;
tibialis_moment = zeros(size(y,1),1);
for i = 1:size(y,1)
    tibialis_moment(i) = tibialis_moment_arm * tibialis_anterior.get_force(tibialis_length(theta(i)), tibialis_norm_length_muscle(i));
end

theta2 = y2(:,1);
tibialis_norm_length_muscle2 = y2(:,3);
tibialis_moment2 = zeros(size(y2,1),1);
for i = 1:size(y2,1)
    tibialis_moment2(i) = tibialis_moment_arm * tibialis_anterior.get_force(tibialis_length(theta2(i)), tibialis_norm_length_muscle2(i));
end

theta3 = y3(:,1);
tibialis_norm_length_muscle3 = y3(:,3);
tibialis_moment3 = zeros(size(y3,1),1);
for i = 1:size(y3,1)
    tibialis_moment3(i) = tibialis_moment_arm * tibialis_anterior.get_force(tibialis_length(theta3(i)), tibialis_norm_length_muscle3(i));
end

% theta4 = y4(:,1);
% tibialis_norm_length_muscle4 = y4(:,3);
% tibialis_moment4 = zeros(size(y4,1),1);
% for i = 1:size(y4,1)
%     tibialis_moment4(i) = tibialis_moment_arm * tibialis_anterior.get_force(tibialis_length(theta4(i)), tibialis_norm_length_muscle4(i));
% end

figure

subplot(2,1,1)
plot(time, theta, 'r', 'LineWidth', 1.5); hold on
plot(time2, theta2, 'b','LineWidth', 1.5); hold on
plot(time3, theta3, 'g', 'LineWidth', 1.5); hold on
% plot(time4, theta4, 'm', 'LineWidth', 1.5); 
ylabel('Ankle Angle (rad)', 'FontSize', 12, 'FontWeight','normal')
legend('5 Hz','10 Hz','20 Hz','Location','northwest')
grid on
% y_ticks = linspace(1.5,2.5,11);
% yticks(y_ticks);
title('Ankle Angle & TA Torque vs. Time (Various Frequencies, Square Waveform)')
subplot(2,1,2)
plot(time, tibialis_moment, 'r', 'LineWidth', 1.5); hold on
plot(time2, tibialis_moment2, 'b', 'LineWidth', 1.5); hold on
plot(time3, tibialis_moment3, 'g', 'LineWidth', 1.5); hold on
% plot(time4, tibialis_moment4, 'm', 'LineWidth', 1.5); 
legend('5 Hz','10 Hz','20 Hz','Location','northwest')
ylabel('Torques (Nm)', 'FontSize', 12, 'FontWeight','normal')
% subplot(3,1,3)
% plot(time, gravity_moment(theta), 'k', 'LineWidth', 1.5),
% ylabel('Gravity Moment (Foot) (Nm)')
grid on

xlabel('Time (s)')


set(gca,'FontSize',12)
end
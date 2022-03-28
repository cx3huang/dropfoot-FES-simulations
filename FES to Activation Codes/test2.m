t = linspace(0, 0.6, 1000);
sq = 29.7.*sin(400*pi*t);

figure 
hold on 
plot(t, sq);
title("FES signal")
hold off

fr = 200.*ones(1000);
% ex = FES_to_excitation(sq, fr);
ac = excitation_to_activation_2(sq, fr, 0.6);
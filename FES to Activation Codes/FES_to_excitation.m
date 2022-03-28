function [Y] = FES_to_excitation(U_stim, f_stim)
    
    % [1]Validation of an artificially activated mechanistic muscle model by
    % using inverse dynamics analysis, Romero et al.
    % [2] An Approach to a Muscle Model with a Stimulus Frequency-Force
    % Relationship for FES Applications, Watanabe et al.
    % [3] https://www.researchgate.net/figure/Typical-recruitment-curves-at-rest-Amplitudes-of-reflex-responses-H-reflex-white_fig5_281720081
    % [4]
    % https://www-sciencedirect-com.proxy.lib.uwaterloo.ca/science/article/pii/S1050641104000501#FIG2
    % figure 2 from [4]

    % Constants
    U_tr = 29.6;         % [1], V % 0.7 mA [3]
    U_sat = 43.9;        % [1], V % 1.5 mA [3]
    
    a_2 = 2.55;         % 2.55 [2]... also Fmax/Fcf = 100/0.7 =1.4 from [4]
    R = 40;             % 15 from [1], 8.39 from [2]... or R = 91.2-1.03*f_cf for rabbits
    f_cf = 49.7;        % 17-20 Hz, from [1] 16.6 in Hz, for humans for arm muscles, 62 for rabbit TA [2]
 
    f_o = R*log((a_2-1)*exp(f_cf/R)-a_2);
    a_1 = -a_2*exp(-f_o/R);

    % Su function
    function [y] = Su(U_stim)
        y = zeros(1, length(U_stim));
        for i = 1:length(U_stim)
            if U_stim(i) < U_tr
                y(i) = 0;
            elseif U_stim(i) > U_sat
                y(i) = 1;
            else
                y(i) = (U_stim(i) - U_tr)./(U_sat-U_tr);
            end
        end
    end
    
    % Sf function
    function [y] = Sf(f_stim)
        y = zeros(1, length(f_stim));
        for i = 1:length(f_stim)
            y(i) = (a_1-a_2)./(1+exp((f_stim(i)-f_o)/R))+a_2;
            if y(i) > 1
                y(i) = 1;
            end
        end
    end
    
    Y = Su(U_stim).* Sf(f_stim);

end
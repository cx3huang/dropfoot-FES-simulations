function [Y] = excitation_to_activation(U_stim, f_stim)
    % Constants - will get from literature. Currently set to 1 now.
    T_rise = 1;
    T_fall = 1;
    T_e = 0.025;

    k1 = T_e*T_fall;
    k2 = T_e + T_fall;
    excitation = FES_to_excitation(U_stim, f_stim);

    % 2nd order ODE to solve for a(t): k1 * a''(t) + k2 * a'(t) + a(t) = e(t)
    % y1' = y2
    % y2' = (1/k1)*(e(t) - k2y1' - y1)
   
    function [dy] = fun(t, y)
%         dy = zeros(2, 100);
%         dy(1) = y(2);

        i = round(t*20+1);
        if i > 100
            i = 100;
        end

        e = excitation(i);
        dy = [y(2); e/k1 - y(2)*k2/k1 - y(1)/k1];
    end
    
    tspan = [0 5];
    inicond = [0.1 0.1]';
    [t,y] = ode45(@fun, tspan, inicond);
    
    Y = y(:,1)/max(y(:,1));
   
   
    
%     function dydt = fun(t, y)
%         dydt = [y(2); (1/k1).*(excitation-k2*y(2)-y(1))];
%     end
% 
%     [t, y] = ode45(@fun, [0, 30], [1; 0]); %random ICs

    figure
    plot(t, Y);
    title('Activation')

end
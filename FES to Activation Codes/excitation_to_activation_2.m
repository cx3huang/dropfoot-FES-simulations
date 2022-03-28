function [Y] = excitation_to_activation_2(U_stim, f_stim, Tend)
    % Constants
    % Assume T_fall = T_rise = T_const
    T_const = 0.076;
    % T_rise == 0.068;
    % T_fall = 0.076;
    T_e = 0.025;

    k1 = T_e*T_const;
    k2 = T_e + T_const;
    
    excitation = FES_to_excitation(U_stim, f_stim);

    % 2nd order ODE to solve for a(t): k1 * a''(t) + k2 * a'(t) + a(t) = e(t)
    % y1' = y2
    % y2' = (1/k1)*(e(t) - k2y1' - y1)
   
    function [dy] = fun(t, y)
%         dy = zeros(2, 100);
%         dy(1) = y(2);
        
        e = interp1(linspace(0, Tend, length(U_stim)), excitation, t);
        dy = [y(2); e/k1 - y(2)*k2/k1 - y(1)/k1];
    end
    
    plot(linspace(0,Tend, length(U_stim)), excitation)
    title('Excitation')

    tspan = [0 0.6];
    inicond = [0 0]';
    [t,y] = ode45(@fun, tspan, inicond);
    
    Y = y(:,1)/max(y(:,1));
  
    figure
    hold on
    plot(t, Y);
    title("Activation");
    hold off
end
function [sol] = activation2(excitation, T_rise, T_fall)

    T_e = 0.025;
    k1 = T_e*T_fall;
    k2 = T_e + T_fall;

    % 2nd order ODE to solve for a(t): k1 * a''(t) + k2 * a'(t) + a(t) = e(t)
    % y1' = y2
    % y2' = (1/k1)*(e(t) - k2y1' - y1)
    
    syms y(t)
    [V] = odeToVectorField(diff(y, 2) == (1/k1)*(excitation-k2*diff(y)-y));

    M = matlabFunction(V, 'vars', {'t', 'Y'});
    
    T_span = [0 30];
    ICs = [0, 0];
    sol = ode45(M, T_span, ICs);
end
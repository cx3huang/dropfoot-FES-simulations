function [normalize_PE_force] = force_length_parallel(lm)
%%%% TAKS 1

% Input Parameters
% lm: normalized length of muscle (contractile element)

% Output
% normalized force produced by parallel elastic element
normalize_PE_force = zeros(size(lm));
for i = 1:length(lm)
    if lm(i) >= 1
        normalize_PE_force(i) = 3*(lm(i) - 1)^2/(0.6 + lm(i) - 1);
    end
end

end
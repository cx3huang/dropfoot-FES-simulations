function [normalize_tendon_tension] = force_length_tendon(lt)
%%%% TAKS 1

% Input Parameters
% lt: normalized length of tendon (series elastic element)

% Output
% normalized tension produced by tendon
normalize_tendon_tension = zeros(size(lt));
for i = 1:length(lt)
    if lt(i) >= 1
        normalize_tendon_tension(i) = 10*(lt(i) - 1) + 240*(lt(i) - 1)^2;
    end
end

end
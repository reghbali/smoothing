classdef func_concave < handle
% Define interface of concave function Psi(x)
    methods (Abstract)
        [fval] = func_value(Psi, u)
        % Return function value Psi(x)

        
        [fval] = conjugate_value(Psi, y)
        % Return conjugate function value Psi(x)
        
        [grad] = gradient(Psi, u)
        %Return the gradient
    end
end
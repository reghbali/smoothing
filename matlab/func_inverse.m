classdef func_inverse < func_concave
% objective function: adwords min(u,1)
    
    methods
        function Psi = func_inverse
         end
        
        function f = func_value(Psi, u)
        f = 1- 1./(u+1);
        end
        
        function g = conjugate_value(Psi,y)
        g = 2*sqrt(y)-1-y;
        end
        
        function grad = gradient(Psi,u)
            grad = 1./((u+1).^2);
        end
        
    end
end

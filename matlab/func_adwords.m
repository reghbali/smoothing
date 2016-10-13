classdef func_adwords < func_concave
% objective function: adwords min(u,1)
    
    methods
        function Psi = func_adwords
         end
        
        function f = func_value(Psi, u)
        f = min(u,1);
        end
        
        function g = conjugate_value(Psi,y)
        g = min(y-1,0);
        end
        
        function grad = gradient(Psi,u)
            grad = u < 1;
        end
        
    end
end

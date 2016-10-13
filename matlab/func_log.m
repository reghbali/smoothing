classdef func_log < func_concave
% objective function: adwords min(u,1)
    
    methods
        function Psi = func_log
         end
        
        function f = func_value(Psi, u)
        f = log(u+1);
        end
        
        function g = conjugate_value(Psi,y)
        g = -y+1+log(y);
        end
        
        function grad = gradient(Psi,u)
            grad = 1./(u+1);
        end
        
        function grad = inverse(Psi,u)
            grad =exp(u)-1;
        end
    end
end

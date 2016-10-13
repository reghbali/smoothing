classdef func_root < func_concave
% objective function: adwords min(u,1)
    
    methods
        function Psi = func_root
         end
        
        function f = func_value(Psi, u)
        f = 2*sqrt(u);
        end
        
        function g = conjugate_value(Psi,y)
        g = -inv_pos(y);
        end
        
        function grad = gradient(Psi,u)
            grad = 1./2*sqrt(y);
        end
        
        
        function f = inverse(Psi,v)
            f =v.^2/4;
        end
    end
end

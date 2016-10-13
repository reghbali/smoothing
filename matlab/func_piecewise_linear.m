classdef func_piecewise_linear < func_concave
% objective function: min(.75,min(u,0.5*u+0.25))
    methods
        function Psi = func_piecewise_linear
         end
          
        function f = func_value(Psi, u)
        f = min(.75,min(u,0.5*u+0.25));
        end
        
        function g = conjugate_value(Psi,y)
        g = (min(y-.75,0.5*y-.5));
        end
        
         function grad = gradient(Psi,u)
        grad = 0.5 + 0.5*(u < 0.5); 
         end
         
        
        
        
    end
end

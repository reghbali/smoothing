classdef func_smooth 
% objective function: adwords min(u,1)
  properties 
   a;
   b;
    end
    methods
        function Psi = func_smooth(ag,bg)
            Psi.a = ag;
            Psi.b = bg;
            
         end
          
      
        
         function grad = gradient(Psi,u)
             n = length(u);
             grad = zeros(n,1);
             for l = 1:n
                for k = 1:(length(Psi.b)-1)
                    if (Psi.b(k) <= u(l)) && (u(l) < Psi.b(k+1))
                break
                    end
                end
                grad(l) = Psi.a(k);
            end
        
         end
         
         
        
    end
end

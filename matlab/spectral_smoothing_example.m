clear all;
close all;
gamma = 1;
n = 30;
k = 1;
kvector = 0.05:0.05:1.5;
for pc=1:length(kvector)
    k = kvector(pc);
for L = 3
m = 300;
lambda_range = 1;
t=(1:L*n)./n;
lambda=lambda_range*linspace(0,1,m);
for i=1:n*L
    for j=1:m
        %T(i,j) = (1+(lambda(j)))./(1+t(i)*lambda(j));
        T(i,j) = 1./(1-lambda(j)+t(i)*lambda(j));
        T1(i,j) = log((t(i)*lambda(j))/(1-lambda(j))+1)./lambda(j);
        T2(i,j) = lambda(j)./(1-lambda(j)+t(i)*lambda(j))^2;
    end
end

M = tril(ones(n*L,n*L));
b = zeros(L*n,1);
Psi = func_log
cvx_begin 
cvx_solver mosek
variable a(L*n,1)
variable v
variable mu(m,1)
 dual variable z
minimize max(v)%,(1./lambda)*mu+1)
%a(1) == 1
%a(n) == 0
%a(2:L*n) <= a(1:(L*n-1))
mu >= 0;
a == T*mu;
z : (gamma*M*a*(1/n) - Psi.conjugate_value(a))./(Psi.func_value((1/n:1/n:L)')) <= v
T2*mu <= k*a;
%
%z : (T1*mu - Psi.conjugate_value(T2*mu))./(Psi.func_value(t')) <= v

 cvx_end
compratio(L) = 1/cvx_optval;
beta(pc) = cvx_optval;
end
end

plotsettings;
 figure
 plot(kvector,beta)
xlabel('k')
ylabel('\beta')


figure
 plot(1:L,compratio)
xlabel('$u_{\max}$','Interpreter','Latex')
ylabel('comp. ratio')


x = (1/n):(1/n):L;
figure
hold on
plot(x, M*a*(1/n))
plot(x, Psi.func_value(x))
xlabel('$u$','Interpreter','Latex')
ylabel('$\psi(u)$','Interpreter','Latex')
legend('sm','or')
hold off


x = (1/n):(1/n):L;
figure
plot(x, (gamma*M*a*(1/n) - Psi.conjugate_value(a))./(Psi.func_value((1/n:1/n:L)')))
xlabel('$u$','Interpreter','Latex')
ylabel('$\beta(u)$','Interpreter','Latex')

% figure
% plot(conjugate(b'*M'*(1/n),(0:(1/n):L)')-Psi.conjugate_value((0:(1/n):L)'))
% 
% figure
% hold on
% plot(Psi.conjugate_value((0:(1/n):L)'))
% plot(conjugate(b'*M'*(1/n),(0:(1/n):L)'))
% legend('or','sm')


figure
stem(lambda,mu)

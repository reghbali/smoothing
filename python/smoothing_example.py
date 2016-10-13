from __future__ import division
import cvxpy as cvx
import numpy as np
import matplotlib.pyplot as plt
from function_class import func_adwords, func_log
#Instatiate the fcn
psi = func_adwords()
u_max = 1
n   = 100
M   = np.matrix(np.tril(np.ones((n,n)))/n)
u   = np.linspace(u_max/n,u_max,n)



# Create the optimization variables.
y = cvx.Variable(n,1)
beta = cvx.Variable()

# Create two constraints.
constraints = [ M*y- psi.conjugate_value(y) <= beta * psi.func_value(u), psi.extra_constraint(y)]

# Form objective.
obj = cvx.Minimize(beta)

# Form and solve problem.
prob = cvx.Problem(obj, constraints)
prob.solve()  # Returns the optimal value.
print("status:", prob.status)
print("optimal value", prob.value)
print("optimal var", y.value, beta.value)

plt.rcParams['xtick.labelsize'] = 12
plt.rcParams['ytick.labelsize'] = 12
plt.rcParams['legend.fontsize'] = 14
plt.rcParams['legend.loc'] = 'best'


#plot the original and the smooth function
fig, ax = plt.subplots(figsize = (10,5))
ax.plot(u,psi.func_value(u),'--r',u,(M*y).value,lw = 2)
ax.set_xlabel('$u$',fontsize = 16)
ax.legend(['$\psi$','$\psi_M$'])
ax.spines["top"].set_visible(False)
ax.spines["right"].set_visible(False)
ax.get_xaxis().tick_bottom()
ax.get_yaxis().tick_left()
plt.show()

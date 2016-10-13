from __future__ import division
import cvxpy as cvx
import numpy as np
import matplotlib.pyplot as plt
from function_class import func_adwords, func_log
#Instatiate the fcn
psi = func_adwords()
u_max = 100
n   = 100
M   = np.matrix(np.tril(np.ones((n,n)))/n)
u   = np.linspace(u_max/n,u_max,n)
c_vec = np.linspace(0,1,10)


# Create the optimization variables.
y = cvx.Variable(n,1)
beta = cvx.Variable()

# Create the constraints.
constraints = [0,psi.extra_constraint(y)]
# Form objective.
obj = cvx.Minimize(beta)

# Form and solve problem.
comp_ratio_vec = [];
for i,c in enumerate(c_vec):
    constraints[0] = M * y - psi.conjugate_value(y) + c * (y[0] - y) <= beta * psi.func_value(u)
    prob = cvx.Problem(obj, constraints)
    prob.solve(verbose = True)  # Returns the optimal value.
    comp_ratio_vec += [prob.value]
    print("status:", prob.status)
    print("optimal value", prob.value)
    print("optimal var", y.value, beta.value)

plt.rcParams['xtick.labelsize'] = 12
plt.rcParams['ytick.labelsize'] = 12
plt.rcParams['legend.fontsize'] = 14
plt.rcParams['legend.loc'] = 'best'


#plot the original and the smooth function
fig, ax = plt.subplots(figsize = (6.5,5))
ax.plot(c_vec,comp_ratio_vec,lw = 2)
ax.set_xlabel('$c$',fontsize = 16)
ax.set_ylabel('competitive ratio',fontsize = 16)
ax.spines["top"].set_visible(False)
ax.spines["right"].set_visible(False)
ax.get_xaxis().tick_bottom()
ax.get_yaxis().tick_left()
plt.show()
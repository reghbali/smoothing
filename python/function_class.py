from __future__ import division
import numpy as np
import cvxpy as cvx


class func_concave(object):
    """Parent class for all concave functions"""
    
    def func_value(self,u):
        """returns function value"""
        raise NotImplementedError()

    def gradient(self,u):
        """returns gradient or right derivative"""
        raise NotImplementedError()

    def conjugate_value(self,y):
        """returns conjugate function value"""
        raise NotImplementedError()


class func_adwords(func_concave):
    """Adwords :     min(u,1)"""

    def func_value(self,u):
        return np.minimum(u,1)

    def gradient(self,u):
        return (u < 1).astype(int)

    def conjugate_value(self,y):
        return cvx.min_elemwise(y-1,0)  # returns cvx expression. To evluate use .value

    def extra_constraint(self,y):
        return y[-1] == 0


class func_log(func_concave):
    """log(u+1)"""

    def func_value(self,u):
        return np.log(u + 1)

    def gradient(self,u):
        return 1/(u+1)

    def conjugate_value(self,y):
        return cvx.log(y)-y+1

    def extra_constraint(self,y):
        return y[1:]-y[:-1] <= 0


class func_inverse(func_concave):
    """1 - 1 / (u + 1)"""

    def func_value(self,u):
        return 1-1/(u + 1)

    def gradient(self,u):
        return 1/(u+1)**2

    def conjugate_value(self,y):
        return 2*cvx.sqrt(y)-y-1

    def extra_constraint(self,y):
        return y[1:]-y[:-1] <= 0


class func_linear_budget(func_concave):
    """-pos(u-1),   pos is positive part"""

    def __init__(self,l):
        self.l = l

    def func_value(self,u):
        return np.minimum(1 - u , 0)

    def gradient(self,u):
        return (u >= 1).astype(float)

    def conjugate_value(self,y):
        return y

    def extra_constraint(self,y):
        return [y[-1] <= - self.l, y <= 0]

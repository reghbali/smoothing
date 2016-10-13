from function_class import*
import numpy as np
def test_adwords():
    u = np.array([0,1,2])
    y = np.array([0,.5,1])
    f = func_adwords()
    v = f.func_value(u)
    g = f.gradient(u)
    c = (f.conjugate_value(y)).value
    assert (v == np.array([0,1,1])).all
    assert (g == np.array([1,1,0])).all
    assert (c == np.array([-1,-0.5,0])).all


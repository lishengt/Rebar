import numpy as np


class Task:
    def __init__(self, dimension=None, task=None):
        self.dimension = dimension
        self.task = task

    def solve(self, x, num=None):
        if num is None:
            return np.array([self.ackley(x), self.sphere(x)])
        elif num == 0:
            return np.array(self.ackley(x))
        elif num == 1:
            return np.array(self.sphere(x))
        else:
            raise Exception('Have no this task!')

    def ackley(self, x, a=20, b=0.2, c=2 * np.pi):
        upper = 32
        lower = -32
        mm = x
        x = np.array(x) * (upper - lower) + lower
        d = len(x)
        g = -a * np.exp(-b * np.sqrt(1 / d * np.sum(x**2)))
        try:
            cx = c * x
            t = np.cos(cx)
            h = -np.exp((1 / d) * np.sum(np.cos(c * x))) + a + np.exp(1)
            return g + h
        except AttributeError:
            print('AttributeError:' + str(x))

    def sphere(self, x):
        upper = 5
        lower = -5
        x = np.array(x) * (upper - lower) + lower
        return np.sum(x**2)

    def rosenbrock(self, x):
        x = np.array(x)
        back = x[1:]
        front = x[0:-1]
        g = 100 * (back - front**2)**2
        h = (front - 1)**2
        return np.sum(g + h)
from grid import Grid
import pandas as pd
import numpy as np


def get_attribute(t, step):
    z_attribute = {
        'base': np.array([0, 0, 1]),
        'static': np.array([0, 0, 0]),
        'forward': np.array([0, 0, step]),
        'up': np.array([-step, 0, 0]),
        'down': np.array([step, 0, 0]),
        'left': np.array([0, -step, 0]),
        'right': np.array([0, step, 0])
    }

    y_attribute = {
        'base': np.array([0, 1, 0]),
        'static': np.array([0, 0, 0]),
        'forward': np.array([0, step, 0]),
        'up': np.array([0, 0, step]),
        'down': np.array([0, 0, -step]),
        'left': np.array([-step, 0, 0]),
        'right': np.array([step, 0, 0])
    }

    x_attribute = {
        'base': np.array([1, 0, 0]),
        'static': np.array([0, 0, 0]),
        'forward': np.array([step, 0, 0]),
        'up': np.array([0, 0, step]),
        'down': np.array([0, 0, -step]),
        'left': np.array([0, step, 0]),
        'right': np.array([0, -step, 0])
    }

    if t == 'zaxis':
        return z_attribute
    elif t == 'yaxis':
        return y_attribute
    elif t == 'xaxis':
        return x_attribute
    else:
        raise Exception('Type must be one of zaxis, yaxis and xaxis')


def setting(t, n_steps, step):
    """
    t:type
    d:direction
    n_steps:the number of steps
    step:step length
    """

    grid = Grid(x=1200, y=1200, z=1200, step=step)

    d = ['zaxis', 'yaxis', 'xaxis']

    zyx = {'zaxis': None, 'yaxis': None, 'xaxis': None}

    file_path = 'C:/Users/Administrator/Desktop/Code/Python/rebar/datas'

    n_tasks = []
    for e in d:
        start_path = file_path + '/' + t + '/' + e + '/' + 'start.xlsx'
        end_path = file_path + '/' + t + '/' + e + '/' + 'goal.xlsx'
        start = np.array(pd.read_excel(start_path, header=None))
        end = np.array(pd.read_excel(end_path, header=None))

        attribute = get_attribute(e, step)

        data = dict()

        num = len(start)
        n_tasks.append(num)
        for i in range(num):
            data['task{}'.format(i + 1)] = {
                'dimension': n_steps,
                'task': n_tasks,
                'parameter': {
                    'start': start[i],
                    'end': end[i],
                    'base': attribute['base'],
                    'static': attribute['static'],
                    'forward': attribute['forward'],
                    'up': attribute['up'],
                    'down': attribute['down'],
                    'left': attribute['left'],
                    'right': attribute['right'],
                },
                'grid': grid
            }

        zyx[e] = data

    return n_tasks, grid, zyx


if __name__ == '__main__':
    n_steps = 2
    step = 20
    t = 'interior'

    set(t, n_steps, step)

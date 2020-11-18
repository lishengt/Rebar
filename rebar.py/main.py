from mfea.mfea import MFEA
from tasks.bar import Task
from out import Out
from get_data import setting
from draw import draw
import numpy as np

out = Out()


def weight(n_steps):
    return np.array([1 / (n_steps + 1) + i * 1 / (n_steps + 1) for i in range(n_steps)])


def is_end(x, task):
    if x is None:
        return False
    else:
        is_complete = 0
        for i in range(task.task):
            task.tasks[i].parameter['start'] = x[i]
            if np.array_equal(task.tasks[i].parameter['start'], task.tasks[i].parameter['end']):
                is_complete += 1
            # if np.linalg.norm(task.tasks[i].parameter['start']-task.tasks[i].parameter['end']) <= 10:
            #     is_complete += 1
        if is_complete == task.task:
            return True
        else:
            return False


n_steps = 2
step = 20

w = weight(n_steps+1)

n_tasks, grid, parameters = setting('interior', n_steps, step)

d = ['zaxis', 'yaxis', 'xaxis']
m = 0

for num, k in zip(n_tasks, parameters):

    coordinates = {'task{}'.format(i + 1): [] for i in range(num)}

    Task.flag = True
    task = Task(dimension=n_steps, task=num, w=w, parameter_list=parameters[k])

    while True:
        mfea = MFEA(30, task, gen=150)
        res = mfea.optimize()
        current_end = grid.update(res['best'], task.tasks, coordinates)

        if is_end(current_end, task):
            break

    out.append(d[m], coordinates)
    m += 1

draw(out)
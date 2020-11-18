import numpy as np


class Task:
    flag = True

    STATIC = 0
    FORWARD = 1
    UP = 2
    DOWN = 3
    LEFT = 4
    RIGHT = 5

    grid = None

    w = None

    def __init__(self, dimension=None, task=None, parameter=None, grid=None, w=None, parameter_list=None):
        self.dimension = dimension
        self.task = task
        self.parameter = parameter

        Task.grid = grid

        if Task.flag:
            Task.flag = False
            Task.w = w
            self.tasks = self._tasks(parameter_list)

    @classmethod
    def _tasks(cls, parameter_list):
        tasks = [cls(v['dimension'], v['task'], v['parameter'], v['grid']) for v in parameter_list.values()]
        return tasks

    def solve(self, x, num=None):
        if num is None:
            return np.array([task._bar(x) for task in self.tasks])
        elif 0 <= num <= self.task:
            task = self.tasks[num]
            return task._bar(x)
        else:
            raise Exception('Have no this task!')

    def _bar(self, x):
        start = self.parameter['start']
        end = self.parameter['end']

        upper, lower = 5, 0

        x = np.floor(np.array(x) * (upper - lower) + lower)

        sequences = np.zeros((self.dimension + 1, 3))
        sequences[0, :] = start
        cst1 = 0
        cst2 = 0
        for i, direction in enumerate(x):
            if direction == Task.STATIC:
                sequences[i + 1, :] = sequences[i, :] + self.parameter['static']
            elif direction == Task.FORWARD:
                sequences[i + 1, :] = sequences[i, :] + self.parameter['forward']
            elif direction == Task.UP:
                sequences[i + 1, :] = sequences[i, :] + self.parameter['up']
            elif direction == Task.DOWN:
                sequences[i + 1, :] = sequences[i, :] + self.parameter['down']
            elif direction == Task.LEFT:
                sequences[i + 1, :] = sequences[i, :] + self.parameter['left']
            elif direction == Task.RIGHT:
                sequences[i + 1, :] = sequences[i, :] + self.parameter['right']
            else:
                print(direction)
                raise Exception('Have no such direction')

            if self.grid.is_collision(sequences[i + 1, :]):
                cst1 = 1e+6

            if sequences[i+1, 0] < 0 or sequences[i+1, 0] > 1200 or sequences[i+1, 1] < 0 or sequences[i+1, 1] > 1200 \
                    or sequences[i+1, 2] < 0 or sequences[i+1, 2] > 1200:
                cst2 = 1e+6

        g = np.linalg.norm(sequences[-1] - start)
        h = np.linalg.norm(end - sequences[-1])

        return 0.1 * g + 0.9 * h + cst1 + cst2

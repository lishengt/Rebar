import numpy as np


class Grid:
    def __init__(self, x, y, z, step):
        self.x = x
        self.y = y
        self.z = z
        self.step = step

        self.grid = self._create_grid()

        self.size = self.grid.shape

    def _create_grid(self):
        return np.zeros((self.x//self.step+1, self.y//self.step+1, self.z//self.step+1), dtype=int)

    def get_location(self, point):
        x, y, z = point / self.step
        return int(x), int(y), int(z)

    def is_collision(self, point):
        x, y, z = self.get_location(point)
        if x >= self.size[0] or y >= self.size[1] or z >= self.size[2]:
            return True
        elif self.grid[x, y, z] == 1:
            return True
        else:
            return False

    def update(self, best, tasks, coordinates):

        end_point = []

        for k, x in enumerate(best):
            steps = len(x)

            upper, lower = 5, 0
            x = np.floor(np.array(x) * (upper - lower) + lower)

            sequences = np.zeros((steps + 1, 3))
            sequences[0, :] = tasks[k].parameter['start']
            for i, direction in enumerate(x):
                if direction == 0:
                    sequences[i + 1, :] = sequences[i, :] + tasks[k].parameter['static']
                elif direction == 1:
                    sequences[i + 1, :] = sequences[i, :] + tasks[k].parameter['forward']
                elif direction == 2:
                    sequences[i + 1, :] = sequences[i, :] + tasks[k].parameter['up']
                elif direction == 3:
                    sequences[i + 1, :] = sequences[i, :] + tasks[k].parameter['down']
                elif direction == 4:
                    sequences[i + 1, :] = sequences[i, :] + tasks[k].parameter['left']
                elif direction == 5:
                    sequences[i + 1, :] = sequences[i, :] + tasks[k].parameter['right']
                else:
                    raise Exception('Error in update')

                x, y, z = self.get_location(sequences[i+1, :])
                self.grid[x, y, z] = 1

                if np.array_equal(sequences[-1, :], tasks[k].parameter['end']):
                    break
            end_point.append(sequences[-1, :])
            for j in range(steps):
                coordinates['task{}'.format(k+1)].append(sequences[j, :].tolist())

        return end_point

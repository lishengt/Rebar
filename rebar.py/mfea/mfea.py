import numpy as np


class Individual:
    def __init__(self, task):
        self.x = np.random.rand(task.dimension)
        self.factorial_costs = np.ones(task.task) * np.inf
        self.factorial_ranks = np.ones(task.task) * np.inf
        self.scalar_fitness = None
        self.skill_factor = None


class MFEA:
    def __init__(self, n_individuals, task, rmp=0.3, eta=10, gen=100):
        self.n_individuals = n_individuals
        self.task = task

        self.rmp = rmp
        self.eta = eta

        self.gen = gen

    def _initialization(self):
        pop = []

        for i in range(self.n_individuals):
            individual = Individual(self.task)
            individual.skill_factor = i % self.task.task

            individual.factorial_costs[individual.skill_factor] = self.task.solve(individual.x,
                                                                                  individual.skill_factor)
            pop.append(individual)

        return pop

    def _crossover(self, father, mother, off1, off2):
        for j in range(self.task.dimension):
            mu = np.random.rand()
            if mu <= 0.5:
                beta = (2 * mu) ** (1 / (self.eta + 1))
            else:
                beta = (2 - 2 * mu) ** (-1 / (self.eta + 1))
            off1.x[j] = 0.5 * ((1 + beta) * father.x[j] + (1 - beta) * mother.x[j])
            off2.x[j] = 0.5 * ((1 - beta) * father.x[j] + (1 + beta) * mother.x[j])
        off1.x[off1.x > 1] = 1
        off1.x[off1.x < 0] = 0
        off2.x[off2.x > 1] = 1
        off2.x[off2.x < 0] = 0
        return off1, off2

    def _mutate(self, parent, off):
        for j in range(self.task.dimension):
            off.x[j] = np.random.normal(loc=0, scale=0.02) + parent.x[j]
        off.x[off.x > 1] = 1
        off.x[off.x < 0] = 0
        return off

    def evolution(self, pop):

        index = np.random.permutation(self.n_individuals)

        off = []

        for i in range(self.n_individuals // 2):
            father, mother = pop[index[i * 2]], pop[index[i * 2 + 1]]
            off1, off2 = Individual(self.task), Individual(self.task)

            if father.skill_factor == mother.skill_factor:
                off1, off2 = self._crossover(father, mother, off1, off2)

                off1.skill_factor = father.skill_factor
                off2.skill_factor = mother.skill_factor
            elif np.random.rand() < self.rmp:
                off1, off2 = self._crossover(father, mother, off1, off2)

                parent = np.random.choice([father, mother])
                off1.skill_factor = parent.skill_factor
                parent = np.random.choice([father, mother])
                off2.skill_factor = parent.skill_factor
            else:
                off1 = self._mutate(father, off1)
                off1.skill_factor = father.skill_factor

                off2 = self._mutate(mother, off2)
                off2.skill_factor = mother.skill_factor
            if off1 is None or off2 is None:
                raise Exception('Evolution error!')
            else:
                off1.factorial_costs[off1.skill_factor] = self.task.solve(off1.x, off1.skill_factor)
                off2.factorial_costs[off2.skill_factor] = self.task.solve(off2.x, off2.skill_factor)
                off += [off1, off2]

        return off

    def selection(self, pop):
        pop = sorted(pop, key=lambda e: e.scalar_fitness, reverse=True)
        return pop[:self.n_individuals]

    def combine(self, pop, off):
        _pop = pop + off

        for i in range(self.task.task):
            _pop.sort(key=lambda e: e.factorial_costs[i])
            for j, individual in enumerate(_pop):
                individual.factorial_ranks[i] = j + 1
        for individual in _pop:
            assert len(individual.factorial_ranks) == self.task.task
            individual.scalar_fitness = 1.0 / np.min(individual.factorial_ranks)
        return _pop

    def optimize(self):

        res = {'pop': None, 'best': None}

        pop = self._initialization()

        for i in range(self.gen):
            off = self.evolution(pop)
            inter_pop = self.combine(pop, off)
            pop = self.selection(inter_pop)

        best = []
        for i in range(self.task.task):
            pop.sort(key=lambda e: e.factorial_costs[i])
            best.append(pop[0].x)

        res['pop'] = pop
        res['best'] = best

        return res


if __name__ == '__main__':
    from tasks.so import Task

    task = Task(dimension=2, task=2)

    mfea = MFEA(30, task)

    out = mfea.optimize()

    for individual in out['pop']:
        print(individual.x)

class Out:
    def __init__(self):
        self.X = []
        self.Y = []
        self.Z = []

    def append(self, mold, element):
        if mold == 'xaxis':
            self.X.append(element)
        elif mold == 'yaxis':
            self.Y.append(element)
        elif mold == 'zaxis':
            self.Z.append(element)

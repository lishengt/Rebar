from matplotlib import pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import numpy as np


def draw(out):
    fig = plt.figure()
    ax = Axes3D(fig)

    z_dict = out.Z[0]
    y_dict = out.Y[0]
    x_dict = out.X[0]

    for v in z_dict.values():
        z_x = [e[0] for e in v]
        z_y = [e[1] for e in v]
        z_z = [e[2] for e in v]

        ax.plot(z_x, z_y, z_z)

    for v in y_dict.values():
        y_x = [e[0] for e in v]
        y_y = [e[1] for e in v]
        y_z = [e[2] for e in v]

        ax.plot(y_x, y_y, y_z)

    for v in x_dict.values():
        x_x = [e[0] for e in v]
        x_y = [e[1] for e in v]
        x_z = [e[2] for e in v]

        ax.plot(x_x, x_y, x_z)

    ax.set_xlabel('X-Axis')
    ax.set_ylabel('Y-Axis')
    ax.set_zlabel('Z-Axis')

    plt.show()


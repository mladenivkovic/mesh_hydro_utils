#!/usr/bin/env python3

# -----------------------------------------------------------------
# Create Rayleigh-Taylor instability initial
# conditions following Abel 2011
# (https://ui.adsabs.harvard.edu/abs/2011MNRAS.413..271A/abstract)
# -----------------------------------------------------------------


import numpy as np
from mesh_hydro_utils import write_ic


nx = 512

dx = 1.0 / nx
gamma = 5.0 / 3


# set density profile
rho = np.empty((nx, nx), dtype=float)
rho1 = 1
rho2 = 2
Delta = 0.025
for j in range(nx):
    y = (j + 0.5) * dx
    rho[:, j] = rho1 + (rho2 - rho1) / (1.0 + np.exp(-(y - 0.5) / Delta))

# set pressure
p = np.ones((nx, nx), dtype=float) * rho2 / gamma

# set velocities
u = np.zeros((nx, nx, 2), dtype=float)
delta = 0.025
for i in range(nx):
    x = (i + 0.5) * dx
    for j in range(nx):
        y = (j + 0.5) * dx

        if (y > 0.3) and (y < 0.7):
            vel = delta * (1.0 + np.cos(8 * np.pi * (x + 0.25)))
            vel *= 1.0 + np.cos(5 * np.pi * (y - 0.5))
            u[i, j, 1] = vel


write_ic("rayleigh-taylor-{0:d}.dat".format(nx), 2, rho, u, p)

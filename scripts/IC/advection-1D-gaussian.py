#!/usr/bin/env python3

# ---------------------------------------------------
# Create IC conditions for 1D advection where the
# profile is a gaussian
# ---------------------------------------------------


import numpy as np
from mesh_hydro_utils import write_ic


nx = 256


rho = np.zeros(nx, dtype=float)
u = np.ones(nx, dtype=float)
p = np.ones(nx, dtype=float)


dx = 1.0 / nx

for i in range(nx):
    x = (i + 0.5) * dx
    rho[i] = 1 + 2 * np.exp(-((x - 0.5) ** 2 / 0.05))


write_ic("advection-1D-gaussian-{0:d}.dat".format(nx), 1, rho, u, p)

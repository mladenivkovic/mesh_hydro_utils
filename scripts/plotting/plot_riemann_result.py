#!/usr/bin/env python3


# ----------------------------------------------------
# Plot results of a 1D or 2D file as 1D solutions,
# and overplot the analytical solution to the Riemann
# problem.
#
# Usage:
#   ./plot_riemann_result.py <outputfile> <IC-file>
#
# it needs the IC file as well in order do be able to
# solve the riemann problem. If you just want to plot
# the results, use the appropriate scripts.
# ----------------------------------------------------


from mesh_hydro_utils import (
    read_ic,
    read_output,
    check_file_exists,
    label_to_kwargs,
    riemann_solver,
    plot_1D,
    plot_savefig,
)
from sys import argv
import numpy as np


if __name__ == "__main__":
    fname = argv[1]
    check_file_exists(fname)
    icfname = argv[2]
    check_file_exists(icfname)

    ndim, rho, u, p, t, step = read_output(fname)

    label = t

    if ndim == 2:
        rho = np.mean(rho, axis=0)
        u = np.mean(u[:, :, 0], axis=0)
        p = np.mean(p, axis=0)
        label = "t = {0:.3f}; mean value along y".format(t)

    ndim, twostate, rhoIC, uIC, pIC = read_ic(icfname, nx=rho.shape[0])

    if twostate:
        kwargs = label_to_kwargs(label)
        fig = plot_1D(rho, u, p, draw_legend=True, kwargs=kwargs)

        rho_sol, u_sol, p_sol = riemann_solver(rhoIC, uIC, pIC, t)
        kwargs = {"linestyle": "--"}
        kwargs = label_to_kwargs(t="python solver", kwargs=kwargs)
        fig = plot_1D(rho_sol, u_sol, p_sol, draw_legend=True, fig=fig, kwargs=kwargs)

        plot_savefig(fig, fname, case="not-overplotted")

    else:
        print("Can't work with non-riemann ICs.")

#!/usr/bin/env python3


# --------------------------------------------------------------------------------
# Plot results of a 1D or 2D file as 1D solutions, and overplot the analytical
# solution to the Riemann problem for an arbitrary number of files.
#
# Usage:
#   ./plot_all_riemann_result.py <file1> <file2> ... <fileN> <IC-file>
#
# it needs the IC file as well in order do be able to solve the riemann problem.
# If you just want to plot the results, use the appropriate scripts.
# --------------------------------------------------------------------------------


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
    # last file needs to be IC file
    nfiles = len(argv) - 2
    icfname = argv[-1]

    fig = None

    for fname in argv[1:-1]:
        check_file_exists(fname)
        ndim, rho, u, p, t, step = read_output(fname)

        label = fname.replace("_", "-")

        if ndim == 2:
            rho = np.mean(rho, axis=0)
            u = np.mean(u[:, :, 0], axis=0)
            p = np.mean(p, axis=0)
            label = fname.replace("_", "-") + r"; mean value along y"

        kwargs = label_to_kwargs(label)
        fig = plot_1D(rho, u, p, draw_legend=True, kwargs=kwargs, fig=fig)

    check_file_exists(icfname)
    ndim, twostate, rhoIC, uIC, pIC = read_ic(icfname, nx=rho.shape[0])

    if twostate:
        rho_sol, u_sol, p_sol = riemann_solver(rhoIC, uIC, pIC, t)
        kwargs = {"linestyle": "--"}
        kwargs = label_to_kwargs(t="python solver", kwargs=kwargs)
        fig = plot_1D(rho_sol, u_sol, p_sol, draw_legend=True, fig=fig, kwargs=kwargs)

        plot_savefig(fig, fname, case="overplotted")

    else:
        print("Can't work with non-riemann ICs.")

#!/usr/bin/env python3


# --------------------------------------------------------
# Solve Riemann problem and plot results of a 1D
# two-state IC file and sample the solution at given time t
#
# Usage:
#   ./solve_riemann.py <ic file> <t>
# --------------------------------------------------------


from mesh_hydro_utils import read_ic, check_file_exists, riemann_solver, plot_1D, plot_savefig, label_to_kwargs
from sys import argv
from matplotlib import pyplot as plt


if __name__ == "__main__":
    fname = argv[1]
    check_file_exists(fname)
    t = float(argv[2])

    nsim, twostate, rhoIC, uIC, pIC = read_ic(fname, nx=200)

    if twostate:
        rho_sol, u_sol, p_sol = riemann_solver(rhoIC, uIC, pIC, t)
        fig = plot_1D(
            rho_sol, u_sol, p_sol, draw_legend=True, kwargs=label_to_kwargs(t)
        )
        plot_savefig(fig, fname, case="riemann-solver")

    else:
        print("Can't work with non-riemann ICs.")

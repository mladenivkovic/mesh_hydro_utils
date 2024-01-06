#!/usr/bin/env python3


# -------------------------------------
# Create a plot of an IC file.
# Usage:
#   plot_IC.py file.dat
# -------------------------------------


from mesh_hydro_utils import get_only_cmdlinearg, read_ic, plot_1D, plot_2D, plot_savefig


if __name__ == "__main__":
    fname = get_only_cmdlinearg()
    ndim, twostate, rho, u, p = read_ic(fname)

    if ndim == 1:
        fig = plot_1D(rho, u, p)
    elif ndim == 2:
        fig = plot_2D(rho, u, p)

    plot_savefig(fig, fname)

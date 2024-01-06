#!/usr/bin/env python3


# -------------------------------------
# Create a plot of an output file.
# Usage:
#   plot_result.py file.out
# -------------------------------------


from mesh_hydro_utils import (
    get_only_cmdlinearg,
    read_output,
    plot_1D,
    plot_2D,
    plot_savefig,
)


if __name__ == "__main__":
    fname = get_only_cmdlinearg()
    ndim, rho, u, p, t, step = read_output(fname)

    if ndim == 1:
        fig = plot_1D(rho, u, p)
        plot_savefig(fig, fname)
    elif ndim == 2:
        fig = plot_2D(rho, u, p, t=t)
        plot_savefig(fig, fname)

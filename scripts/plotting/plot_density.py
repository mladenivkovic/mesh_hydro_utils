#!/usr/bin/env python3


# -------------------------------------
# Create a plot of an output file.
# Plots only the density.
# Usage:
#   plot_density.py file.out
# -------------------------------------


from mesh_hydro_utils import (
    get_only_cmdlinearg,
    label_to_kwargs,
    read_output,
    plot_1D_density_only,
    plot_2D_density_only,
    plot_savefig,
)


if __name__ == "__main__":
    fname = get_only_cmdlinearg()
    ndim, rho, u, p, t, step = read_output(fname)

    if ndim == 1:
        fig = plot_1D_density_only(rho, draw_legend=True, kwargs=label_to_kwargs(t))
    elif ndim == 2:
        fig = plot_2D_density_only(rho, t=t)

    plot_savefig(fig, fname, case="density")

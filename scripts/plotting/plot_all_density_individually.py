#!/usr/bin/env python3


# ------------------------------------------------------------------------------------
# Create a plot of the result for every file given as cmdline argument.
# Plots all results in individual images.
#
# Usage:
#   plot_all_density_individually.py <file1> <file2> ... <file N>
# ------------------------------------------------------------------------------------


from mesh_hydro_utils import (
    read_output,
    plot_1D_density_only,
    plot_2D_density_only,
    plot_savefig,
    label_to_kwargs,
)

from sys import argv


if __name__ == "__main__":
    filelist = argv[1:]

    for fname in filelist:
        ndim, rho, u, p, t, step = read_output(fname)

        if ndim == 1:
            kwargs = label_to_kwargs(t)
            fig = plot_1D_density_only(rho, draw_legend=True, kwargs=kwargs)
        elif ndim == 2:
            fig = plot_2D_density_only(rho, t=t)

        plot_savefig(fig, fname, case="density")

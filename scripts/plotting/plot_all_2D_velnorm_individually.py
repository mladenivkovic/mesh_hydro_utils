#!/usr/bin/env python3


# ------------------------------------------------------------------------------------
# Create a plot of the result for every file given as cmdline argument.
# Plots all results in individual images.
# Don't plot individual velocity components, but the norm.
#
# Usage:
#   plot_all_results_individually.py <file1> <file2> ... <file N>
# ------------------------------------------------------------------------------------


from mesh_hydro_utils import read_output, plot_1D, plot_2D_velnorm, plot_savefig

from sys import argv
import numpy as np


if __name__ == "__main__":
    filelist = argv[1:]

    for fname in filelist:
        ndim, rho, u, p, t, step = read_output(fname)

        if ndim == 1:
            fig = plot_1D(rho, np.abs(u), p)
        elif ndim == 2:
            fig = plot_2D_velnorm(rho, u, p, t=t)

        plot_savefig(fig, fname)

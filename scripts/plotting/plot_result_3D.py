#!/usr/bin/env python3


# ------------------------------------------------------------
# Create a plot of an output file.
# If it's a 1D output file, it creates the same as the
# plot_result.py script. If it's a 2D output file, it makes a
# 3D surface plot.
#
# Usage:
#   plot_result_3D.py file.out
# ------------------------------------------------------------


from mesh_hydro_utils import get_only_cmdlinearg, read_output, plot_1D, plot_2D_in_3D, plot_savefig

if __name__ == "__main__":
    fname = get_only_cmdlinearg()
    ndim, rho, u, p, t, step = read_output(fname)

    if ndim == 1:
        fig = plot_1D(rho, u, p)
        plot_savefig(fig, fname)
    elif ndim == 2:
        fig = plot_2D_in_3D(rho, u, p, t=t)
        plot_savefig(fig, fname, case="3D")

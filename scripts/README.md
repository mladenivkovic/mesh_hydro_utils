Python Scripts
==============

TODO: Installation instructions

If you're not sure how to run the scripts, look at the comments left at the top
of the respective files. Additionally, there should be an example of a valid use
in the `/mesh_hydro_utils/tests/run.sh` script.


IC
------------------

In the `./IC` directory. Scripts to generate **I**nitial **C**onditions (ICs).
Run them to generate some easy to do profiles etc.

`output_to_IC.py` generates an IC file from a result file.



Misc
-----------------

Miscellaneous other scripts that don't fit anywhere else. Converting an output
file to hdf5, for example.






Plotting
------------------

In the `./plotting` directory. In the following, "output" refers to output files
created by running the hydro code. They typically have the suffix `.out`.

Plotting Hydro/Advection Output
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- `movie_density.py`: Plot the density of all given output files. You need to
  fix some parameters manually in the script so that the images are standardized
  to make a movie out of it.

- `plot_all_density_individually.py`: Plots all results given in individual
  images. Only plots the density.

- `plot_all_density.py`: Overplots all results in one plot. **Only works for
  1D.** Only plots the density.

- `plot_all_results_individually.py`: Plots all results given in individual
  images.

- `plot_all_results.py`: Overplots all results in one plot. **Only works for
  1D.**

- `plot_density.py`: Plots output, density only.

- `plot_result_3D.py`: Plot output written by the hydro code. Plot 2D results in
  a 3D surface plot.

- `plot_result.py`: Plot output written by the hydro code. It'll figure out the
  dimension etc by itself.




Plotting Riemann Solver Output
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- `plot_riemann_result.py`: Plot the output of a two-state/Riemann problem, and
  overplot analytical solution.

- `solve_riemann.py`: Solve a riemann problem from a given IC at a given time
  and plot it.

- `plot_all_riemann_results.py`: Plot results of a 1D or 2D file as 1D
  solutions, and overplot the analytical solution to the Riemann problem for an
  arbitrary number of files.



Plotting Initial Conditions
~~~~~~~~~~~~~~~~~~~~~~~~~~~

- `plot_IC_3D.py`: Plot some initial conditions file. Plot 2D IC in a 3D surface
  plot.

- `plot_IC.py`: Plot some initial conditions file. It figures out what type of
  IC it is and what dimension it is by itself.







Evaluations
------------------

Contains plotting, comparing, and evaluation scripts for different tasks.
E.g. compute and plot the convergence of a class of methods depending on grid spacing, dt, ...
The scripts in there are meant to be called from bash scripts in `/sh`.



Testing
-----------------
The testing directory has some output and IC files so you can test your scripts on it.




Want to build your own scripts?
=============================================


Here's some hints:

- Reading in stuff: Use `read_output(...)` or `read_IC(...)` functions in `hydro_io.py`
- Writing outputs: Use `write_ic(...)` from `hydro_io.py`
- plotting stuff:
    - use the `plot_*` functions in `hydro_plotting.py`
    - plotting multiple figures in one plot: every `plot_1D*` function returns the `matplotlib.pyplot.figure()` object, and accepts such a figure object as keyword argument. So you can just pass the same figure object as the kwarg to overplot stuff in it. Overplotting stuff in 2D doesn't make sense, so it's not implemented.
    - every `plot_*` function accepts a dict `kwargs` that is passed on to the `pyplot.plot()` or `pyplot.imshow()` for 2D or `pyplot.plot_surface()` in 3D, where you can put in line styles, labels, ...
    - to save a figure: Either call `pyplot.savefig()` from your own script, or call `plot_savefig` from `hydro_plotting`

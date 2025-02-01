# Mesh Hydro Utils

`mesh_hyrdo_utils` is a python module containing convenience utilities for the
[mesh-hydro](https://github.com/mladenivkovic/mesh-hydro) and
[hydro-playground](https://github.com/mladenivkovic/hydro-playground) codes. It
hosts both a python module with functions to read outputs and write initial
conditions for the two codes, as well as some simple scripts to create plots
etc.


## Installation

You can install a local version of the package by cloning the repository using
git. First, clone the 
[github repository](https://github.com/mladenivkovic/mesh_hydro_utils):

```
git clone https://github.com/mladenivkovic/mesh_hydro_utils  # get the git repository
cd mesh_hydro_utils                                          # go into the directory
python3 -m pip install .                                     # install package
```


Alternately, this package is shipped as part of both the
[mesh-hydro](https://github.com/mladenivkovic/mesh-hydro) and
[hydro-playground](https://github.com/mladenivkovic/hydro-playground) codes as a
a `git submodule`. To initialize them (here for `mesh-hydro`, works analoguely
for `hydro-playground`), run:


```
git clone https://github.com/mladenivkovic/mesh-hydro  # get the git repository
cd mesh-hydro                                          # go into the repo directory
git submodule init                                     # init the submodule 
git submodule update                                   # fetch submodule contents
cd mesh_hydro_init                                     # get into the python module dir
python3 -m pip install .                               # install package
```


Alternatively (***albeit very discouraged***), you can add the repository
directory to your `$PYTHONPATH`.




### Optional Dependencies


You can install with hdf5 support to convert outputs to hdf5:

```
pip3 install mesh_hydro_utils[hdf5]
```

or

```
cd mesh_hydro_utils
pip3 install -e .[hdf5]
```

if you're installing from source.






## Contents

- `mesh_hydro_utils`
  The actual python module.
  - `mesh_hydro_utils/mesh_hydro_io.py`: Input/Output related functions.
  - `mesh_hydro_utils/mesh_hydro_plotting.py`: Plotting related functions.
  - `mesh_hydro_utils/mesh_hydro_riemann.py`: Riemann solver.
  - `mesh_hydro_utils/mesh_hydro_utilities.py`: Misc minor utilities.

- `scripts`
  Contains convenience and utility python scripts based on this module.
  See `scripts/README.md` for more.

- `testing`
  The testing directory has some output and IC files so you can test your
  scripts on it. Use the `run.sh` script to try out a suite of available
  scripts.



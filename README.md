# Mesh Hydro Utils

`mesh_hyrdo_utils` is a python module containing convenience utilities for the
[mesh-hydro](https://github.com/mladenivkovic/mesh-hydro) and
[hydro-playground](https://github.com/mladenivkovic/hydro-playground) codes. It
hosts both a python module with functions to read outputs and write initial
conditions for the two codes, as well as some simple scripts to create plots
etc.


## Installation

### From PyPI

TODO: fix PyPI link once it's up



`mesh_hyrdo_utils` is available on [PyPI](https://pypi.org/project/SOMETHING/),
and can obtained any regular way you'd install a python package, e.g. using
`pip`, `conda`, etc.

For example, using `pip`:

```
python3 -m pip install mesh_hydro_utils
```



### From Source

Alternately, the source code is available on
[github](https://github.com/mladenivkovic/mesh_hydro_utils). You can install a
local version by cloning the repository using git.

```
git clone https://github.com/mladenivkovic/mesh_hydro_utils  # get the git repository
cd mesh_hydro_utils                                          # go into the directory
python3 -m pip install .                                     # install package
```


Alternately, this package is shipped as part of both the
[mesh-hydro](https://github.com/mladenivkovic/mesh-hydro) and
[hydro-playground](https://github.com/mladenivkovic/hydro-playground) codes as a
a `git submodule`.

TODO: Finish this





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

TODO

- `mesh_hydro_utils`

  The actual python module.

- `testing`

  The testing directory has some output and IC files so you can test your scripts on it.




## Usage


TODO

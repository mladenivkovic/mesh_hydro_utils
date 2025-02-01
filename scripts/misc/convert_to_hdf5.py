#!/usr/bin/env python3


# ------------------------------------------------------------------------------------
# Convert mesh-hydro output to hdf5.
# Create a hdf5 output file for every file given as cmdline argument.
#
# Usage:
#   convert_to_hdf5.py <file1> <file2> ... <fileN>
# ------------------------------------------------------------------------------------

from sys import argv, exit

try:
    import h5py
except ImportError:
    print("Couldn't import h5py. Did you install with the hdf5 option enabled?")
    exit(1)


from mesh_hydro_utils import (
    read_output,
)


def dump_hdf5(fname):
    """
    Dump output from file `fname` as a hdf5 file.
    """

    ndim, rho, u, p, t, step = read_output(fname)
    outfile = fname.replace("out", "hdf5")
    print("Writing output file", outfile)

    hfile = h5py.File(outfile, "w")

    data = hfile.create_group("data")

    drho = data.create_dataset("density", rho.shape, dtype="f", compression="gzip")
    drho[:] = rho[:]

    du = data.create_dataset("velocity", u.shape, dtype="f", compression="gzip")
    du[:] = u[:]

    dp = data.create_dataset("pressure", p.shape, dtype="f", compression="gzip")
    dp[:] = p[:]

    metadata = hfile.create_group("metadata")
    metadata.attrs["ndim"] = ndim
    metadata.attrs["time"] = t
    metadata.attrs["step"] = step
    hfile.close()

    return


if __name__ == "__main__":
    filelist = argv[1:]

    if len(filelist) == 0:
        raise ValueError("You need to provide me with output file(s) to convert.")

    for fname in filelist:
        dump_hdf5(fname)

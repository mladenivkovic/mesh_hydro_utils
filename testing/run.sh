#!/bin/bash

# exit on error
set -e


# ======================================
# Setup
# ======================================

# turn sets of tests on and off

# test IC scripts?
test_ICs=true

# test misc scripts?
test_misc=true

# test plotting scripts?
test_plot=true

# clean up after yourself? I.e. remove all generated files?
cleanup=true

SCRIPTDIR="../scripts"


# ======================================
# IC tests
# ======================================

if [[ "$test_ICs" == "true" ]]; then

    echo "Running IC tests."

    echo "--- running $SCRIPTDIR/IC/advection-1D-four-shapes.py"
    python3 $SCRIPTDIR/IC/advection-1D-four-shapes.py

    echo "--- running $SCRIPTDIR/IC/advection-1D-gaussian.py"
    python3 $SCRIPTDIR/IC/advection-1D-gaussian.py

    echo "--- running $SCRIPTDIR/IC/advection-1D-step.py"
    python3 $SCRIPTDIR/IC/advection-1D-step.py

    echo "--- running $SCRIPTDIR/IC/advection-2D-four-shapes.py"
    python3 $SCRIPTDIR/IC/advection-2D-four-shapes.py

    echo "--- running $SCRIPTDIR/IC/advection-2D-step.py"
    python3 $SCRIPTDIR/IC/advection-2D-step.py

    echo "--- running $SCRIPTDIR/IC/center-explosion.py"
    python3 $SCRIPTDIR/IC/center-explosion.py

    echo "--- running $SCRIPTDIR/IC/corner-explosion.py"
    python3 $SCRIPTDIR/IC/corner-explosion.py

    echo "--- running $SCRIPTDIR/IC/kelvin-helmholtz.py"
    python3 $SCRIPTDIR/IC/kelvin-helmholtz.py

    echo "--- running $SCRIPTDIR/IC/output_to_IC.py advection-2D-0004.out"
    python3 $SCRIPTDIR/IC/output_to_IC.py advection-2D-0004.out

    echo "--- running $SCRIPTDIR/IC/rayleigh-taylor.py"
    python3 $SCRIPTDIR/IC/rayleigh-taylor.py

    echo "--- running $SCRIPTDIR/IC/uniform-1D.py"
    python3 $SCRIPTDIR/IC/uniform-1D.py

    echo "--- running $SCRIPTDIR/IC/uniform-2D.py"
    python3 $SCRIPTDIR/IC/uniform-2D.py

    if [[ "$cleanup" == "true" ]]; then

        rm -f advection-1D-four-shapes-256.dat
        rm -f advection-1D-gaussian-256.dat
        rm -f advection-1D-step-256.dat
        rm -f advection-2D-four-shapes.dat
        rm -f advection-2D-step-100.dat
        rm -f center-explosion-200.dat
        rm -f corner-explosion-200.dat
        rm -f kelvin-helmholtz-256.dat
        rm -f "restart.dat"
        rm -f rayleigh-taylor-512.dat
        rm -f uniform-1D-100.dat
        rm -f uniform-2D-100.dat

    fi

else
    echo "Skipping IC script tests."
fi



# ======================================
# Misc tests
# ======================================

if [[ "$test_misc" == "true" ]]; then
    echo "--- running $SCRIPTDIR/misc/convert_to_hdf5.py"
    python3 $SCRIPTDIR/misc/convert_to_hdf5.py advection-2D-0004.out

    if [[ "$cleanup" == "true" ]]; then

        rm  -f advection-2D-0004.hdf5

    fi

else
    echo "Skipping misc/ scripts."
fi




# ======================================
# Plotting tests
# ======================================

if [[ "$test_plot" == "true" ]]; then

    echo "--- running $SCRIPTDIR/plotting/movie_density.py advection-2D-0004.out"
    $SCRIPTDIR/plotting/movie_density.py advection-2D-0004.out

    echo "--- running $SCRIPTDIR/plotting/plot_all_2D_velnorm_individually.py advection-2D-0004.out"
    $SCRIPTDIR/plotting/plot_all_2D_velnorm_individually.py advection-2D-0004.out

    echo "--- running $SCRIPTDIR/plotting/plot_all_density_individually.py advection-00*out"
    $SCRIPTDIR/plotting/plot_all_density_individually.py advection-00*out

    echo "--- running $SCRIPTDIR/plotting/plot_all_density_individually.py advection-2D-00*out"
    $SCRIPTDIR/plotting/plot_all_density_individually.py advection-2D-00*out

    echo "--- running $SCRIPTDIR/plotting/plot_all_density.py advection-00*out"
    $SCRIPTDIR/plotting/plot_all_density.py advection-00*out

    echo "--- running $SCRIPTDIR/plotting/plot_all_results_individually.py advection-00*out"
    $SCRIPTDIR/plotting/plot_all_results_individually.py advection-00*out

    echo "--- running $SCRIPTDIR/plotting/plot_all_results_individually.py advection-2D-00*out"
    $SCRIPTDIR/plotting/plot_all_results_individually.py advection-2D-00*out

    echo "--- running $SCRIPTDIR/plotting/plot_all_results.py advection-00*out"
    $SCRIPTDIR/plotting/plot_all_results.py advection-00*out

    echo "--- running $SCRIPTDIR/plotting/plot_all_riemann_results.py sod-shock-000*.out ic-twostate.dat"
    $SCRIPTDIR/plotting/plot_all_riemann_results.py sod-shock-000*.out ic-twostate.dat

    echo "--- running $SCRIPTDIR/plotting/plot_density.py advection-0009.out"
    $SCRIPTDIR/plotting/plot_density.py advection-0009.out

    echo "--- running $SCRIPTDIR/plotting/plot_density.py advection-2D-0004.out"
    $SCRIPTDIR/plotting/plot_density.py advection-2D-0004.out

    echo "--- running $SCRIPTDIR/plotting/plot_IC_3D.py ic-1D.dat"
    $SCRIPTDIR/plotting/plot_IC_3D.py ic-1D.dat

    echo "--- running $SCRIPTDIR/plotting/plot_IC_3D.py ic-2D.dat"
    $SCRIPTDIR/plotting/plot_IC_3D.py ic-2D.dat

    echo "--- running $SCRIPTDIR/plotting/plot_IC_3D.py ic-twostate.dat"
    $SCRIPTDIR/plotting/plot_IC_3D.py ic-twostate.dat

    echo "--- running $SCRIPTDIR/plotting/plot_IC.py ic-1D.dat"
    $SCRIPTDIR/plotting/plot_IC.py ic-1D.dat

    echo "--- running $SCRIPTDIR/plotting/plot_IC.py ic-2D.dat"
    $SCRIPTDIR/plotting/plot_IC.py ic-2D.dat

    echo "--- running $SCRIPTDIR/plotting/plot_IC.py ic-twostate.dat"
    $SCRIPTDIR/plotting/plot_IC.py ic-twostate.dat

    echo "--- running $SCRIPTDIR/plotting/plot_result_3D.py advection-0010.out"
    $SCRIPTDIR/plotting/plot_result_3D.py advection-0010.out

    echo "--- running $SCRIPTDIR/plotting/plot_result_3D.py advection-2D-0004.out"
    $SCRIPTDIR/plotting/plot_result_3D.py advection-2D-0004.out

    echo "--- running $SCRIPTDIR/plotting/plot_result.py advection-0010.out"
    $SCRIPTDIR/plotting/plot_result.py advection-0010.out

    echo "--- running $SCRIPTDIR/plotting/plot_result.py advection-2D-0004.out"
    $SCRIPTDIR/plotting/plot_result.py advection-2D-0004.out

    echo "--- running $SCRIPTDIR/plotting/plot_riemann_result.py sod-shock-0001.out ic-twostate.dat"
    $SCRIPTDIR/plotting/plot_riemann_result.py sod-shock-0001.out ic-twostate.dat

    echo "--- running $SCRIPTDIR/plotting/solve_riemann.py ic-twostate.dat 0.25"
    $SCRIPTDIR/plotting/solve_riemann.py ic-twostate.dat 0.25


    if [[ "$cleanup" == "true" ]]; then

        rm  -f *png

    fi

else
    echo "Skipping plotting scripts."
fi


echo Done.



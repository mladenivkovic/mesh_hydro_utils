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


check_file_written() {
    # Check that a file, provided as first cmdline arg,
    # exists. Exit with error code if it doesn't.
    # Usage: `check_file_written filename`

    if [[ ! -f "$1" ]]; then
        echo "Expected file" $1 "not found"
        exit 127
    fi
}

check_png_deleted() {

    pnglist=`find . -name "*.png"`

    for f in $pnglist; do
        if [[ -f "$f" ]]; then
            echo "File" $f "should not exist"
            exit 127
        fi
    done
}


# ======================================
# IC tests
# ======================================

if [[ "$test_ICs" == "true" ]]; then

    echo "Running IC tests."

    echo "--- running $SCRIPTDIR/IC/advection-1D-four-shapes.py"
    python3 $SCRIPTDIR/IC/advection-1D-four-shapes.py
    diff ./advection-1D-four-shapes-256.dat ./advection-1D-four-shapes-256-reference.dat

    echo "--- running $SCRIPTDIR/IC/advection-1D-gaussian.py"
    python3 $SCRIPTDIR/IC/advection-1D-gaussian.py
    diff ./advection-1D-gaussian-256.dat ./advection-1D-gaussian-256-reference.dat

    echo "--- running $SCRIPTDIR/IC/advection-1D-step.py"
    python3 $SCRIPTDIR/IC/advection-1D-step.py
    diff ./advection-1D-step-256.dat ./advection-1D-step-256-reference.dat

    echo "--- running $SCRIPTDIR/IC/advection-2D-four-shapes.py"
    python3 $SCRIPTDIR/IC/advection-2D-four-shapes.py
    diff ./advection-2D-four-shapes.dat ./advection-2D-four-shapes-reference.dat

    echo "--- running $SCRIPTDIR/IC/advection-2D-step.py"
    python3 $SCRIPTDIR/IC/advection-2D-step.py
    diff ./advection-2D-step-100.dat ./advection-2D-step-100-reference.dat

    echo "--- running $SCRIPTDIR/IC/center-explosion.py"
    python3 $SCRIPTDIR/IC/center-explosion.py
    diff ./center-explosion-200.dat ./center-explosion-200-reference.dat

    echo "--- running $SCRIPTDIR/IC/corner-explosion.py"
    python3 $SCRIPTDIR/IC/corner-explosion.py
    diff ./corner-explosion-200.dat ./corner-explosion-200-reference.dat

    echo "--- running $SCRIPTDIR/IC/kelvin-helmholtz.py"
    python3 $SCRIPTDIR/IC/kelvin-helmholtz.py
    diff ./kelvin-helmholtz-256.dat ./kelvin-helmholtz-256-reference.dat

    echo "--- running $SCRIPTDIR/IC/output_to_IC.py advection-2D-0004.out"
    python3 $SCRIPTDIR/IC/output_to_IC.py advection-2D-0004.out
    diff ./restart.dat ./restart-reference.dat

    echo "--- running $SCRIPTDIR/IC/rayleigh-taylor.py"
    python3 $SCRIPTDIR/IC/rayleigh-taylor.py
    diff ./rayleigh-taylor-512.dat ./rayleigh-taylor-512-reference.dat

    echo "--- running $SCRIPTDIR/IC/uniform-1D.py"
    python3 $SCRIPTDIR/IC/uniform-1D.py
    diff ./uniform-1D-100.dat ./uniform-1D-100-reference.dat

    echo "--- running $SCRIPTDIR/IC/uniform-2D.py"
    python3 $SCRIPTDIR/IC/uniform-2D.py
    diff ./uniform-2D-100.dat ./uniform-2D-100-reference.dat

    if [[ "$cleanup" == "true" ]]; then
        echo "Cleaning up."

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
    check_file_written ./advection-2D-0004.hdf5


    if [[ "$cleanup" == "true" ]]; then
        echo "Cleaning up."
        rm  -f advection-2D-0004.hdf5
    fi

else
    echo "Skipping misc/ scripts."
fi




# ======================================
# Plotting tests
# ======================================

if [[ "$test_plot" == "true" ]]; then

    if [[ "$cleanup" == "true" ]]; then
        echo "Cleaning up."
        rm  -f *png
        check_png_deleted
    fi

    echo "--- running $SCRIPTDIR/plotting/movie_density.py advection-2D-0004.out"
    $SCRIPTDIR/plotting/movie_density.py advection-2D-0004.out
    check_file_written advection-2D-0000-density-only.png
    check_file_written advection-2D-0001-density-only.png
    check_file_written advection-2D-0002-density-only.png
    check_file_written advection-2D-0003-density-only.png
    check_file_written advection-2D-0004-density-only.png
    if [[ "$cleanup" == "true" ]]; then
        echo "Cleaning up."
        rm -f advection-2D-0000-density-only.png advection-2D-0001-density-only.png \
            advection-2D-0002-density-only.png advection-2D-0003-density-only.png \
            advection-2D-0004-density-only.png
        check_png_deleted
    fi

    echo "--- running $SCRIPTDIR/plotting/plot_all_2D_velnorm_individually.py advection-2D-0004.out"
    $SCRIPTDIR/plotting/plot_all_2D_velnorm_individually.py advection-2D-0004.out
    check_file_written advection-2D-0004.png
    if [[ "$cleanup" == "true" ]]; then
        echo "Cleaning up."
        rm advection-2D-0004.png
        check_png_deleted
    fi

    echo "--- running $SCRIPTDIR/plotting/plot_all_density_individually.py advection-00*out"
    $SCRIPTDIR/plotting/plot_all_density_individually.py advection-00*out
    check_file_written advection-0000-density-only.png
    check_file_written advection-0001-density-only.png
    check_file_written advection-0002-density-only.png
    check_file_written advection-0003-density-only.png
    check_file_written advection-0004-density-only.png
    check_file_written advection-0005-density-only.png
    check_file_written advection-0006-density-only.png
    check_file_written advection-0007-density-only.png
    check_file_written advection-0008-density-only.png
    check_file_written advection-0009-density-only.png
    check_file_written advection-0010-density-only.png
    check_file_written advection-0011-density-only.png
    check_file_written advection-0012-density-only.png
    check_file_written advection-0013-density-only.png

    if [[ "$cleanup" == "true" ]]; then
        echo "Cleaning up."
        rm -f advection-0000-density-only.png advection-0001-density-only.png \
             advection-0002-density-only.png advection-0003-density-only.png  \
             advection-0004-density-only.png advection-0005-density-only.png  \
             advection-0006-density-only.png advection-0007-density-only.png  \
             advection-0008-density-only.png advection-0009-density-only.png  \
             advection-0010-density-only.png advection-0011-density-only.png  \
             advection-0012-density-only.png advection-0013-density-only.png
        check_png_deleted
    fi

    echo "--- running $SCRIPTDIR/plotting/plot_all_density_individually.py advection-2D-00*out"
    $SCRIPTDIR/plotting/plot_all_density_individually.py advection-2D-00*out
    check_file_written advection-2D-0000-density-only.png
    check_file_written advection-2D-0001-density-only.png
    check_file_written advection-2D-0002-density-only.png
    check_file_written advection-2D-0003-density-only.png
    check_file_written advection-2D-0004-density-only.png
    if [[ "$cleanup" == "true" ]]; then
        echo "Cleaning up."
        rm -f advection-2D-0000-density-only.png advection-2D-0001-density-only.png \
            advection-2D-0002-density-only.png advection-2D-0003-density-only.png \
            advection-2D-0004-density-only.png
        check_png_deleted
    fi

    echo "--- running $SCRIPTDIR/plotting/plot_all_density.py advection-00*out"
    $SCRIPTDIR/plotting/plot_all_density.py advection-00*out
    check_file_written advection-density-only-overplotted.png
    if [[ "$cleanup" == "true" ]]; then
        echo "Cleaning up."
        rm advection-density-only-overplotted.png
        check_png_deleted
    fi

    echo "--- running $SCRIPTDIR/plotting/plot_all_results_individually.py advection-00*out"
    $SCRIPTDIR/plotting/plot_all_results_individually.py advection-00*out
    check_file_written advection-0000.png
    check_file_written advection-0001.png
    check_file_written advection-0002.png
    check_file_written advection-0003.png
    check_file_written advection-0004.png
    check_file_written advection-0005.png
    check_file_written advection-0006.png
    check_file_written advection-0007.png
    check_file_written advection-0008.png
    check_file_written advection-0009.png
    check_file_written advection-0010.png
    check_file_written advection-0011.png
    check_file_written advection-0012.png
    check_file_written advection-0013.png
    if [[ "$cleanup" == "true" ]]; then
        echo "Cleaning up."
        rm -f advection-0000.png advection-0001.png advection-0002.png \
            advection-0003.png advection-0004.png advection-0005.png \
            advection-0006.png advection-0007.png advection-0008.png \
            advection-0009.png advection-0010.png advection-0011.png \
            advection-0012.png advection-0013.png
        check_png_deleted
    fi

    echo "--- running $SCRIPTDIR/plotting/plot_all_results_individually.py advection-2D-00*out"
    $SCRIPTDIR/plotting/plot_all_results_individually.py advection-2D-00*out
    check_file_written advection-2D-0000.png
    check_file_written advection-2D-0001.png
    check_file_written advection-2D-0002.png
    check_file_written advection-2D-0003.png
    check_file_written advection-2D-0004.png
    if [[ "$cleanup" == "true" ]]; then
        echo "Cleaning up."
        rm -f advection-2D-0000.png advection-2D-0001.png advection-2D-0002.png \
            advection-2D-0003.png advection-2D-0004.png
        check_png_deleted
    fi

    echo "--- running $SCRIPTDIR/plotting/plot_all_results.py advection-00*out"
    $SCRIPTDIR/plotting/plot_all_results.py advection-00*out
    check_file_written advection-overplotted.png
    if [[ "$cleanup" == "true" ]]; then
        echo "Cleaning up."
        rm -f advection-overplotted.png
        check_png_deleted
    fi

    echo "--- running $SCRIPTDIR/plotting/plot_all_riemann_results.py sod-shock-000*.out ic-twostate.dat"
    $SCRIPTDIR/plotting/plot_all_riemann_results.py sod-shock-000*.out ic-twostate.dat
    check_file_written sod-shock-overplotted.png
    if [[ "$cleanup" == "true" ]]; then
        echo "Cleaning up."
        rm -f sod-shock-overplotted.png
        check_png_deleted
    fi

    echo "--- running $SCRIPTDIR/plotting/plot_density.py advection-0009.out"
    $SCRIPTDIR/plotting/plot_density.py advection-0009.out
    check_file_written advection-0009-density-only.png
    if [[ "$cleanup" == "true" ]]; then
        echo "Cleaning up."
        rm -f advection-0009-density-only.png
        check_png_deleted
    fi

    echo "--- running $SCRIPTDIR/plotting/plot_density.py advection-2D-0004.out"
    $SCRIPTDIR/plotting/plot_density.py advection-2D-0004.out
    check_file_written advection-2D-0004-density-only.png
    if [[ "$cleanup" == "true" ]]; then
        echo "Cleaning up."
        rm -f advection-2D-0004-density-only.png
        check_png_deleted
    fi

    echo "--- running $SCRIPTDIR/plotting/plot_IC_3D.py ic-1D.dat"
    $SCRIPTDIR/plotting/plot_IC_3D.py ic-1D.dat
    check_file_written ic-1D.png
    if [[ "$cleanup" == "true" ]]; then
        echo "Cleaning up."
        rm -f ic-1D.png
        check_png_deleted
    fi

    echo "--- running $SCRIPTDIR/plotting/plot_IC_3D.py ic-2D.dat"
    $SCRIPTDIR/plotting/plot_IC_3D.py ic-2D.dat
    check_file_written ic-2D-3D.png
    if [[ "$cleanup" == "true" ]]; then
        echo "Cleaning up."
        rm -f ic-2D-3D.png
        check_png_deleted
    fi

    echo "--- running $SCRIPTDIR/plotting/plot_IC_3D.py ic-twostate.dat"
    $SCRIPTDIR/plotting/plot_IC_3D.py ic-twostate.dat
    check_file_written ic-twostate.png
    if [[ "$cleanup" == "true" ]]; then
        echo "Cleaning up."
        rm -f ic-twostate.png
        check_png_deleted
    fi

    echo "--- running $SCRIPTDIR/plotting/plot_IC.py ic-1D.dat"
    $SCRIPTDIR/plotting/plot_IC.py ic-1D.dat
    check_file_written ic-1D.png
    if [[ "$cleanup" == "true" ]]; then
        echo "Cleaning up."
        rm -f ic-1D.png
        check_png_deleted
    fi

    echo "--- running $SCRIPTDIR/plotting/plot_IC.py ic-2D.dat"
    $SCRIPTDIR/plotting/plot_IC.py ic-2D.dat
    check_file_written ic-2D.png
    if [[ "$cleanup" == "true" ]]; then
        echo "Cleaning up."
        rm -f ic-2D.png
        check_png_deleted
    fi

    echo "--- running $SCRIPTDIR/plotting/plot_IC.py ic-twostate.dat"
    $SCRIPTDIR/plotting/plot_IC.py ic-twostate.dat
    check_file_written ic-twostate.png
    if [[ "$cleanup" == "true" ]]; then
        echo "Cleaning up."
        rm -f ic-twostate.png
        check_png_deleted
    fi

    echo "--- running $SCRIPTDIR/plotting/plot_result_3D.py advection-0010.out"
    $SCRIPTDIR/plotting/plot_result_3D.py advection-0010.out
    check_file_written advection-0010.png
    if [[ "$cleanup" == "true" ]]; then
        echo "Cleaning up."
        rm -f advection-0010.png
        check_png_deleted
    fi

    echo "--- running $SCRIPTDIR/plotting/plot_result_3D.py advection-2D-0004.out"
    $SCRIPTDIR/plotting/plot_result_3D.py advection-2D-0004.out
    check_file_written advection-2D-0004-3D.png
    if [[ "$cleanup" == "true" ]]; then
        echo "Cleaning up."
        rm -f advection-2D-0004-3D.png
        check_png_deleted
    fi

    echo "--- running $SCRIPTDIR/plotting/plot_result.py advection-0010.out"
    $SCRIPTDIR/plotting/plot_result.py advection-0010.out
    check_file_written advection-0010.png
    if [[ "$cleanup" == "true" ]]; then
        echo "Cleaning up."
        rm -f advection-0010.png
        check_png_deleted
    fi

    echo "--- running $SCRIPTDIR/plotting/plot_result.py advection-2D-0004.out"
    $SCRIPTDIR/plotting/plot_result.py advection-2D-0004.out
    check_file_written advection-2D-0004.png
    if [[ "$cleanup" == "true" ]]; then
        echo "Cleaning up."
        rm -f advection-2D-0004.png
        check_png_deleted
    fi

    echo "--- running $SCRIPTDIR/plotting/plot_riemann_result.py sod-shock-0001.out ic-twostate.dat"
    $SCRIPTDIR/plotting/plot_riemann_result.py sod-shock-0001.out ic-twostate.dat
    check_file_written sod-shock-0001.png
    if [[ "$cleanup" == "true" ]]; then
        echo "Cleaning up."
        rm -f sod-shock-0001.png
        check_png_deleted
    fi

    echo "--- running $SCRIPTDIR/plotting/solve_riemann.py ic-twostate.dat 0.25"
    $SCRIPTDIR/plotting/solve_riemann.py ic-twostate.dat 0.25
    check_file_written ic-twostate-riemann-solution.png
    if [[ "$cleanup" == "true" ]]; then
        echo "Cleaning up."
        rm -f ic-twostate-riemann-solution.png
        check_png_deleted
    fi


else
    echo "Skipping plotting scripts."
fi


echo Done.



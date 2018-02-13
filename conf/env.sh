#!/bin/bash
set -eu

export PROJECT_HOME=$(pwd)

export CONDA_HOME=$PROJECT_HOME/software/conda
export JUPYTER_DATA_DIR=$PROJECT_HOME/software/jupyter_data
export TF_HOME=$PROJECT_HOME/software/tensorflow-cpu

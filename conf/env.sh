#!/bin/bash
set -eu

export PROJECT_HOME=$(pwd)
export CONDA_HOME=$PROJECT_HOME/software/conda3
export TENSORFLOW_HOME=$PROJECT_HOME/software/tensorflow-1.0

export JUPYTER_DATA_DIR=$PROJECT_HOME/software/jupyter_data

export PATH=$CONDA_HOME/bin:$TENSORFLOW_HOME/bin:$PATH

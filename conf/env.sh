#!/bin/bash
set -eu

export PROJECT_HOME=$(pwd)
export CONDA_HOME=$PROJECT_HOME/deps/conda2
export TENSORFLOW_HOME=$PROJECT_HOME/deps/tensorflow-0.10

export JUPYTER_DATA_DIR=$PROJECT_HOME/data

export PATH=$CONDA_HOME/bin:$TENSORFLOW_HOME/bin:$PATH

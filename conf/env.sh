#!/bin/bash
set -eu

export PROJECT_HOME=$(pwd)

export JUPYTER_HOME=$PROJECT_HOME/software/jupyter
export JUPYTER_DATA_DIR=$PROJECT_HOME/software/jupyter_data

export TENSORFLOW_HOME=$PROJECT_HOME/software/tensorflow-1.0

export PATH=$JUPYTER_HOME/bin:$TENSORFLOW_HOME/bin:$PATH

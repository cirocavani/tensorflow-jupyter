#!/bin/bash
set -eu

cd $(dirname "$0")/..
source conf/env.sh

# TensorFlow

TF_NAME=$1
TF_WHEEL=$2

TF_HOME=$PROJECT_HOME/software/$TF_NAME

rm -rf $TF_HOME

$CONDA_HOME/bin/conda create -y -p $TF_HOME python=3.6
$CONDA_HOME/bin/conda install -y -p $TF_HOME \
    ipykernel \
    scikit-learn \
    matplotlib \
    scipy \
    requests \
    bokeh \
    pandas \
    nltk \
    pillow
$CONDA_HOME/bin/conda install -y -p $TF_HOME \
    -c conda-forge \
    scikit-optimize \
    xgboost
$TF_HOME/bin/pip install gym
$TF_HOME/bin/pip install $TF_WHEEL

TF_KERNEL=$JUPYTER_DATA_DIR/kernels/$TF_NAME

mkdir -p $TF_KERNEL

echo "{
 \"display_name\": \"Python 3 ($TF_NAME)\",
 \"language\": \"python\",
 \"argv\": [
  \"$TF_HOME/bin/python\",
  \"-c\",
  \"from ipykernel.kernelapp import main; main()\",
  \"-f\",
  \"{connection_file}\"
 ]
}" > $TF_KERNEL/kernel.json

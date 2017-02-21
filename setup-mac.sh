#!/bin/bash
set -eu

cd `dirname "$0"`
source conf/env.sh

# Python install

rm -rf $CONDA_HOME

curl -k -L -O https://repo.continuum.io/miniconda/Miniconda3-latest-MacOSX-x86_64.sh

bash Miniconda3-latest-MacOSX-x86_64.sh -b -f -p $CONDA_HOME
rm -f Miniconda3-latest-MacOSX-x86_64.sh

$CONDA_HOME/bin/pip install --upgrade pip

rm -rf $JUPYTER_DATA_DIR
mkdir -p $JUPYTER_DATA_DIR
$CONDA_HOME/bin/pip install jupyter

# TensorFlow 1.0 (TensorBoard)

rm -rf $TENSORFLOW_HOME

$CONDA_HOME/bin/conda create -y -p $TENSORFLOW_HOME python=3.6
$TENSORFLOW_HOME/bin/pip install https://storage.googleapis.com/tensorflow/mac/cpu/tensorflow-1.0.0-py3-none-any.whl
$TENSORFLOW_HOME/bin/pip install ipykernel
$TENSORFLOW_HOME/bin/pip install matplotlib
$TENSORFLOW_HOME/bin/pip install sklearn
$TENSORFLOW_HOME/bin/pip install scipy

mkdir -p $JUPYTER_DATA_DIR/kernels/tensorflow-1.0-py3

echo "{
 \"display_name\": \"TensorFlow 1.0 (CPU, Python 3)\",
 \"language\": \"python\",
 \"argv\": [
  \"$TENSORFLOW_HOME/bin/python\",
  \"-c\",
  \"from ipykernel.kernelapp import main; main()\",
  \"-f\",
  \"{connection_file}\"
 ]
}" > $JUPYTER_DATA_DIR/kernels/tensorflow-1.0-py3/kernel.json

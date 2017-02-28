#!/bin/bash
set -eu

cd `dirname "$0"`
source conf/env.sh

# Python install

rm -rf $JUPYTER_HOME

curl -k -L -O https://repo.continuum.io/miniconda/Miniconda3-latest-MacOSX-x86_64.sh
bash Miniconda3-latest-MacOSX-x86_64.sh -b -f -p $JUPYTER_HOME
rm -f Miniconda3-latest-MacOSX-x86_64.sh

$JUPYTER_HOME/bin/conda update -y conda
$JUPYTER_HOME/bin/conda update -y pip

rm -rf $JUPYTER_DATA_DIR
mkdir -p $JUPYTER_DATA_DIR
$JUPYTER_HOME/bin/conda install -y jupyter

# TensorFlow 1.0 (TensorBoard)

rm -rf $TENSORFLOW_HOME

$JUPYTER_HOME/bin/conda create -y -p $TENSORFLOW_HOME python=3.5
$TENSORFLOW_HOME/bin/pip install tensorflow==1.0.0
$TENSORFLOW_HOME/bin/pip install ipykernel
$TENSORFLOW_HOME/bin/pip install scikit-learn
$TENSORFLOW_HOME/bin/pip install matplotlib
$TENSORFLOW_HOME/bin/pip install scipy
$TENSORFLOW_HOME/bin/pip install requests

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

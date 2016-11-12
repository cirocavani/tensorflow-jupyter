#!/bin/bash
set -eu

cd `dirname "$0"`
source conf/env.sh

# Python install

rm -rf $CONDA_HOME

curl -k -L -O https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh

chmod +x Miniconda3-latest-Linux-x86_64.sh

./Miniconda3-latest-Linux-x86_64.sh -b -f -p $CONDA_HOME
rm -f Miniconda3-latest-Linux-x86_64.sh

$CONDA_HOME/bin/pip install --upgrade pip

rm -rf $JUPYTER_DATA_DIR
mkdir -p $JUPYTER_DATA_DIR
$CONDA_HOME/bin/pip install jupyter

# TensorFlow 0.11 (TensorBoard)

rm -rf $TENSORFLOW_HOME

$CONDA_HOME/bin/conda create -y -p $TENSORFLOW_HOME python=2.7
$TENSORFLOW_HOME/bin/pip install https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-0.11.0-cp27-none-linux_x86_64.whl
$TENSORFLOW_HOME/bin/pip install ipykernel
$TENSORFLOW_HOME/bin/pip install matplotlib
$TENSORFLOW_HOME/bin/pip install sklearn
$TENSORFLOW_HOME/bin/pip install scipy

mkdir -p $JUPYTER_DATA_DIR/kernels/tensorflow-0.11-py2

echo "{
 \"display_name\": \"TensorFlow 0.11 (CPU, Python 2)\",
 \"language\": \"python\",
 \"env\": {
  \"PYTHONSTARTUP\": \"$PROJECT_HOME/conf/tensorflow-py2.py\"
 },
 \"argv\": [
  \"$TENSORFLOW_HOME/bin/python\",
  \"-c\",
  \"from ipykernel.kernelapp import main; main()\",
  \"-f\",
  \"{connection_file}\"
 ]
}" > $JUPYTER_DATA_DIR/kernels/tensorflow-0.11-py2/kernel.json

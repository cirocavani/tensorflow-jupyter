#!/bin/bash
set -eu

cd $(dirname "$0")
source conf/env.sh

mkdir -p .cache

PLATFORM="$(uname -s | tr 'A-Z' 'a-z')"


# Python install

case $PLATFORM in
    linux)
        CONDA_PKG=Miniconda3-4.3.22-Linux-x86_64.sh
        ;;
    darwin)
        CONDA_PKG=Miniconda3-4.3.22-MacOSX-x86_64.sh
        ;;
    *)
        echo "Unsupported platform: $PLATFORM"
        exit 1
esac

if [ ! -f .cache/$CONDA_PKG ]; then
    curl -k -L \
        https://repo.continuum.io/miniconda/$CONDA_PKG \
        -o .cache/$CONDA_PKG
fi

rm -rf $JUPYTER_HOME

bash .cache/$CONDA_PKG -b -f -p $JUPYTER_HOME

$JUPYTER_HOME/bin/conda update -y --all

rm -rf $JUPYTER_DATA_DIR
mkdir -p $JUPYTER_DATA_DIR
$JUPYTER_HOME/bin/conda install -y jupyter


# TensorFlow (TensorBoard)

rm -rf $TENSORFLOW_HOME

$JUPYTER_HOME/bin/conda create -y -p $TENSORFLOW_HOME python=3.6
$TENSORFLOW_HOME/bin/conda install -y -p $TENSORFLOW_HOME ipykernel
$TENSORFLOW_HOME/bin/pip install -r software/tensorflow_env.txt

TF_NAME=$(basename $TENSORFLOW_HOME)
TENSORFLOW_KERNEL=$JUPYTER_DATA_DIR/kernels/$TF_NAME

mkdir -p $TENSORFLOW_KERNEL

echo "{
 \"display_name\": \"Python 3 ($TF_NAME)\",
 \"language\": \"python\",
 \"argv\": [
  \"$TENSORFLOW_HOME/bin/python\",
  \"-c\",
  \"from ipykernel.kernelapp import main; main()\",
  \"-f\",
  \"{connection_file}\"
 ]
}" > $TENSORFLOW_KERNEL/kernel.json

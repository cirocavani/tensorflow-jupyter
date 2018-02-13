#!/bin/bash
set -eu

cd $(dirname "$0")
source conf/env.sh

mkdir -p .cache

PLATFORM="$(uname -s | tr 'A-Z' 'a-z')"


# Python install

case $PLATFORM in
    linux)
        CONDA_PKG=Miniconda3-4.3.31-Linux-x86_64.sh
        ;;
    darwin)
        CONDA_PKG=Miniconda3-4.3.31-MacOSX-x86_64.sh
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

rm -rf $CONDA_HOME

bash .cache/$CONDA_PKG -b -f -p $CONDA_HOME

$CONDA_HOME/bin/conda update -y conda
$CONDA_HOME/bin/conda update -y --all

rm -rf $JUPYTER_DATA_DIR
mkdir -p $JUPYTER_DATA_DIR
$CONDA_HOME/bin/conda install -y jupyter jupyterlab

# TensorFlow

rm -rf $TF_HOME

$CONDA_HOME/bin/conda env create -p $TF_HOME -f environment.yml
$TF_HOME/bin/pip install tensorflow

TF_NAME=$(basename $TF_HOME)
TF_KERNEL=$JUPYTER_DATA_DIR/kernels/$TF_NAME

mkdir -p $TF_KERNEL

echo "{
 \"display_name\": \"$TF_NAME\",
 \"language\": \"python\",
 \"argv\": [
  \"$TF_HOME/bin/python\",
  \"-c\",
  \"from ipykernel.kernelapp import main; main()\",
  \"-f\",
  \"{connection_file}\"
 ]
}" > $TF_KERNEL/kernel.json

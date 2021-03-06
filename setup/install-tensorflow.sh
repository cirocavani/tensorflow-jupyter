#!/bin/bash
set -eu

cd $(dirname "$0")/..
source conf/env.sh

# TensorFlow

TF_NAME=$1
TF_WHEEL=$2

TF_HOME=$PROJECT_HOME/software/$TF_NAME

rm -rf $TF_HOME

$CONDA_HOME/bin/conda env create -q -p $TF_HOME -f setup/environment-kernel.yml
$TF_HOME/bin/pip install -q $TF_WHEEL

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

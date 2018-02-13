# TensorFlow Jupyter

TensorFlow Development Environment with Jupyter.

## Setup

Install Conda, Jupyter and TensorFlow.

```sh
./setup.sh
```

## Run

Run Jupyter Notebook (web).

```sh
bin/jupyter-notebook
```

URL:

http://localhost:8888/

## Extra

*TensorFlow Build*

Install a new kernel with a different TensorFlow Wheel package.

See in [tensorflow-build](https://github.com/cirocavani/tensorflow-build) how to build TensorFlow Wheel packages.

```sh
extra/tensorflow.sh \
    tensorflow-gpu \
    ../tensorflow-build/1.5-gpu/tensorflow_gpu-1.5.0-cp36-cp36m-linux_x86_64.whl
```

*Spark Kernel*

Install a new kernel with [Spark](https://spark.apache.org/).

```sh
extra/spark.sh
```

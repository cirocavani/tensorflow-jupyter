#!/bin/bash
set -eu

cd $(dirname "$0")/..
source conf/env.sh

SPARK_VERSION=2.2.0
SPARK_BIN_NAME=spark-$SPARK_VERSION-bin-hadoop2.7
SPARK_PKG=$SPARK_BIN_NAME.tgz
SPARK_HOME=$PROJECT_HOME/software/$SPARK_BIN_NAME
PYSPARK_HOME=$PROJECT_HOME/software/pyspark
PYSPARK_KERNEL=$JUPYTER_DATA_DIR/kernels/pyspark

rm -rf $SPARK_HOME
rm -rf $PYSPARK_HOME
rm -rf $PYSPARK_KERNEL

if [ ! -f .cache/$SPARK_PKG ]; then
    curl -k -L \
        http://d3kbcqa49mib13.cloudfront.net/$SPARK_PKG \
        -o .cache/$SPARK_PKG
fi


mkdir -p $SPARK_HOME
tar zxf .cache/$SPARK_PKG --strip-components=1 -C $SPARK_HOME

$CONDA_HOME/bin/conda create -y -p $PYSPARK_HOME python=3.6
$PYSPARK_HOME/bin/conda install -y -p $PYSPARK_HOME ipykernel

mkdir -p $PYSPARK_KERNEL

echo "{
 \"display_name\": \"Python 3 (Spark)\",
 \"language\": \"python\",
 \"argv\": [
  \"$PYSPARK_HOME/bin/python\",
  \"-c\",
  \"from ipykernel.kernelapp import main; main()\",
  \"-f\",
  \"{connection_file}\"
 ],
 \"env\": {
    \"SPARK_OPTS\": \"--driver-java-options=-Dlog4j.logLevel=error\",
    \"SPARK_HOME\": \"$SPARK_HOME\",
    \"PYTHONPATH\": \"$SPARK_HOME/python:$SPARK_HOME/python/lib/py4j-0.10.4-src.zip\"
  }
}" > $PYSPARK_KERNEL/kernel.json

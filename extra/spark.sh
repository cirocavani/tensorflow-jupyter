#!/bin/bash
set -eu

cd `dirname "$0"`/..
source conf/env.sh

SPARK_HOME=$PROJECT_HOME/software/spark-2.1.1-bin-hadoop2.7
PYSPARK_HOME=$PROJECT_HOME/software/pyspark
PYSPARK_KERNEL=$JUPYTER_DATA_DIR/kernels/pyspark

rm -rf $SPARK_HOME
rm -rf $PYSPARK_HOME
rm -rf $PYSPARK_KERNEL

curl -k -L -O http://d3kbcqa49mib13.cloudfront.net/spark-2.1.1-bin-hadoop2.7.tgz

mkdir -p $SPARK_HOME
tar zxf spark-2.1.1-bin-hadoop2.7.tgz --strip-components=1 -C $SPARK_HOME
rm -rf spark-2.1.1-bin-hadoop2.7.tgz

$JUPYTER_HOME/bin/conda create -y -p $PYSPARK_HOME python=3.6
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

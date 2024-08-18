#! /bin/bash

export MLFLOW_TRACKING_URI="http://localhost:5050"

if [ -z "$1" ]
then
    echo "Usage: run-predict.sh < RUN_ID >"
    exit 1
fi

RUN_ID=$1
python predict.py $RUN_ID

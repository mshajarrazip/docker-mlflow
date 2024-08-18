#! /bin/bash

export MLFLOW_TRACKING_URI="${MLFLOW_TRACKING_URI:-http://localhost:5050}"
export EXPERIMENT_NAME="debug"

mlflow run . -e main --env-manager local --experiment-name $EXPERIMENT_NAME

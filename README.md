# Simple MLFlow Deployment with Docker Compose

Simple mlflow deployment with docker-compose. Not optimized for production use, but good enough for 
local experiments.

## Usage

### Run The Compose

The default compose uses an mssql backend and a local filesystem store. You can run the compose with:

```bash
docker-compose up --build -d
```

To avoid using the mssql backend, you can explicitly specify the compose file, and re-define the 
`MLFLOW_BACKEND_URI` environment variable:

```bash
docker-compose -f docker-compose.yml up --build -d
```

### Environment Variables

[.env](.env) has the default environment variables. You can override by using `export` or
create an [.env-overrides](.env-overrides) (not tracked by git) file and load it by using `source load-env.sh`.
> Do not edit the [.env](.env) file directly!

Description of each environment variables:

- `COMPOSE_PROJECT_NAME` - Project name for the compose.
- `MLFLOW_PORT` - Port to expose the mlflow server.
- `DB_PORT` - Port to expose the mssql server.
- `BASE_DIR` - Base directory for volume mounts. The `mlflow` service will mount to the [mlruns/]() subdirectory while the `db` service will mount to the [db/]() subdirectory. Note that the base directory must be an absolute path for the MLFlow tracking server APIs to work as expected.
- `MLFLOW_BACKEND_URI` - URI for the mlflow backend.
- `MLFLOW_TRACKING_URI` - URI for the mlflow tracking server for testing.

### Modify Permissions for MLFlow Artifacts Directory

The compose will create the artifacts directory at `$BASE_DIR/mlruns`. Scripts using mlflow
will need to have read/write permissions to this directory:

```bash
sudo chmod -R 777 $BASE_DIR/mlruns
```

### Testing the Server

[mlproject-sample/](mlproject-sample/) contains a sample mlflow project. Here is how you can test the tracking server:

1. Make sure that the environment variables are set. If you don't want to manually use `export`, you can define the overrides in [.env-overrides](.env-overrides). Then run:
    ```bash
    source load-env.sh
    ```

1. Go into the [mlproject-sample/](mlproject-sample/) directory and initialize the environment. This sample uses `poetry`. Do:
    ```bash
    python3.10 -m venv .venv
    source .venv/bin/activate
    pip install poetry
    poetry install
    ```

1. Run the training script:
    ```bash

    mlflow run . -e train --env-manager local --experiment-name debug
    ```

1. Open [http://localhost:5000](http://localhost:5000) and get the run id from the experiment.

1. Using the run id, test the model:
    ```bash
    mlflow run . -e predict --env-manager local -P run_id=<run_id>
    ```


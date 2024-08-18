from os import environ as os_environ
from sys import argv as sys_argv
import pandas as pd
import click

import mlflow


@click.command()
@click.option("--run-id", help="The run id to use.")
def main(run_id):

    logged_model = f'runs:/{run_id}/iris_rf5'

    # Load model as a PyFuncModel.
    loaded_model = mlflow.pyfunc.load_model(logged_model)

    # Predict on a Pandas DataFrame.
    pred_result = loaded_model.predict(pd.DataFrame({
        'sepal length (cm)': [5.1],
        'sepal width (cm)': [3.5],
        'petal length (cm)': [1.4],
        'petal width (cm)': [0.2]
    }))

    print("Prediction: %s" % pred_result[0])

if __name__ == "__main__":

    main()
# mlflow run . -e main --env-manager=local --mlflow-tracking-uri=http://localhost:5050

import pandas as pd
from sklearn import datasets
from sklearn.ensemble import RandomForestClassifier
import mlflow
from mlflow.models import infer_signature

iris = datasets.load_iris()
iris_train = pd.DataFrame(iris.data, columns=iris.feature_names)
clf = RandomForestClassifier(max_depth=7, random_state=0)

with mlflow.start_run():
    clf.fit(iris_train, iris.target)
    # Take the first row of the training dataset as the model input example.
    input_example = iris_train.iloc[[0]]
    # The signature is automatically inferred from the input example and its predicted output.
    mlflow.sklearn.log_model(clf, "iris_rf", input_example=input_example)
    mlflow.sklearn.log_model(clf, "iris_rf2", input_example=input_example)
    mlflow.sklearn.log_model(clf, "iris_rf3", input_example=input_example)
    mlflow.sklearn.log_model(clf, "iris_rf4", input_example=input_example)
    mlflow.sklearn.log_model(clf, "iris_rf5", input_example=input_example)

# MLflow On-Premise Deployment using Docker Compose
Easily deploy an MLflow tracking server with 1 command.

MinIO S3 is used as the artifact store and MySQL server is used as the backend store.
[Source of mlflow stack](https://github.com/sachua/mlflow-docker-compose)
## How to run

1. Clone (download) this repository

    ```bash
    git clone https://github.com/jarneamerlinck/installers
    ```

2. `cd` into the `infrastructure/manifests/mlflow` directory
3. Change the `.env` passwords
4. Build and run the containers with `docker-compose`

    ```bash
    docker-compose up -d --build
    ```

5. Access [MLflow UI](http://localhost:5000)

6. Access [MinIO UI](http://localhost:9000)

## Mlflow setup

1. Set environmental variables (make sure the passwords match)

    ```bash
    AWS_ACCESS_KEY_ID=minio
    AWS_SECRET_ACCESS_KEY=minio123
    MLFLOW_S3_ENDPOINT_URL=http://localhost:9000
    MLFLOW_TRACKING_URI=http://localhost:5000
    ```
2. Train a sample MLflow model

    ```bash
    mlflow run https://github.com/mlflow/mlflow-example.git -P alpha=0.42
    ```

    * Note: To fix ModuleNotFoundError: No module named 'boto3'

        ```bash
        #Switch to the conda env
        conda env list
        conda activate mlflow-3eee9bd7a0713cf80a17bc0a4d659bc9c549efac #replace with your own generated mlflow-environment
        pip install boto3
        ```

 6. Serve the model (replace with your model's actual path)
 for model in Full Path: `s3://mlflow/0/c8eb4035a3c84846a0560aec1a486216/artifacts/NN_Sequential` 
    ```bash
    
    mlflow models serve -m s3://mlflow/0/c8eb4035a3c84846a0560aec1a486216/artifacts/NN_Sequential -p 1234 --env-manager conda
    ```

 7. You can check the input with this command
    ```bash
    curl -X POST -H "Content-Type:application/json; format=pandas-split" --data '{"columns":["alcohol", "chlorides", "citric acid", "density", "fixed acidity", "free sulfur dioxide", "pH", "residual sugar", "sulphates", "total sulfur dioxide", "volatile acidity"],"data":[[12.8, 0.029, 0.48, 0.98, 6.2, 29, 3.33, 1.2, 0.39, 75, 0.66]]}' http://127.0.0.1:1234/invocations
    ```

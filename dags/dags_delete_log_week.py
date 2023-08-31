import pendulum
from datetime import datetime, timedelta

from airflow import DAG
from airflow.operators.bash import BashOperator



with DAG(
    dag_id="dags_delete_log_week",
    schedule="* * * * 5 ",
    start_date=pendulum.datetime(2023,8,1, tz="Asia/Seoul"),
    catchup=False,
    tags=["log", "management"]
) as dag:
       
    delete_log_week = BashOperator(
        task_id ="delete_log_week",
        bash_command="""
        find $AIRFLOW_HOME/logs -type f -mtime +7 -delete 
        && find $AIRFLOW_HOME/logs -type d -empty -delete
        """,
    )
    
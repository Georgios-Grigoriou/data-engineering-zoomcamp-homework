from pathlib import Path
import pandas as pd
from prefect import flow, task
from prefect_gcp.cloud_storage import GcsBucket
from prefect_gcp import GcpCredentials


@task(retries=3)
def extract_from_gcs(color: str, year: int, month: int) -> Path:
    """Download trip data from GCS"""
    gcs_path = f"data/{color}/{color}_tripdata_{year}-{month:02}.parquet"
    gcs_block = GcsBucket.load("zoom-gcs")
    gcs_block.get_directory(from_path=gcs_path, local_path=f"../data/")
    return Path(f"../data/{gcs_path}")

@task(log_prints=True)
def write_bq(df: pd.DataFrame) -> None:
    """Write DataFrame to BiqQuery"""
    gcp_credentials_block = GcpCredentials.load("zoom-gcs-creds")

    df.to_gbq(
        destination_table="dezoomcamp.rides",
        project_id="<project id>",
        credentials=gcp_credentials_block.get_credentials_from_service_account(),
        chunksize=500_000,
        if_exists="append"
    )
    print(f"post: rows: {len(df)}")


@flow(log_prints=True)
def etl_gcs_to_bq(
    months: list[int] = [2, 3], year: int = 2019, color: str = "yellow"
):
    """Main ETL flow to load data into Big Query"""

    total_length=0
    for month in months:
        path = extract_from_gcs(color, year, month)
        df = pd.read_parquet(path)
        total_length+=len(df)
        print(f"total_length: {total_length}")
        write_bq(df)

if __name__ == "__main__":
    months = [2, 3]
    year = 2019
    color = "yellow"
    etl_gcs_to_bq(months,year,color)

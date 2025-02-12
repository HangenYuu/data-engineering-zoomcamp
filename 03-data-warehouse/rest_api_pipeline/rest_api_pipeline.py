import dlt
import pyarrow.parquet as pq
from dlt.sources.helpers import requests
import os
from dlt.common.libs.pyarrow import pyarrow as pa


BATCH_SIZE = 100_000
TAXI_TYPE = "yellow"
YEAR = 2024


def get_taxi_data_url(taxi_type, year, month):
    base_url = "https://d37ci6vzurychx.cloudfront.net/trip-data"
    return f"{base_url}/{taxi_type}_tripdata_{year}-{month:02d}.parquet"


@dlt.source(name="ny_taxi")
def ny_taxi_source(
    taxi_type: str,
    year: str,
    month: str,
):
    @dlt.resource(
        name=f"taxi_data_{taxi_type}",
        file_format="parquet",
        write_disposition="replace",
    )
    def taxi_data_chunker():
        url = get_taxi_data_url(taxi_type, year, month)

        temp_path = f"temp_{taxi_type}_{year}_{month}.parquet"

        with requests.get(url, stream=True) as response:
            response.raise_for_status()

            with open(temp_path, "wb") as f:
                for chunk in response.iter_content(chunk_size=8192):
                    f.write(chunk)

            parquet_file = pq.ParquetFile(temp_path)
            for batch in parquet_file.iter_batches(batch_size=BATCH_SIZE):
                table = pa.Table.from_batches([batch])

                yield table

        os.remove(temp_path)

    resource = taxi_data_chunker

    return resource


def load_nyc_taxi():
    pipeline = dlt.pipeline(
        pipeline_name="rest_api_nyc_taxi",
        destination="filesystem",
        dataset_name="nyc_taxi_yellow",
    )

    for month in range(1, 7):
        load_info = pipeline.run(ny_taxi_source(TAXI_TYPE, YEAR, month))
    print(load_info)


if __name__ == "__main__":
    load_nyc_taxi()

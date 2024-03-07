FROM python:3.9.18

RUN apt-get install wget
RUN pip install pandas sqlalchemy pyarrow psycopg2 --no-cache

WORKDIR /app
COPY data-loading-parquet.py data-loading-parquet.py 

ENTRYPOINT [ "python", "data-loading-parquet.py" ]
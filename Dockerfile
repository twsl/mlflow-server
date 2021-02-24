
FROM continuumio/miniconda3:latest

WORKDIR /app

COPY wait-for-it.sh entrypoint.sh ./
RUN chmod +x wait-for-it.sh entrypoint.sh


RUN conda install -c conda-forge mlflow mlflow-ui-dbg -y
#RUN pip install mlflow

#RUN conda install -c conda-forge \
# https://docs.sqlalchemy.org/en/14/core/engines.html#postgresql
#  psycopg2 pg8000 \
# https://docs.sqlalchemy.org/en/14/core/engines.html#mysql
#  pymysql mysqlclient \
# https://docs.sqlalchemy.org/en/14/core/engines.html#microsoft-sql-server
#  pyodbc pymssql \
# https://docs.sqlalchemy.org/en/14/core/engines.html#sqlite
#  sqlite \
#  -y

RUN pip install \
  # https://pypi.org/project/boto3/
  boto3 \
  # https://docs.sqlalchemy.org/en/14/core/engines.html#postgresql
  psycopg2-binary pg8000 \
  # https://docs.sqlalchemy.org/en/14/core/engines.html#mysql
  pymysql \
  # https://docs.sqlalchemy.org/en/14/core/engines.html#microsoft-sql-server
  #pyodbc \ # fails with error
  pymssql
# https://docs.sqlalchemy.org/en/14/core/engines.html#sqlite
# installed by default

EXPOSE 5000

ENTRYPOINT [ "/app/entrypoint.sh" ]
CMD [ "mlflow", "server", "--backend-store-uri ${CONNECT_STR}", "--default-artifact-root s3://${AWS_BUCKET_NAME}/", "-h 0.0.0.0" ]
#CMD [ "mlflow", "ui", "--backend-store-uri ${CONNECT_STR}", "--default-artifact-root s3://${AWS_BUCKET_NAME}/" ]

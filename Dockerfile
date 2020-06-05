# docker build -t superset .
# docker run -d -p 8088:8088 --name superset superset
# snowflake://<username>:<password>@<account>/<database>/<schema>?role=<role>&warehouse=<warehouse>
FROM python:3.7

RUN apt-get update && apt-get -y install build-essential libssl-dev libffi-dev python-dev python-pip libsasl2-dev libldap2-dev
RUN pip install apache-superset cffi==1.9 snowflake-sqlalchemy \
 && superset db upgrade \
 && superset fab create-admin --username admin --firstname admin --lastname admin --email admin@127.0.0.1 --password admin \
 && superset load_examples \
 && superset init

EXPOSE 8088
CMD superset run --host 0.0.0.0 -p 8088 --with-threads --reload --debugger
FROM 304160530156.dkr.ecr.us-east-1.amazonaws.com/default-build:20.04 as build

RUN apt-get -qq update && apt-get -y --no-install-recommends install libmysqlclient-dev

RUN get-python --prefix=/opt/pypicloud/python --version=2.7.18
ENV PATH=/opt/pypicloud/python/bin:$PATH

COPY requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt

FROM 304160530156.dkr.ecr.us-east-1.amazonaws.com/newscred-ubuntu-2004:latest

RUN apt-get -qq update \
    && apt-get -y --no-install-recommends install libmysqlclient21 \
    && apt-get clean

COPY --from=build /opt/pypicloud/python /opt/pypicloud/python

ENV PATH=/opt/pypicloud/python/bin:$PATH

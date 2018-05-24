FROM envoyproxy/envoy:latest

RUN apt-get update 
RUN apt-get install -qy python3 
RUN apt-get install -qy python3-pip python-dev build-essential
RUN python3 --version && pip3 --version
RUN pip3 install -q Flask==0.11.1 requests==2.18.4
RUN pip3 install ruamel.yaml
RUN apt-get install -qy curl
RUN apt-get install -qy net-tools
RUN apt-get install -qy nano

ENV SERVICE_NAME=PANOS
ENV PORT_V=5000

RUN mkdir /code
WORKDIR /code
COPY ./service.py /code
COPY ./service-envoy.yaml /etc
COPY ./start_service.sh /usr/local/bin/start_service.sh
COPY ./replace.py /code

RUN  python3 ./replace.py
RUN chmod u+x /usr/local/bin/start_service.sh
#RUN sh /usr/local/bin/start_service.sh
#ENTRYPOINT ["python3"]
#CMD ["service.py"]
ENTRYPOINT /usr/local/bin/start_service.sh

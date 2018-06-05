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
RUN apt-get install -qy iptables
RUN apt-get install -qy ipset
RUN apt update

ENV SERVICE_NAME=PANOS
ENV PORT_V=5000

RUN mkdir /code
WORKDIR /code
COPY ./service.py /code
COPY ./service-envoy.yaml /etc
COPY ./start_service.sh /usr/local/bin/start_service.sh
COPY ./replace.py /code
COPY ./blacklist.sh /usr/local/bin/blacklist.sh


RUN python3 ./replace.py
RUN chmod u+x /usr/local/bin/start_service.sh
RUN chmod u+x /usr/local/bin/blacklist.sh

#RUN sh /usr/local/bin/blacklist.sh

#RUN sh /usr/local/bin/start_service.sh
#ENTRYPOINT ["python3"]
#CMD ["service.py"]
#ENTRYPOINT /usr/local/bin/start_service.sh




########################SNORT###################################
# install Snort
RUN apt-get update && \
    apt-get install -y \
        wget \
        build-essential \
        # Pre-requisites for Snort DAQ (Data AcQuisition library)
        bison \
        flex \
        # Pre-Requisites for snort
        libpcap-dev \
        libpcre3-dev \
        libdumbnet-dev \
        zlib1g-dev \

        # Optional libraries that improves fuctionality
        liblzma-dev \
        openssl \
        libssl-dev && \
    rm -rf /var/lib/apt/lists/*

# Define working directory.
RUN mkdir ~/snort_src

# download and install DAQ
RUN cd ~/snort_src \ 
    && wget https://www.snort.org/downloads/snort/daq-2.0.6.tar.gz \
    && tar xvfz daq-2.0.6.tar.gz \
    && cd daq-2.0.6 \
    && ./configure; make; make install

# download and install Snort
RUN cd ~/snort_src \
    && wget https://www.snort.org/downloads/snort/snort-2.9.11.1.tar.gz \
    && tar xvfz snort-2.9.11.1.tar.gz \
    && cd snort-2.9.11.1 \
    && ./configure; make; make install

# update shared libraries
RUN ldconfig

# create a symlink to /usr/sbin/snort:
RUN ln -s /usr/local/bin/snort /usr/sbin/snort

# create a snort user and group
RUN groupadd snort && \
	useradd snort -r -s /sbin/nologin -c SNORT_IDS -g snort

# Create the Snort directories:
RUN mkdir -p /etc/snort && \
	mkdir -p /etc/snort/rules && \
	mkdir -p /etc/snort/rules/iplists && \
	mkdir -p /etc/snort/preproc_rules && \
	mkdir -p /usr/local/lib/snort_dynamicrules && \
	mkdir -p /etc/snort/so_rules && \

	# Create some files that stores rules and ip lists && \
	touch /etc/snort/rules/iplists/black_list.rules && \
	touch /etc/snort/rules/iplists/white_list.rules && \
	touch /etc/snort/rules/local.rules && \
	touch /etc/snort/sid-msg.map && \

	# Create the logging directories:
	mkdir -p /var/log/snort && \
	mkdir -p /var/log/snort/archived_logs && \
 
	# Adjust permissions:
	chmod -R 5775 /etc/snort && \
	chmod -R 5775 /var/log/snort && \
	chmod -R 5775 /var/log/snort/archived_logs && \
	chmod -R 5775 /etc/snort/so_rules && \
	chmod -R 5775 /usr/local/lib/snort_dynamicrules && \
 
	# Change Ownership on folders:
	chown -R snort:snort /etc/snort && \
	chown -R snort:snort /var/log/snort && \
	chown -R snort:snort /usr/local/lib/snort_dynamicrules


# move files to the /etc/snort folder
RUN cd ~/snort_src/snort-2.9.11.1/etc/ && \
	cp *.conf* /etc/snort && \
	cp *.map /etc/snort && \
	cp *.dtd /etc/snort && \
	cd ~/snort_src/snort-2.9.11.1/src/dynamic-preprocessors/build/usr/local/lib/snort_dynamicpreprocessor/ && \
	cp * /usr/local/lib/snort_dynamicpreprocessor/

# copy our snort.conf into the container\
COPY src/snort.conf /etc/snort

# copy our local.rules into the container\
COPY src/local.rules /etc/snort/rules/

# start apache2 and Snort
COPY start_snort_script.sh start_snort_script.sh
#ENTRYPOINT ./start_snort_script.sh

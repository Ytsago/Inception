FROM debian:12

RUN apt update && apt install -y \
	wget

COPY ./content/setup.sh /

RUN chmod +x /setup.sh

ENTRYPOINT ["/bin/bash", "/setup.sh"]

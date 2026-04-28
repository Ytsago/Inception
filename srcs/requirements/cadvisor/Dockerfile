FROM debian:12

RUN apt update && apt install -y \
	curl \
	dmsetup \
	libpfm4

RUN curl -L https://github.com/google/cadvisor/releases/download/v0.56.2/cadvisor-v0.56.2-linux-amd64 -o /usr/bin/cadvisor \
	&& chmod +x /usr/bin/cadvisor

ENTRYPOINT ["/usr/bin/cadvisor", "-logtostderr", "-url_base_prefix=/cadvisor"]

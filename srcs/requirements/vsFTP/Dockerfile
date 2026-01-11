FROM debian:12

RUN apt update && apt install -y \
	vsftpd

COPY ./content/setup.sh /setup.sh

COPY ./content/vsftpd.conf /vsftpd.conf

EXPOSE 21 21100-21110

ENTRYPOINT ["/bin/bash", "setup.sh"]

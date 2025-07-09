FROM        debian:bullseye-slim

RUN         apt update -y && apt upgrade -y
RUN         apt install -y openssl nginx

ENTRYPOINT  ["tail", "-f"]

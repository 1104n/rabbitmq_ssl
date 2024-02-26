FROM rabbitmq:3-management
RUN mkdir /rabbitmq
WORKDIR /rabbitmq
COPY . /rabbitmq/
# Install Vim
RUN apt-get update && apt-get install -y vim
RUN mv conf/rabbitmq.conf /etc/rabbitmq/conf.d/   ##Conf file for SSL encryption

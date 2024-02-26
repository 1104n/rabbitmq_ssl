# rabbitmq_ssl
Enabling SSL for Rabbitmq

To create the .pem files required for RabbitMQ SSL configuration, you typically need to generate SSL certificates. 
You can generate these certificates using OpenSSL, a widely-used tool for creating SSL certificates and keys.

## Here's how you can generate the required .pem files using OpenSSL:

       - openssl req -new -x509 -days 365 -extensions v3_ca -keyout ca.key -out ca.crt

## Here's how you can generate the required .pem files using OpenSSL:

       - openssl req -new -x509 -days 365 -extensions v3_ca -keyout ca.key -out ca.crt

## Server Certificate and Key Signed by the CA: Next, you'll generate a certificate and key for your RabbitMQ server, signed by the CA. Here's how:

       - openssl genrsa -out server/key.pem 2048
       - openssl req -new -key server/key.pem -out server/cert.csr
       - openssl x509 -req -in server/cert.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out server/cert.pem -days 365

This set of commands generates a private key (server/key.pem), a Certificate Signing Request (CSR) (server/cert.csr), and finally, a server certificate signed by the CA (server/cert.pem).

## Concatenating Certificate Chain: Optionally, you might need to concatenate the server certificate and CA certificate into a single .pem file, depending on how RabbitMQ is configured to accept certificates:

       - cat server/cert.pem ca.crt > cert_chain.pem

This command concatenates the server certificate (server/cert.pem) and the CA certificate (ca.crt) into a single file (cert_chain.pem).

## Setting File Permissions: Finally, make sure to set appropriate file permissions to ensure the security of your certificates:
       -  chmod 600 server/key.pem
       -  chmod 644 server/cert.pem ca.crt

This command sets restrictive permissions on the private key (server/key.pem) and more permissive permissions on the server and CA certificates.

With these steps, you should have the necessary .pem files (ca.crt, server/cert.pem, server/key.pem) for RabbitMQ SSL configuration. Make sure to adjust the file paths and names as needed based on your specific requirements and environment.

## Map the cert file inside contianer add it in docker-compose environment tag:
      - rabbitmq_ssl_certfile=/cert_rabbitmq/cert.pem
      - rabbitmq_ssl_keyfile=/cert_rabbitmq/key.pem
      - rabbitmq_ssl_cacertfile=/cert_rabbitmq/ca.crt
## Volumes
      - /etc/ssl/certs/:/cert_rabbitmq
## Moving Rabbitmq Conf file which has SSL File path and Encryption details for SSL. File is located in conf/rabbitmq.conf 
      - RUN mv conf/rabbitmq.conf /etc/rabbitmq/conf.d/

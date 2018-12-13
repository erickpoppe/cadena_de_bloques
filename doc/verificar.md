# Verificación de servicios disponibles desde CLI
## Servicios de Hyperledger Fabric 
Abrir una terminal de de línea de comando para verificar si estan levantados los servicios de Hyperledger Fabric
```sh 
curl -vk -X GET https://DIRECCIÓN-IP-DE-SERVICIO:PUERTO-DEL-SERVICIO 
```
La respuesta positiva, en caso de que los servicios estén levantados para *grpcs* será:
```sh
* TCP_NODELAY set
* Connected to 172.29.0.158 (172.29.0.158) port 7051 (#0)
* ALPN, offering h2
* ALPN, offering http/1.1
* successfully set certificate verify locations:
*   CAfile: /etc/ssl/certs/ca-certificates.crt
  CApath: none
* TLSv1.3 (OUT), TLS handshake, Client hello (1):
* TLSv1.3 (IN), TLS handshake, Server hello (2):
* TLSv1.2 (IN), TLS handshake, Certificate (11):
* TLSv1.2 (IN), TLS handshake, Server key exchange (12):
* TLSv1.2 (IN), TLS handshake, Request CERT (13):
* TLSv1.2 (IN), TLS handshake, Server finished (14):
* TLSv1.2 (OUT), TLS handshake, Certificate (11):
* TLSv1.2 (OUT), TLS handshake, Client key exchange (16):
* TLSv1.2 (OUT), TLS change cipher, Change cipher spec (1):
* TLSv1.2 (OUT), TLS handshake, Finished (20):
* TLSv1.2 (IN), TLS handshake, Finished (20):
* SSL connection using TLSv1.2 / ECDHE-ECDSA-AES256-GCM-SHA384
* ALPN, server accepted to use h2
* Server certificate:
*  subject: C=BO; ST=La Paz; L=La Paz; CN=peer0.agetic.gob.bo
*  start date: Nov 16 21:24:00 2018 GMT
*  expire date: Nov 13 21:24:00 2028 GMT
*  issuer: C=BO; ST=La Paz; L=La Paz; O=agetic.gob.bo; CN=tlsca.agetic.gob.bo
*  SSL certificate verify result: unable to get local issuer certificate (20), continuing anyway.
* Using HTTP2, server supports multi-use
* Connection state changed (HTTP/2 confirmed)
* Copying HTTP/2 data in stream buffer to connection buffer after upgrade: len=0
* Using Stream ID: 1 (easy handle 0x55c8f60a5e70)
> GET / HTTP/2
> Host: 172.29.0.158:7051
> User-Agent: curl/7.62.0
> Accept: */*
> 
* Connection state changed (MAX_CONCURRENT_STREAMS == 4294967295)!
< HTTP/2 200 
< content-type: application/grpc
< grpc-status: 8
< grpc-message: malformed method name: "/"
```   
En la respuesta se puede apreciar la respuesta positiva "HTTP/2 200" y el mensaje de malformación del método del mensaje grpc, lo cuál es normal ya que solo se esta probando la existencia del servicio.

## Otros casos:

La respuesta positiva es diferente para el caso de un servicio que no está en *grpcs* sino simplemente en HTTPS, como es el caso de la autoridad de certificación:
```sh 
*   Trying 172.29.0.155...
* TCP_NODELAY set
* Connected to 172.29.0.155 (172.29.0.155) port 7054 (#0)
* ALPN, offering h2
* ALPN, offering http/1.1
* successfully set certificate verify locations:
*   CAfile: /etc/ssl/certs/ca-certificates.crt
  CApath: none
* TLSv1.3 (OUT), TLS handshake, Client hello (1):
* TLSv1.3 (IN), TLS handshake, Server hello (2):
* TLSv1.2 (IN), TLS handshake, Certificate (11):
* TLSv1.2 (IN), TLS handshake, Server key exchange (12):
* TLSv1.2 (IN), TLS handshake, Server finished (14):
* TLSv1.2 (OUT), TLS handshake, Client key exchange (16):
* TLSv1.2 (OUT), TLS change cipher, Change cipher spec (1):
* TLSv1.2 (OUT), TLS handshake, Finished (20):
* TLSv1.2 (IN), TLS handshake, Finished (20):
* SSL connection using TLSv1.2 / ECDHE-ECDSA-AES256-GCM-SHA384
* ALPN, server did not agree to a protocol
* Server certificate:
*  subject: C=US; ST=California; L=San Francisco; O=agetic.gob.bo; CN=ca.agetic.gob.bo
*  start date: Nov 16 21:24:00 2018 GMT
*  expire date: Nov 13 21:24:00 2028 GMT
*  issuer: C=US; ST=California; L=San Francisco; O=agetic.gob.bo; CN=ca.agetic.gob.bo
*  SSL certificate verify result: self signed certificate (18), continuing anyway.
> GET / HTTP/1.1
> Host: 172.29.0.155:7054
> User-Agent: curl/7.62.0
> Accept: */*
> 
< HTTP/1.1 404 Not Found
< Content-Type: text/plain; charset=utf-8
< X-Content-Type-Options: nosniff
< Date: Tue, 11 Dec 2018 13:57:06 GMT
< Content-Length: 19
< 
404 page not found
* Connection #0 to host 172.29.0.155 left intact
``` 
En este caso se aprecia la respuesta de "404 page not found" que nos indica que el servicio está levantado. (No existe una página, pero si el servicio levantado)

##### NOTA.- Cuando los servicios no están levantados correctamente, la respuesta no concluye o se recibe una respuesta negativa de conexión denegada.